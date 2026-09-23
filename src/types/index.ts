export interface TransactionModel {
  id: string;
  creditCode: string;
  creditName: string;
  date: number; // milliseconds since epoch
  debitCode: string;
  debitName: string;
  imageUrl?: string;
  nominal: number;
  notes: string;
  transactionId: number;
  transactionName: string;
  index?: number;
}

export interface AccountModel {
  code: string;
  name: string;
  category?: 'harta' | 'kewajiban' | 'modal' | 'pendapatan' | 'beban';
}

export interface TransactionTypeModel {
  id: number;
  name: string;
  description?: string;
}

export interface UserModel {
  id: string;
  name: string;
  email: string;
  phoneNumber: string;
  address: string;
  imageUrl: string;
  joinedAt: number;
}

export type FilterMode =
  | 'today'
  | 'yesterday'
  | 'last7Days'
  | 'last30Days'
  | 'thisMonth'
  | 'lastMonth'
  | 'selectMonth'
  | 'selectRangeDate'
  | 'selectRangeMonth'
  | 'selectDay';

export interface BookHistoryModel {
  dateTime: number;
  debit: number;
  kredit: number;
  notes?: string;
  runningBalance?: number;
}

export interface BookModel {
  code: string;
  account: string;
  history: BookHistoryModel[];
  totalDebit?: number;
  totalKredit?: number;
  endingBalance?: number;
}

export interface NeracaSaldoModel {
  accountName: string;
  accountCode: string;
  debit: number;
  credit: number;
}

export interface LabaItemModel {
  code: string;
  name: string;
  amount: number;
}

export interface LabaCategoryModel {
  name: string;
  items: LabaItemModel[];
  totalAmount: number;
}

export interface LabaCompilationModel {
  pendapatanDariPenjualan: LabaCategoryModel;
  bebanOperasional: LabaCategoryModel;
  bebanLainya: LabaCategoryModel;
  cleanResult: number;
}

export interface ModalModel {
  modalAwal: number;
  cleanLaba: number;
  addedModal: TransactionModel[];
  takedModal: TransactionModel[];
  addedModalAmount: number;
  takedModalAmount: number;
  getModalAkhir: number;
}

export interface HartaTransactionModel {
  code: string;
  name: string;
  nominal: number;
}

export interface NeracaModel {
  hartaLancarList: HartaTransactionModel[];
  hutangList: HartaTransactionModel[];
  modalList: HartaTransactionModel[];
  labaRugi: number;
  hartaLancarTotal: number;
  hutangTotal: number;
  modalTotal: number;
}
