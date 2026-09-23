import {
  BookModel,
  BookHistoryModel,
  LabaCompilationModel,
  LabaCategoryModel,
  LabaItemModel,
  ModalModel,
  NeracaModel,
  NeracaSaldoModel,
  TransactionModel,
  HartaTransactionModel,
} from '../types';

/**
 * Calculate total assets (all accounts starting with '1')
 * Debit increases assets (+), Credit decreases assets (-)
 */
export function calculateTotalAsset(transactions: TransactionModel[]): number {
  let total = 0;
  for (const tx of transactions) {
    if (tx.debitCode.startsWith('1')) {
      total += tx.nominal;
    }
    if (tx.creditCode.startsWith('1')) {
      total -= tx.nominal;
    }
  }
  return total;
}

/**
 * Calculate Laba Rugi (Profit & Loss / Income Statement)
 * - 4-xxxx: Pendapatan Penjualan (Credit)
 * - 5-xxxx (except 5-1700): Beban Operasional (Debit)
 * - 5-1700: Beban Lainnya (Debit)
 */
export function calculateLabaRugi(transactions: TransactionModel[]): LabaCompilationModel {
  const pendapatanItems: LabaItemModel[] = [];
  const bebanOperasionalItems: LabaItemModel[] = [];
  const bebanLainnyaItems: LabaItemModel[] = [];

  for (const tx of transactions) {
    // Pendapatan (Credit code starts with 4)
    if (tx.creditCode.startsWith('4')) {
      const idx = pendapatanItems.findIndex((it) => it.code === tx.creditCode);
      if (idx >= 0) {
        pendapatanItems[idx].amount += tx.nominal;
      } else {
        pendapatanItems.push({
          code: tx.creditCode,
          name: tx.creditName,
          amount: tx.nominal,
        });
      }
    }

    // Beban (Debit code starts with 5)
    if (tx.debitCode.startsWith('5')) {
      if (tx.debitCode === '5-1700') {
        const idx = bebanLainnyaItems.findIndex((it) => it.code === tx.debitCode);
        if (idx >= 0) {
          bebanLainnyaItems[idx].amount += tx.nominal;
        } else {
          bebanLainnyaItems.push({
            code: tx.debitCode,
            name: tx.debitName,
            amount: tx.nominal,
          });
        }
      } else {
        const idx = bebanOperasionalItems.findIndex((it) => it.code === tx.debitCode);
        if (idx >= 0) {
          bebanOperasionalItems[idx].amount += tx.nominal;
        } else {
          bebanOperasionalItems.push({
            code: tx.debitCode,
            name: tx.debitName,
            amount: tx.nominal,
          });
        }
      }
    }
  }

  const sumItems = (items: LabaItemModel[]) => items.reduce((s, it) => s + it.amount, 0);

  const pendapatanCat: LabaCategoryModel = {
    name: 'Pendapatan dari Penjualan',
    items: pendapatanItems,
    totalAmount: sumItems(pendapatanItems),
  };

  const bebanOperasionalCat: LabaCategoryModel = {
    name: 'Beban Operasional',
    items: bebanOperasionalItems,
    totalAmount: sumItems(bebanOperasionalItems),
  };

  const bebanLainnyaCat: LabaCategoryModel = {
    name: 'Beban Lainnya',
    items: bebanLainnyaItems,
    totalAmount: sumItems(bebanLainnyaItems),
  };

  const cleanResult =
    pendapatanCat.totalAmount - bebanOperasionalCat.totalAmount - bebanLainnyaCat.totalAmount;

  return {
    pendapatanDariPenjualan: pendapatanCat,
    bebanOperasional: bebanOperasionalCat,
    bebanLainya: bebanLainnyaCat,
    cleanResult,
  };
}

/**
 * Calculate General Ledger (Buku Besar)
 * Groups by account code, with chronological history and running balances.
 */
export function calculateBukuBesar(transactions: TransactionModel[]): BookModel[] {
  const booksMap: Map<string, { code: string; account: string; history: BookHistoryModel[] }> = new Map();

  // Sort transactions chronologically
  const sorted = [...transactions].sort((a, b) => a.date - b.date);

  for (const tx of sorted) {
    // Debit entry
    if (!booksMap.has(tx.debitCode)) {
      booksMap.set(tx.debitCode, {
        code: tx.debitCode,
        account: tx.debitName,
        history: [],
      });
    }
    booksMap.get(tx.debitCode)!.history.push({
      dateTime: tx.date,
      debit: tx.nominal,
      kredit: 0,
      notes: `${tx.transactionName}: ${tx.notes}`,
    });

    // Credit entry
    if (!booksMap.has(tx.creditCode)) {
      booksMap.set(tx.creditCode, {
        code: tx.creditCode,
        account: tx.creditName,
        history: [],
      });
    }
    booksMap.get(tx.creditCode)!.history.push({
      dateTime: tx.date,
      debit: 0,
      kredit: tx.nominal,
      notes: `${tx.transactionName}: ${tx.notes}`,
    });
  }

  const result: BookModel[] = [];

  booksMap.forEach((val) => {
    let running = 0;
    let totalDebit = 0;
    let totalKredit = 0;

    const isDebitNormal = val.code.startsWith('1') || val.code.startsWith('5');

    val.history.forEach((h) => {
      totalDebit += h.debit;
      totalKredit += h.kredit;
      if (isDebitNormal) {
        running += h.debit - h.kredit;
      } else {
        running += h.kredit - h.debit;
      }
      h.runningBalance = running;
    });

    result.push({
      code: val.code,
      account: val.account,
      history: val.history,
      totalDebit,
      totalKredit,
      endingBalance: running,
    });
  });

  // Sort by account code
  return result.sort((a, b) => a.code.localeCompare(b.code));
}

/**
 * Calculate Neraca Saldo (Trial Balance) from Buku Besar
 */
export function calculateNeracaSaldo(books: BookModel[]): {
  items: NeracaSaldoModel[];
  totalDebit: number;
  totalCredit: number;
} {
  let totalDebit = 0;
  let totalCredit = 0;

  const items: NeracaSaldoModel[] = books.map((b) => {
    const debit = b.history.reduce((sum, h) => sum + h.debit, 0);
    const credit = b.history.reduce((sum, h) => sum + h.kredit, 0);
    totalDebit += debit;
    totalCredit += credit;

    return {
      accountCode: b.code,
      accountName: b.account,
      debit,
      credit,
    };
  });

  return { items, totalDebit, totalCredit };
}

/**
 * Calculate Perubahan Modal (Statement of Changes in Equity)
 */
export function calculatePerubahanModal(
  allTransactions: TransactionModel[],
  selectedDate: Date
): ModalModel {
  const selectedDateEnd = new Date(
    selectedDate.getFullYear(),
    selectedDate.getMonth(),
    selectedDate.getDate(),
    23,
    59,
    59,
    999
  ).getTime();

  const selectedDateStart = new Date(
    selectedDate.getFullYear(),
    selectedDate.getMonth(),
    selectedDate.getDate(),
    0,
    0,
    0,
    0
  ).getTime();

  // Transactions before selected day
  const pastTx = allTransactions.filter((tx) => tx.date < selectedDateStart);
  // Transactions on selected day
  const currentDayTx = allTransactions.filter(
    (tx) => tx.date >= selectedDateStart && tx.date <= selectedDateEnd
  );

  const pastLaba = calculateLabaRugi(pastTx).cleanResult;
  const currentLaba = calculateLabaRugi(currentDayTx).cleanResult;

  let pastModalAdd = 0;
  let pastModalTake = 0;

  for (const tx of pastTx) {
    if (tx.creditCode.startsWith('3')) {
      pastModalAdd += tx.nominal;
    }
    if (tx.debitCode.startsWith('3')) {
      pastModalTake += tx.nominal;
    }
  }

  const modalAwal = pastModalAdd - pastModalTake + pastLaba;

  const addedModal: TransactionModel[] = [];
  const takedModal: TransactionModel[] = [];

  for (const tx of currentDayTx) {
    if (tx.creditCode.startsWith('3')) {
      addedModal.push(tx);
    }
    if (tx.debitCode.startsWith('3')) {
      takedModal.push(tx);
    }
  }

  const addedModalAmount = addedModal.reduce((s, tx) => s + tx.nominal, 0);
  const takedModalAmount = takedModal.reduce((s, tx) => s + tx.nominal, 0);

  const getModalAkhir = modalAwal + currentLaba + addedModalAmount - takedModalAmount;

  return {
    modalAwal,
    cleanLaba: currentLaba,
    addedModal,
    takedModal,
    addedModalAmount,
    takedModalAmount,
    getModalAkhir,
  };
}

/**
 * Calculate Neraca (Balance Sheet)
 * - Aktiva (1-xxxx): Kas, Bank, Piutang, Persediaan, Peralatan, dll.
 * - Kewajiban (2-xxxx): Utang Usaha, Utang Bank, dll.
 * - Ekuitas (3-xxxx): Modal Pemilik, Prive + Laba Bersih
 */
export function calculateNeraca(
  allTransactions: TransactionModel[],
  asOfDate: Date = new Date()
): NeracaModel {
  const asOfTime = new Date(
    asOfDate.getFullYear(),
    asOfDate.getMonth(),
    asOfDate.getDate(),
    23,
    59,
    59,
    999
  ).getTime();

  const relevantTx = allTransactions.filter((tx) => tx.date <= asOfTime);

  // 1: Harta Lancar & Tetap
  const hartaMap = new Map<string, HartaTransactionModel>();
  for (const tx of relevantTx) {
    if (tx.debitCode.startsWith('1')) {
      const existing = hartaMap.get(tx.debitCode);
      if (existing) {
        existing.nominal += tx.nominal;
      } else {
        hartaMap.set(tx.debitCode, {
          code: tx.debitCode,
          name: tx.debitName,
          nominal: tx.nominal,
        });
      }
    }
    if (tx.creditCode.startsWith('1')) {
      const existing = hartaMap.get(tx.creditCode);
      if (existing) {
        existing.nominal -= tx.nominal;
      } else {
        hartaMap.set(tx.creditCode, {
          code: tx.creditCode,
          name: tx.creditName,
          nominal: -tx.nominal,
        });
      }
    }
  }

  // 2: Hutang / Kewajiban
  const hutangMap = new Map<string, HartaTransactionModel>();
  for (const tx of relevantTx) {
    if (tx.creditCode.startsWith('2')) {
      const existing = hutangMap.get(tx.creditCode);
      if (existing) {
        existing.nominal += tx.nominal;
      } else {
        hutangMap.set(tx.creditCode, {
          code: tx.creditCode,
          name: tx.creditName,
          nominal: tx.nominal,
        });
      }
    }
    if (tx.debitCode.startsWith('2')) {
      const existing = hutangMap.get(tx.debitCode);
      if (existing) {
        existing.nominal -= tx.nominal;
      } else {
        hutangMap.set(tx.debitCode, {
          code: tx.debitCode,
          name: tx.debitName,
          nominal: -tx.nominal,
        });
      }
    }
  }

  // 3: Modal
  const modalMap = new Map<string, HartaTransactionModel>();
  for (const tx of relevantTx) {
    if (tx.creditCode.startsWith('3')) {
      const existing = modalMap.get(tx.creditCode);
      if (existing) {
        existing.nominal += tx.nominal;
      } else {
        modalMap.set(tx.creditCode, {
          code: tx.creditCode,
          name: tx.creditName,
          nominal: tx.nominal,
        });
      }
    }
    if (tx.debitCode.startsWith('3')) {
      const existing = modalMap.get(tx.debitCode);
      if (existing) {
        existing.nominal -= tx.nominal;
      } else {
        modalMap.set(tx.debitCode, {
          code: tx.debitCode,
          name: tx.debitName,
          nominal: -tx.nominal,
        });
      }
    }
  }

  // Laba bersih sampai periode neraca
  const labaRugi = calculateLabaRugi(relevantTx).cleanResult;

  const hartaLancarList = Array.from(hartaMap.values());
  const hutangList = Array.from(hutangMap.values());
  const modalList = Array.from(modalMap.values());

  const hartaLancarTotal = hartaLancarList.reduce((s, it) => s + it.nominal, 0);
  const hutangTotal = hutangList.reduce((s, it) => s + it.nominal, 0);
  const modalTotal = modalList.reduce((s, it) => s + it.nominal, 0) + labaRugi;

  return {
    hartaLancarList,
    hutangList,
    modalList,
    labaRugi,
    hartaLancarTotal,
    hutangTotal,
    modalTotal,
  };
}
