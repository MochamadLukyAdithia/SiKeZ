import { AccountModel, TransactionTypeModel } from '../types';

export const INITIAL_ACCOUNTS: AccountModel[] = [
  // 1: Aset / Harta
  { code: '1-1100', name: 'Kas', category: 'harta' },
  { code: '1-1200', name: 'Kas di Bank (Rekening Usaha)', category: 'harta' },
  { code: '1-1300', name: 'Piutang Usaha', category: 'harta' },
  { code: '1-1400', name: 'Perlengkapan Studio & Kantor', category: 'harta' },
  { code: '1-1500', name: 'Aset Digital & Lisensi Game Engine', category: 'harta' },
  { code: '1-2100', name: 'Peralatan Komputer & Perangkat Dev', category: 'harta' },
  { code: '1-2200', name: 'Akumulasi Penyusutan Peralatan', category: 'harta' },

  // 2: Kewajiban / Hutang
  { code: '2-1100', name: 'Utang Usaha', category: 'kewajiban' },
  { code: '2-1200', name: 'Utang Beban Operasional', category: 'kewajiban' },
  { code: '2-2100', name: 'Utang Bank / Pinjaman Usaha', category: 'kewajiban' },

  // 3: Ekuitas / Modal
  { code: '3-1100', name: 'Modal Pemilik & Hibah P2MW', category: 'modal' },
  { code: '3-1200', name: 'Prive Pemilik (Luky Adithia)', category: 'modal' },

  // 4: Pendapatan
  { code: '4-1100', name: 'Pendapatan Penjualan Game & In-App Purchase', category: 'pendapatan' },
  { code: '4-1200', name: 'Pendapatan Lisensi & Modul Pelatihan Institusi', category: 'pendapatan' },
  { code: '4-1300', name: 'Pendapatan Merchandise & Workshop Forensik', category: 'pendapatan' },
  { code: '4-1400', name: 'Pendapatan Lain-lain', category: 'pendapatan' },

  // 5: Beban
  { code: '5-1100', name: 'Beban Server Cloud & Database Hosting', category: 'beban' },
  { code: '5-1200', name: 'Beban Pendaftaran Developer & Lisensi Google Play', category: 'beban' },
  { code: '5-1300', name: 'Beban Pemasaran, Iklan & Promosi Game', category: 'beban' },
  { code: '5-1400', name: 'Beban Honorarium Tim Riset Forensik & Dev', category: 'beban' },
  { code: '5-1500', name: 'Beban Internet, Listrik & Utilitas Studio', category: 'beban' },
  { code: '5-1600', name: 'Beban Pengurusan Legalitas & Administrasi', category: 'beban' },
  { code: '5-1700', name: 'Beban Administrasi Bank & Biaya Lainnya', category: 'beban' },
];

export const TRANSACTION_TYPES: TransactionTypeModel[] = [
  { id: 1, name: 'Penjualan Tunai / In-App', description: 'Penerimaan kas dari penjualan game, in-app purchase, atau workshop' },
  { id: 2, name: 'Pembelian Peralatan Tunai', description: 'Pembelian perangkat workstation, komputer dev, atau tablet' },
  { id: 3, name: 'Penjualan Kredit (Piutang)', description: 'Penjualan lisensi institusi dengan tempo pembayaran' },
  { id: 4, name: 'Pembelian Kredit (Utang)', description: 'Pembelian perlengkapan studio atau lisensi bertempo' },
  { id: 5, name: 'Pembayaran Beban Operasional', description: 'Pengeluaran kas untuk server, iklan, utilitas, atau honor tim' },
  { id: 6, name: 'Penanaman Modal / Hibah', description: 'Setoran modal pendiri atau pencairan dana hibah P2MW Belmawa' },
  { id: 7, name: 'Penarikan Modal (Prive)', description: 'Pengambilan kas oleh pendiri/pemilik untuk keperluan pribadi' },
  { id: 8, name: 'Penerimaan Pinjaman Usaha', description: 'Pencairan pinjaman modal kerja dari bank' },
];
