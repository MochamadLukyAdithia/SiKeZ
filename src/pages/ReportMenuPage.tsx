import React from 'react';
import {
  BookOpen,
  FileSpreadsheet,
  TrendingUp,
  Scale,
  DollarSign,
  Receipt,
  Layers,
  ChevronRight,
} from 'lucide-react';
import { useApp } from '../context/AppContext';

interface ReportMenuItem {
  id: string;
  route: string;
  title: string;
  subtitle: string;
  icon: React.ReactNode;
  badge?: string;
}

export const ReportMenuPage: React.FC = () => {
  const { navigate } = useApp();

  const reportItems: ReportMenuItem[] = [
    {
      id: 'transaksi',
      route: 'report/transaksi',
      title: 'Transaksi',
      subtitle: 'Daftar riwayat semua transaksi keuangan',
      icon: <Receipt className="w-5 h-5 text-amber-700" />,
    },
    {
      id: 'jurnal',
      route: 'report/jurnal',
      title: 'Jurnal Umum',
      subtitle: 'Pencatatan kronologis debit & kredit berpasangan',
      icon: <FileSpreadsheet className="w-5 h-5 text-blue-600" />,
    },
    {
      id: 'buku',
      route: 'report/buku',
      title: 'Buku Besar',
      subtitle: 'Rekapitulasi mutasi dan saldo setiap akun',
      icon: <BookOpen className="w-5 h-5 text-emerald-600" />,
    },
    {
      id: 'neraca_saldo',
      route: 'report/neracaSaldo',
      title: 'Neraca Saldo',
      subtitle: 'Daftar keseimbangan total debit dan kredit',
      icon: <Scale className="w-5 h-5 text-purple-600" />,
    },
    {
      id: 'laba_rugi',
      route: 'report/laba',
      title: 'Laba Rugi',
      subtitle: 'Pendapatan vs biaya operasional perkebunan',
      icon: <TrendingUp className="w-5 h-5 text-emerald-600" />,
      badge: 'Utama',
    },
    {
      id: 'perubahan_modal',
      route: 'report/modal',
      title: 'Perubahan Modal',
      subtitle: 'Perkembangan modal awal, laba bersih, & prive',
      icon: <DollarSign className="w-5 h-5 text-indigo-600" />,
    },
    {
      id: 'neraca',
      route: 'report/neraca',
      title: 'Neraca',
      subtitle: 'Posisi aset, kewajiban hutang, & modal akhir',
      icon: <Layers className="w-5 h-5 text-rose-600" />,
      badge: 'SAK EMKM',
    },
  ];

  return (
    <div className="min-h-screen bg-[#F4F7F0] pb-24">
      {/* Header */}
      <div className="bg-gradient-primary text-white pt-6 pb-6 px-4 rounded-b-3xl shadow-md">
        <div className="max-w-md mx-auto">
          <div className="flex items-center justify-between">
            <div>
              <span className="text-[11px] uppercase tracking-wider text-rose-200 font-semibold">
                Sistem Keuangan Gen Z
              </span>
              <h1 className="text-xl font-bold tracking-tight">Laporan Keuangan</h1>
            </div>
            <img
              src="/assets/images/logo.png"
              alt="Logo"
              className="w-10 h-10 object-contain drop-shadow"
            />
          </div>
          <p className="text-xs text-rose-100 mt-2">
            Laporan akuntansi standar untuk evaluasi keuangan dan performa usaha.
          </p>
        </div>
      </div>

      {/* Menu List */}
      <div className="max-w-md mx-auto px-4 mt-4 space-y-2.5">
        {reportItems.map((item) => (
          <button
            key={item.id}
            onClick={() => navigate(item.route)}
            className="w-full bg-white rounded-2xl p-4 shadow-xs border border-gray-100 flex items-center justify-between text-left hover:shadow-md transition-all active:scale-[0.99] group"
          >
            <div className="flex items-center space-x-3.5 min-w-0">
              <div className="w-11 h-11 rounded-xl bg-gray-50 flex items-center justify-center shrink-0 border border-gray-100 group-hover:scale-105 transition-transform">
                {item.icon}
              </div>
              <div className="min-w-0">
                <div className="flex items-center space-x-2">
                  <h3 className="text-sm font-bold text-gray-900 truncate">{item.title}</h3>
                  {item.badge && (
                    <span className="text-[10px] font-bold bg-[#A1B57D]/20 text-[#464F37] px-2 py-0.5 rounded-full">
                      {item.badge}
                    </span>
                  )}
                </div>
                <p className="text-xs text-gray-500 truncate mt-0.5">{item.subtitle}</p>
              </div>
            </div>
            <ChevronRight className="w-5 h-5 text-gray-300 group-hover:text-gray-500 group-hover:translate-x-0.5 transition-all shrink-0 ml-2" />
          </button>
        ))}
      </div>
    </div>
  );
};
