import { TransactionModel } from '../types';
import { INITIAL_ACCOUNTS } from '../constants/accounts';

function parseDateString(raw: string): number {
  if (!raw) return Date.now();
  const cleaned = raw.trim();

  // Try standard timestamp
  const ts = Date.parse(cleaned);
  if (!isNaN(ts)) return ts;

  // Handle Indonesian month names: "15 September 2026", "1 Sep 2026"
  const indonesianMonths: Record<string, number> = {
    jan: 0, januari: 0,
    feb: 1, februari: 1,
    mar: 2, maret: 2,
    apr: 3, april: 3,
    mei: 4, may: 4,
    jun: 5, juni: 5,
    jul: 6, juli: 6,
    agu: 7, agustus: 7, aug: 7,
    sep: 8, september: 8,
    okt: 9, oktober: 9, oct: 9,
    nov: 10, november: 10,
    des: 11, desember: 11, dec: 11,
  };

  const wordMatch = cleaned.match(/^(\d{1,2})\s+([a-zA-Z]+)\s+(\d{4})/);
  if (wordMatch) {
    const day = parseInt(wordMatch[1], 10);
    const mStr = wordMatch[2].toLowerCase();
    const year = parseInt(wordMatch[3], 10);
    const mIdx = indonesianMonths[mStr] ?? indonesianMonths[mStr.slice(0, 3)];
    if (mIdx !== undefined) {
      return new Date(year, mIdx, day, 12, 0).getTime();
    }
  }

  // Handle DD/MM/YYYY, DD-MM-YYYY, YYYY-MM-DD
  const parts = cleaned.split(/[-/.]/);
  if (parts.length === 3) {
    if (parts[0].length === 4) {
      // YYYY-MM-DD
      const year = parseInt(parts[0], 10);
      const month = parseInt(parts[1], 10) - 1;
      const day = parseInt(parts[2], 10);
      if (!isNaN(day) && !isNaN(month) && !isNaN(year)) {
        return new Date(year, month, day, 12, 0).getTime();
      }
    } else {
      // DD-MM-YYYY
      const day = parseInt(parts[0], 10);
      const month = parseInt(parts[1], 10) - 1;
      const year = parseInt(parts[2], 10);
      if (!isNaN(day) && !isNaN(month) && !isNaN(year)) {
        return new Date(year < 100 ? 2000 + year : year, month, day, 12, 0).getTime();
      }
    }
  }

  return Date.now();
}

function cleanNominal(str: string): number {
  if (!str) return 0;
  // Remove non-numeric except digits, comma, period, minus
  let s = str.trim().replace(/^Rp\.?\s*/i, '').replace(/\s+/g, '');
  if (!s || s === '-' || s === '–') return 0;

  // Handle Indonesian 20.000.000,00 vs international 20,000,000.00
  if (s.includes('.') && s.includes(',')) {
    if (s.lastIndexOf(',') > s.lastIndexOf('.')) {
      // European / Indonesian: 20.000.000,00
      s = s.replace(/\./g, '').replace(',', '.');
    } else {
      // US: 20,000,000.00
      s = s.replace(/,/g, '');
    }
  } else if (s.includes('.')) {
    // Check if period is thousand separator (e.g., 20.000 or 20.000.000)
    const parts = s.split('.');
    if (parts.length > 2 || (parts.length === 2 && parts[1].length === 3)) {
      s = s.replace(/\./g, '');
    }
  } else if (s.includes(',')) {
    const parts = s.split(',');
    if (parts.length > 2 || (parts.length === 2 && parts[1].length === 3)) {
      s = s.replace(/,/g, '');
    } else {
      s = s.replace(',', '.');
    }
  }

  const num = parseFloat(s);
  return isNaN(num) ? 0 : Math.abs(num);
}

function findAccountInfo(text: string, codeHint?: string): { code: string; name: string } {
  if (codeHint && codeHint.trim()) {
    const exact = INITIAL_ACCOUNTS.find((a) => a.code === codeHint.trim());
    if (exact) return { code: exact.code, name: exact.name };
  }

  const cleanText = (text || '').trim().toLowerCase();
  if (!cleanText) return { code: '1-1100', name: 'Kas' };

  // Try matching code directly in text
  for (const acc of INITIAL_ACCOUNTS) {
    if (cleanText.includes(acc.code.toLowerCase())) {
      return { code: acc.code, name: acc.name };
    }
  }

  // Try matching name in text
  for (const acc of INITIAL_ACCOUNTS) {
    const accName = acc.name.toLowerCase();
    if (cleanText.includes(accName) || accName.includes(cleanText)) {
      return { code: acc.code, name: acc.name };
    }
  }

  // Common keywords
  if (cleanText.includes('kas') && (cleanText.includes('bank') || cleanText.includes('rekening') || cleanText.includes('bri'))) {
    return { code: '1-1200', name: 'Kas di Bank (Rekening Usaha)' };
  }
  if (cleanText.includes('kas')) return { code: '1-1100', name: 'Kas' };
  if (cleanText.includes('piutang')) return { code: '1-1300', name: 'Piutang Usaha' };
  if (cleanText.includes('komputer') || cleanText.includes('peralatan') || cleanText.includes('laptop')) {
    return { code: '1-2100', name: 'Peralatan Komputer & Perangkat Dev' };
  }
  if (cleanText.includes('aset') || cleanText.includes('software') || cleanText.includes('engine') || cleanText.includes('plugin')) {
    return { code: '1-1500', name: 'Aset Digital & Lisensi Game Engine' };
  }
  if (cleanText.includes('modal') || cleanText.includes('p2mw') || cleanText.includes('hibah')) {
    return { code: '3-1100', name: 'Modal Pemilik & Hibah P2MW' };
  }
  if (cleanText.includes('prive')) return { code: '3-1200', name: 'Prive Pemilik (Luky Adithia)' };
  if (cleanText.includes('utang') || cleanText.includes('hutang')) return { code: '2-1100', name: 'Utang Usaha' };
  if (cleanText.includes('penjualan') || cleanText.includes('game') || cleanText.includes('in-app')) {
    return { code: '4-1100', name: 'Pendapatan Penjualan Game & In-App Purchase' };
  }
  if (cleanText.includes('lisensi') || cleanText.includes('pelatihan') || cleanText.includes('institusi')) {
    return { code: '4-1200', name: 'Pendapatan Lisensi & Modul Pelatihan Institusi' };
  }
  if (cleanText.includes('merchandise') || cleanText.includes('workshop')) {
    return { code: '4-1300', name: 'Pendapatan Merchandise & Workshop Forensik' };
  }
  if (cleanText.includes('server') || cleanText.includes('cloud') || cleanText.includes('hosting') || cleanText.includes('firebase')) {
    return { code: '5-1100', name: 'Beban Server Cloud & Database Hosting' };
  }
  if (cleanText.includes('google') || cleanText.includes('play') || cleanText.includes('console')) {
    return { code: '5-1200', name: 'Beban Pendaftaran Developer & Lisensi Google Play' };
  }
  if (cleanText.includes('iklan') || cleanText.includes('promosi') || cleanText.includes('pemasaran')) {
    return { code: '5-1300', name: 'Beban Pemasaran, Iklan & Promosi Game' };
  }
  if (cleanText.includes('honor') || cleanText.includes('gaji') || cleanText.includes('upah') || cleanText.includes('riset')) {
    return { code: '5-1400', name: 'Beban Honorarium Tim Riset Forensik & Dev' };
  }
  if (cleanText.includes('internet') || cleanText.includes('listrik') || cleanText.includes('utilitas')) {
    return { code: '5-1500', name: 'Beban Internet, Listrik & Utilitas Studio' };
  }

  return { code: codeHint || '1-1100', name: text || 'Kas' };
}

/**
 * Parses CSV text into TransactionModel items
 */
export function parseTransactionsFromCsv(csvText: string): {
  success: boolean;
  transactions: TransactionModel[];
  error?: string;
} {
  try {
    if (!csvText || !csvText.trim()) {
      return { success: false, transactions: [], error: 'Berkas atau teks CSV kosong.' };
    }

    const lines = csvText
      .split(/\r?\n/)
      .map((l) => l.trim())
      .filter((l) => l.length > 0);

    if (lines.length < 2) {
      return { success: false, transactions: [], error: 'Berkas CSV tidak memiliki baris data yang cukup.' };
    }

    // Determine delimiter (tab, semicolon, or comma)
    const firstFewLines = lines.slice(0, 3).join('\n');
    let delimiter = ',';
    if (firstFewLines.includes('\t')) {
      delimiter = '\t';
    } else if (firstFewLines.includes(';')) {
      delimiter = ';';
    }

    const parseLine = (line: string): string[] => {
      const result: string[] = [];
      let current = '';
      let insideQuote = false;

      for (let i = 0; i < line.length; i++) {
        const char = line[i];
        if (char === '"') {
          insideQuote = !insideQuote;
        } else if (char === delimiter && !insideQuote) {
          result.push(current.trim().replace(/^"|"$/g, '').trim());
          current = '';
        } else {
          current += char;
        }
      }
      result.push(current.trim().replace(/^"|"$/g, '').trim());
      return result;
    };

    // Find header line (some files have title rows on lines 0 or 1)
    let headerLineIdx = 0;
    for (let i = 0; i < Math.min(lines.length, 5); i++) {
      const parsedCols = parseLine(lines[i]).map((h) => h.toLowerCase());
      if (
        parsedCols.some(
          (c) =>
            c.includes('tanggal') ||
            c.includes('tgl') ||
            c.includes('debit') ||
            c.includes('debet') ||
            c.includes('kredit') ||
            c.includes('akun') ||
            c.includes('nominal')
        )
      ) {
        headerLineIdx = i;
        break;
      }
    }

    const header = parseLine(lines[headerLineIdx]).map((h) => h.toLowerCase());

    // Check if this is the traditional 2-column Debit/Credit journal
    const isDebetCol = header.findIndex((h) => h.includes('debit') || h.includes('debet'));
    const isKreditCol = header.findIndex((h) => h.includes('kredit') || h.includes('credit'));
    const isSingleRowWide =
      (header.some((h) => h.includes('kode debit') || h.includes('debit code')) &&
        header.some((h) => h.includes('kode kredit') || h.includes('credit code'))) ||
      header.some((h) => h.includes('akun debit') || h.includes('debit akun'));

    const parsed: TransactionModel[] = [];

    if (!isSingleRowWide && isDebetCol !== -1 && isKreditCol !== -1) {
      // TRADITIONAL JOURNAL FORMAT:
      // Rows pair: Debit line followed by Credit line
      const dateIdx = header.findIndex((h) => h.includes('tanggal') || h.includes('tgl') || h.includes('date'));
      const descIdx = header.findIndex(
        (h) => h.includes('keterangan') || h.includes('akun') || h.includes('nama') || h.includes('transaksi')
      );
      const refIdx = header.findIndex((h) => h.includes('ref') || h.includes('kode'));

      let currentDate = Date.now();
      let pendingDebit: { date: number; name: string; code: string; nominal: number; notes: string } | null = null;

      for (let i = headerLineIdx + 1; i < lines.length; i++) {
        const cols = parseLine(lines[i]);
        if (cols.length < 2) continue;

        const rawDate = dateIdx !== -1 ? cols[dateIdx] : '';
        if (rawDate && rawDate.trim() && rawDate.trim() !== '-') {
          currentDate = parseDateString(rawDate);
        }

        const desc = descIdx !== -1 && cols[descIdx] ? cols[descIdx] : cols[1] || '';
        const ref = refIdx !== -1 && cols[refIdx] ? cols[refIdx] : '';
        const debitVal = cleanNominal(cols[isDebetCol] || '0');
        const creditVal = cleanNominal(cols[isKreditCol] || '0');

        // Skip purely total rows
        if (desc.toLowerCase().includes('total') || desc.toLowerCase().includes('jumlah')) {
          continue;
        }

        if (debitVal > 0) {
          const acc = findAccountInfo(desc, ref);
          pendingDebit = {
            date: currentDate,
            name: acc.name,
            code: acc.code,
            nominal: debitVal,
            notes: desc,
          };
        } else if (creditVal > 0 && pendingDebit) {
          const accCredit = findAccountInfo(desc, ref);
          parsed.push({
            id: `tx_import_${Date.now()}_${parsed.length + 1}`,
            transactionId: parsed.length + 1,
            transactionName: pendingDebit.name + ' ke ' + accCredit.name,
            debitCode: pendingDebit.code,
            debitName: pendingDebit.name,
            creditCode: accCredit.code,
            creditName: accCredit.name,
            nominal: Math.min(pendingDebit.nominal, creditVal) || creditVal,
            date: pendingDebit.date,
            notes: `${pendingDebit.notes} / ${desc}`,
          });
          pendingDebit = null;
        } else if (debitVal === 0 && creditVal === 0 && desc && parsed.length > 0) {
          // Additional explanation line
          const last = parsed[parsed.length - 1];
          if (last) {
            last.notes = `${last.notes} (${desc})`;
          }
        }
      }
    } else {
      // WIDE ROW FORMAT (Single row per transaction)
      const dateIdx = header.findIndex((h) => h.includes('tanggal') || h.includes('date') || h.includes('tgl'));
      const nameIdx = header.findIndex(
        (h) => h.includes('transaksi') || h.includes('nama') || h.includes('name') || h.includes('jenis')
      );
      const debitCodeIdx = header.findIndex(
        (h) => (h.includes('debit') || h.includes('debet')) && (h.includes('kode') || h.includes('code') || h.includes('ref'))
      );
      const debitNameIdx = header.findIndex(
        (h) => (h.includes('debit') || h.includes('debet')) && (h.includes('akun') || h.includes('nama') || !h.includes('kode'))
      );
      const creditCodeIdx = header.findIndex(
        (h) => (h.includes('kredit') || h.includes('credit')) && (h.includes('kode') || h.includes('code') || h.includes('ref'))
      );
      const creditNameIdx = header.findIndex(
        (h) => (h.includes('kredit') || h.includes('credit')) && (h.includes('akun') || h.includes('nama') || !h.includes('kode'))
      );
      const nominalIdx = header.findIndex(
        (h) => h.includes('nominal') || h.includes('jumlah') || h.includes('amount') || h.includes('total')
      );
      const notesIdx = header.findIndex(
        (h) => h.includes('catatan') || h.includes('keterangan') || h.includes('notes') || h.includes('memo')
      );

      for (let i = headerLineIdx + 1; i < lines.length; i++) {
        const cols = parseLine(lines[i]);
        if (cols.length < 2) continue;

        let txDate = Date.now();
        if (dateIdx !== -1 && cols[dateIdx]) {
          txDate = parseDateString(cols[dateIdx]);
        }

        let rawNominal = 0;
        if (nominalIdx !== -1 && cols[nominalIdx]) {
          rawNominal = cleanNominal(cols[nominalIdx]);
        }

        if (rawNominal <= 0) {
          for (const col of cols) {
            const num = cleanNominal(col);
            if (num > 1000) {
              rawNominal = num;
              break;
            }
          }
        }

        const rawDebCode = debitCodeIdx !== -1 ? cols[debitCodeIdx] : '';
        const rawDebName = debitNameIdx !== -1 ? cols[debitNameIdx] : '';
        const debAcc = findAccountInfo(rawDebName, rawDebCode);

        const rawCredCode = creditCodeIdx !== -1 ? cols[creditCodeIdx] : '';
        const rawCredName = creditNameIdx !== -1 ? cols[creditNameIdx] : '';
        const credAcc = findAccountInfo(rawCredName, rawCredCode);

        const txName =
          nameIdx !== -1 && cols[nameIdx]
            ? cols[nameIdx]
            : `${debAcc.name} / ${credAcc.name}`;
        const txNotes = notesIdx !== -1 && cols[notesIdx] ? cols[notesIdx] : cols[1] || 'Transaksi siklus akuntansi';

        parsed.push({
          id: `tx_import_${Date.now()}_${i}`,
          transactionId: i,
          transactionName: txName,
          debitCode: debAcc.code,
          debitName: debAcc.name,
          creditCode: credAcc.code,
          creditName: credAcc.name,
          nominal: rawNominal,
          date: txDate,
          notes: txNotes,
        });
      }
    }

    if (parsed.length === 0) {
      return { success: false, transactions: [], error: 'Tidak ditemukan transaksi valid di dalam berkas CSV.' };
    }

    return { success: true, transactions: parsed };
  } catch (err: unknown) {
    return { success: false, transactions: [], error: (err as Error)?.message || 'Format CSV tidak valid.' };
  }
}

/**
 * Exports current transactions to CSV string
 */
export function exportTransactionsToCsv(transactions: TransactionModel[]): string {
  const headers = [
    'Tanggal',
    'Nama Transaksi',
    'Kode Debit',
    'Akun Debit',
    'Kode Kredit',
    'Akun Kredit',
    'Nominal',
    'Catatan / Keterangan',
  ];

  const escapeCol = (val: string | number) => {
    const s = String(val).replace(/"/g, '""');
    return `"${s}"`;
  };

  const rows = transactions.map((t) => {
    const dateFormatted = new Date(t.date).toISOString().slice(0, 10);
    return [
      escapeCol(dateFormatted),
      escapeCol(t.transactionName),
      escapeCol(t.debitCode),
      escapeCol(t.debitName),
      escapeCol(t.creditCode),
      escapeCol(t.creditName),
      escapeCol(t.nominal),
      escapeCol(t.notes),
    ].join(',');
  });

  return [headers.join(','), ...rows].join('\n');
}
