import { TransactionModel, UserModel } from '../types';

export const INITIAL_USER: UserModel = {
  id: 'usr_sikez_01',
  name: 'Alex Pratama (SiKeZ)',
  email: 'sikez@unej.ac.id',
  phoneNumber: '081234567890',
  address: 'Jember, Jawa Timur',
  imageUrl: 'https://images.unsplash.com/photo-1544717305-2782549b5136?w=400&auto=format&fit=crop&q=80',
  joinedAt: Date.now() - 90 * 24 * 60 * 60 * 1000,
};

// Generate realistic transactions across previous month and current month
const now = new Date();
const currentYear = now.getFullYear();
const currentMonth = now.getMonth();

export const INITIAL_TRANSACTIONS: TransactionModel[] = [
  // 1. Initial Capital last month
  {
    id: 'tx_seed_01',
    transactionId: 6,
    transactionName: 'Penanaman Modal',
    debitCode: '1-1100',
    debitName: 'Kas',
    creditCode: '3-1100',
    creditName: 'Modal Pemilik',
    nominal: 25000000,
    date: new Date(currentYear, currentMonth - 1, 2, 9, 30).getTime(),
    notes: 'Setoran modal awal usaha pengolahan kopi rakyat',
  },
  // 2. Equipment purchase last month
  {
    id: 'tx_seed_02',
    transactionId: 2,
    transactionName: 'Pembelian Tunai',
    debitCode: '1-2100',
    debitName: 'Peralatan Pengolahan Kopi (Roaster/Grinder/Hull)',
    creditCode: '1-1100',
    creditName: 'Kas',
    nominal: 8500000,
    date: new Date(currentYear, currentMonth - 1, 5, 11, 0).getTime(),
    notes: 'Pembelian mesin huller dan pulper kopi kapasitas 500kg',
  },
  // 3. Fertilizer expense last month
  {
    id: 'tx_seed_03',
    transactionId: 5,
    transactionName: 'Pembayaran Beban',
    debitCode: '5-1100',
    debitName: 'Beban Pupuk dan Obat Tanaman',
    creditCode: '1-1100',
    creditName: 'Kas',
    nominal: 2200000,
    date: new Date(currentYear, currentMonth - 1, 10, 14, 0).getTime(),
    notes: 'Pembelian pupuk organik dan fungisida kebun kopi',
  },
  // 4. Sales last month
  {
    id: 'tx_seed_04',
    transactionId: 1,
    transactionName: 'Penjualan Tunai',
    debitCode: '1-1100',
    debitName: 'Kas',
    creditCode: '4-1100',
    creditName: 'Pendapatan Penjualan Kopi',
    nominal: 6800000,
    date: new Date(currentYear, currentMonth - 1, 20, 16, 30).getTime(),
    notes: 'Penjualan green bean Robusta 120 kg ke kedai lokal',
  },
  // 5. This month: Cash sales
  {
    id: 'tx_seed_05',
    transactionId: 1,
    transactionName: 'Penjualan Tunai',
    debitCode: '1-1100',
    debitName: 'Kas',
    creditCode: '4-1100',
    creditName: 'Pendapatan Penjualan Kopi',
    nominal: 9500000,
    date: new Date(currentYear, currentMonth, 3, 10, 15).getTime(),
    notes: 'Penjualan specialty Arabica roasted bean 50 kg',
  },
  // 6. Labor expense this month
  {
    id: 'tx_seed_06',
    transactionId: 5,
    transactionName: 'Pembayaran Beban',
    debitCode: '5-1200',
    debitName: 'Beban Upah Tenaga Kerja Kebun',
    creditCode: '1-1100',
    creditName: 'Kas',
    nominal: 2400000,
    date: new Date(currentYear, currentMonth, 7, 13, 0).getTime(),
    notes: 'Upah tenaga petik merah dan pemangkasan tanaman kopi',
  },
  // 7. Credit sales (Piutang)
  {
    id: 'tx_seed_07',
    transactionId: 3,
    transactionName: 'Penjualan Kredit',
    debitCode: '1-1300',
    debitName: 'Piutang Usaha',
    creditCode: '4-1100',
    creditName: 'Pendapatan Penjualan Kopi',
    nominal: 4200000,
    date: new Date(currentYear, currentMonth, 12, 11, 45).getTime(),
    notes: 'Penjualan roasted bean ke Kafe Sejahtera (tempo 30 hari)',
  },
  // 8. Packaging & processing expense
  {
    id: 'tx_seed_08',
    transactionId: 5,
    transactionName: 'Pembayaran Beban',
    debitCode: '5-1400',
    debitName: 'Beban Pengolahan & Pengemasan Kopi',
    creditCode: '1-1100',
    creditName: 'Kas',
    nominal: 850000,
    date: new Date(currentYear, currentMonth, 15, 15, 30).getTime(),
    notes: 'Pembelian standing pouch valve alufoil & sablon label',
  },
  // 9. Bank loan
  {
    id: 'tx_seed_09',
    transactionId: 8,
    transactionName: 'Penerimaan Pinjaman Bank',
    debitCode: '1-1100',
    debitName: 'Kas',
    creditCode: '2-2100',
    creditName: 'Utang Bank / Kredit Usaha Rakyat (KUR)',
    nominal: 10000000,
    date: new Date(currentYear, currentMonth, 18, 9, 0).getTime(),
    notes: 'Pencairan KUR BRI untuk ekspansi pengeringan kopi (solar dryer dome)',
  },
  // 10. Prive
  {
    id: 'tx_seed_10',
    transactionId: 7,
    transactionName: 'Penarikan Modal (Prive)',
    debitCode: '3-1200',
    debitName: 'Prive Pemilik',
    creditCode: '1-1100',
    creditName: 'Kas',
    nominal: 1500000,
    date: new Date(currentYear, currentMonth, 21, 14, 0).getTime(),
    notes: 'Penarikan keperluan rumah tangga keluarga petani',
  },
  // 11. Today / Recent transaction: Cash sales
  {
    id: 'tx_seed_11',
    transactionId: 1,
    transactionName: 'Penjualan Tunai',
    debitCode: '1-1100',
    debitName: 'Kas',
    creditCode: '4-1100',
    creditName: 'Pendapatan Penjualan Kopi',
    nominal: 3200000,
    date: Date.now() - 2 * 60 * 60 * 1000, // 2 hours ago today
    notes: 'Penjualan bubuk kopi kemasan 250gr pameran PPK Ormawa',
  },
];
