import { AccountModel, TransactionTypeModel } from '../types';

export const INITIAL_ACCOUNTS: AccountModel[] = [
  // 1: Aset / Harta
  { code: '1-1100', name: 'Kas', category: 'harta' },
  { code: '1-1200', name: 'Kas di Bank', category: 'harta' },
  { code: '1-1300', name: 'Piutang Usaha', category: 'harta' },
  { code: '1-1400', name: 'Persediaan Kopi (Green Bean/Roasted)', category: 'harta' },
  { code: '1-1500', name: 'Perlengkapan Kebun & Produksi', category: 'harta' },
  { code: '1-2100', name: 'Peralatan Pengolahan Kopi (Roaster/Grinder/Hull)', category: 'harta' },
  { code: '1-2200', name: 'Tanah & Kebun Kopi', category: 'harta' },

  // 2: Kewajiban / Hutang
  { code: '2-1100', name: 'Utang Usaha', category: 'kewajiban' },
  { code: '2-1200', name: 'Utang Beban / Biaya Operasional', category: 'kewajiban' },
  { code: '2-2100', name: 'Utang Bank / Kredit Usaha Rakyat (KUR)', category: 'kewajiban' },

  // 3: Ekuitas / Modal
  { code: '3-1100', name: 'Modal Pemilik', category: 'modal' },
  { code: '3-1200', name: 'Prive Pemilik', category: 'modal' },

  // 4: Pendapatan
  { code: '4-1100', name: 'Pendapatan Penjualan Kopi', category: 'pendapatan' },
  { code: '4-1200', name: 'Pendapatan Lain-lain (Wisata Edukasi/Bibit)', category: 'pendapatan' },

  // 5: Beban
  { code: '5-1100', name: 'Beban Pupuk dan Obat Tanaman', category: 'beban' },
  { code: '5-1200', name: 'Beban Upah Tenaga Kerja Kebun', category: 'beban' },
  { code: '5-1300', name: 'Beban Panen dan Pasca Panen', category: 'beban' },
  { code: '5-1400', name: 'Beban Pengolahan & Pengemasan Kopi', category: 'beban' },
  { code: '5-1500', name: 'Beban Transportasi & Logistik', category: 'beban' },
  { code: '5-1600', name: 'Beban Listrik, Air & Utilitas Kebun', category: 'beban' },
  { code: '5-1700', name: 'Beban Lainnya / Administrasi Bank', category: 'beban' },
];

export const TRANSACTION_TYPES: TransactionTypeModel[] = [
  { id: 1, name: 'Penjualan Tunai', description: 'Penerimaan kas dari penjualan hasil panen/kopi olahan' },
  { id: 2, name: 'Pembelian Tunai', description: 'Pembelian perlengkapan/peralatan/beban secara tunai' },
  { id: 3, name: 'Penjualan Kredit', description: 'Penjualan hasil panen dengan pembayaran tempo/piutang' },
  { id: 4, name: 'Pembelian Kredit', description: 'Pembelian bibit/pupuk/peralatan dengan berutang' },
  { id: 5, name: 'Pembayaran Beban', description: 'Pengeluaran kas untuk biaya operasional & upah' },
  { id: 6, name: 'Penanaman Modal', description: 'Setoran modal tambahan berupa uang atau aset ke usaha' },
  { id: 7, name: 'Penarikan Modal (Prive)', description: 'Pengambilan uang/aset oleh pemilik untuk keperluan pribadi' },
  { id: 8, name: 'Penerimaan Pinjaman Bank', description: 'Pencairan pinjaman/KUR dari bank untuk modal kerja' },
];
