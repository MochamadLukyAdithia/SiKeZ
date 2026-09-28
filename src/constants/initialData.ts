import { TransactionModel, UserModel } from '../types';

export const INITIAL_USER: UserModel = {
  id: 'usr_dirtyledger',
  name: 'Dirty Ledger',
  email: 'dirtyledgergame@gmail.com',
  phoneNumber: '0821-4200-8899',
  address: 'Dusun Krajan, Lojejer, Wuluhan, Jember, Jawa Timur 68162',
  imageUrl: '', // Blank by default, rendered as single person icon
  joinedAt: new Date(2026, 8, 1).getTime(),
};

// Transactions matching Siklus Akuntansi Keuangan Dirty Ledger 15 September 2026 V3
// Year 2026, Month 8 (September, 0-indexed)
const cycleYear = 2026;
const cycleMonth = 8; // September

export const INITIAL_TRANSACTIONS: TransactionModel[] = [
  // 1. 01 September 2026 (09:00): Penanaman Modal Awal & Pencairan Dana Hibah P2MW Belmawa
  {
    id: 'tx_dl_01',
    transactionId: 6,
    transactionName: 'Penanaman Modal / Hibah',
    debitCode: '1-1200',
    debitName: 'Kas di Bank (Rekening Usaha)',
    creditCode: '3-1100',
    creditName: 'Modal Pemilik & Hibah P2MW',
    nominal: 20000000,
    date: new Date(cycleYear, cycleMonth, 1, 9, 0).getTime(),
    notes: 'Pencairan dana hibah P2MW Kemendikbudristek & setoran modal pendiri Dirty Ledger Game',
  },
  // 2. 01 September 2026 (13:30): Penarikan Kas dari Bank untuk Kas Operasional Studio
  {
    id: 'tx_dl_02',
    transactionId: 5,
    transactionName: 'Pembayaran Beban Operasional',
    debitCode: '1-1100',
    debitName: 'Kas',
    creditCode: '1-1200',
    creditName: 'Kas di Bank (Rekening Usaha)',
    nominal: 5000000,
    date: new Date(cycleYear, cycleMonth, 1, 13, 30).getTime(),
    notes: 'Penarikan tunai dari rekening bank untuk kas kecil operasional studio kerja',
  },
  // 3. 02 September 2026 (10:15): Pembelian PC Workstation Dev & Tablet Desain
  {
    id: 'tx_dl_03',
    transactionId: 2,
    transactionName: 'Pembelian Peralatan Tunai',
    debitCode: '1-2100',
    debitName: 'Peralatan Komputer & Perangkat Dev',
    creditCode: '1-1200',
    creditName: 'Kas di Bank (Rekening Usaha)',
    nominal: 8500000,
    date: new Date(cycleYear, cycleMonth, 2, 10, 15).getTime(),
    notes: 'Pembelian PC workstation dev dan graphic tablet pen display untuk produksi aset game',
  },
  // 4. 03 September 2026 (14:00): Pembayaran Google Play Console Developer & Domain
  {
    id: 'tx_dl_04',
    transactionId: 5,
    transactionName: 'Pembayaran Beban Operasional',
    debitCode: '5-1200',
    debitName: 'Beban Pendaftaran Developer & Lisensi Google Play',
    creditCode: '1-1100',
    creditName: 'Kas',
    nominal: 450000,
    date: new Date(cycleYear, cycleMonth, 3, 14, 0).getTime(),
    notes: 'Registrasi akun Google Play Developer ($25) dan pendaftaran domain dirtyledgergame.com',
  },
  // 5. 04 September 2026 (11:00): Pembelian Aset Karakter 2D/3D & Plugin Game Engine
  {
    id: 'tx_dl_05',
    transactionId: 2,
    transactionName: 'Pembelian Peralatan Tunai',
    debitCode: '1-1500',
    debitName: 'Aset Digital & Lisensi Game Engine',
    creditCode: '1-1100',
    creditName: 'Kas',
    nominal: 1850000,
    date: new Date(cycleYear, cycleMonth, 4, 11, 0).getTime(),
    notes: 'Pembelian asset pack karakter forensik, UI detective noir pack, dan lisensi sound fx',
  },
  // 6. 05 September 2026 (15:20): Pembayaran Server Cloud & Database Hosting
  {
    id: 'tx_dl_06',
    transactionId: 5,
    transactionName: 'Pembayaran Beban Operasional',
    debitCode: '5-1100',
    debitName: 'Beban Server Cloud & Database Hosting',
    creditCode: '1-1200',
    creditName: 'Kas di Bank (Rekening Usaha)',
    nominal: 750000,
    date: new Date(cycleYear, cycleMonth, 5, 15, 20).getTime(),
    notes: 'Pembayaran cloud database Firebase & server sinkronisasi progress pemain bulan September',
  },
  // 7. 07 September 2026 (16:30): Pendapatan Early Access & In-App Energy Token (Tunai)
  {
    id: 'tx_dl_07',
    transactionId: 1,
    transactionName: 'Penjualan Tunai / In-App',
    debitCode: '1-1100',
    debitName: 'Kas',
    creditCode: '4-1100',
    creditName: 'Pendapatan Penjualan Game & In-App Purchase',
    nominal: 3400000,
    date: new Date(cycleYear, cycleMonth, 7, 16, 30).getTime(),
    notes: 'Penjualan early access batch 1 dan token energi investigasi kasus game kepada 200 pemain',
  },
  // 8. 09 September 2026 (13:00): Beban Iklan Media Sosial & Promosi Literasi Anti-Fraud
  {
    id: 'tx_dl_08',
    transactionId: 5,
    transactionName: 'Pembayaran Beban Operasional',
    debitCode: '5-1300',
    debitName: 'Beban Pemasaran, Iklan & Promosi Game',
    creditCode: '1-1100',
    creditName: 'Kas',
    nominal: 900000,
    date: new Date(cycleYear, cycleMonth, 9, 13, 0).getTime(),
    notes: 'Biaya iklan kampanye TikTok/Instagram Ads peluncuran game edukasi Dirty Ledger',
  },
  // 9. 11 September 2026 (10:45): Penjualan Paket Lisensi Modul Edukasi Forensik (Piutang)
  {
    id: 'tx_dl_09',
    transactionId: 3,
    transactionName: 'Penjualan Kredit (Piutang)',
    debitCode: '1-1300',
    debitName: 'Piutang Usaha',
    creditCode: '4-1200',
    creditName: 'Pendapatan Lisensi & Modul Pelatihan Institusi',
    nominal: 6500000,
    date: new Date(cycleYear, cycleMonth, 11, 10, 45).getTime(),
    notes: 'Penjualan paket lisensi simulasi audit forensik ke program studi akuntansi mitra kampus tempo 30 hari',
  },
  // 10. 12 September 2026 (14:30): Honorarium Tim Riset Skenario Kasus Forensik & Dev
  {
    id: 'tx_dl_10',
    transactionId: 5,
    transactionName: 'Pembayaran Beban Operasional',
    debitCode: '5-1400',
    debitName: 'Beban Honorarium Tim Riset Forensik & Dev',
    creditCode: '1-1200',
    creditName: 'Kas di Bank (Rekening Usaha)',
    nominal: 2500000,
    date: new Date(cycleYear, cycleMonth, 12, 14, 30).getTime(),
    notes: 'Honorarium penyusunan skenario kejahatan keuangan dan perancangan alur investigasi',
  },
  // 11. 13 September 2026 (11:15): Beban Internet Fiber Optic & Listrik Studio
  {
    id: 'tx_dl_11',
    transactionId: 5,
    transactionName: 'Pembayaran Beban Operasional',
    debitCode: '5-1500',
    debitName: 'Beban Internet, Listrik & Utilitas Studio',
    creditCode: '1-1100',
    creditName: 'Kas',
    nominal: 650000,
    date: new Date(cycleYear, cycleMonth, 13, 11, 15).getTime(),
    notes: 'Pembayaran internet dedicated fiber optic dan tagihan listrik studio pengembang',
  },
  // 12. 14 September 2026 (15:00): Pendapatan In-App Purchase Google Play (Transfer Bank)
  {
    id: 'tx_dl_12',
    transactionId: 1,
    transactionName: 'Penjualan Tunai / In-App',
    debitCode: '1-1200',
    debitName: 'Kas di Bank (Rekening Usaha)',
    creditCode: '4-1100',
    creditName: 'Pendapatan Penjualan Game & In-App Purchase',
    nominal: 4250000,
    date: new Date(cycleYear, cycleMonth, 14, 15, 0).getTime(),
    notes: 'Penerimaan bagi hasil penjualan in-app purchase energy pack & case unlock Google Play',
  },
  // 13. 15 September 2026 (10:00): Penarikan Prive Pemilik (Luky Adithia)
  {
    id: 'tx_dl_13',
    transactionId: 7,
    transactionName: 'Penarikan Modal (Prive)',
    debitCode: '3-1200',
    debitName: 'Prive Pemilik (Luky Adithia)',
    creditCode: '1-1100',
    creditName: 'Kas',
    nominal: 1000000,
    date: new Date(cycleYear, cycleMonth, 15, 10, 0).getTime(),
    notes: 'Penarikan dana pribadi (prive) oleh pendiri pengembang game Dirty Ledger',
  },
  // 14. 15 September 2026 (16:00): Pendapatan Merchandise & Workshop Forensik (Penutupan Siklus)
  {
    id: 'tx_dl_14',
    transactionId: 1,
    transactionName: 'Penjualan Tunai / In-App',
    debitCode: '1-1100',
    debitName: 'Kas',
    creditCode: '4-1300',
    creditName: 'Pendapatan Merchandise & Workshop Forensik',
    nominal: 2800000,
    date: new Date(cycleYear, cycleMonth, 15, 16, 0).getTime(),
    notes: 'Penerimaan tunai penjualan merchandise detektif finansial dan registrasi workshop forensik siklus 15 September 2026',
  },
];
