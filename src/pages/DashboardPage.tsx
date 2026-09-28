import React, { useState } from 'react';
import { Plus, Calendar, Layers } from 'lucide-react';
import { useApp } from '../context/AppContext';
import { DashboardHeader } from '../components/DashboardHeader';
import { TransactionCard } from '../components/TransactionCard';
import { EmptyWarning } from '../components/EmptyWarning';
import { formatDate, isSameDay } from '../utils/formatters';
import { TransactionModel } from '../types';

export const DashboardPage: React.FC = () => {
  const { transactions, navigate, removeTransaction, selectedDate, setSelectedDate } = useApp();
  const [viewMode, setViewMode] = useState<'selectedDate' | 'all'>('all');

  const filteredTransactions = transactions.filter((tx) => {
    if (viewMode === 'all') return true;
    return isSameDay(new Date(tx.date), selectedDate);
  });

  const handleSelectTransaction = (tx: TransactionModel) => {
    navigate('report-detail', tx);
  };

  return (
    <div className="pb-24">
      {/* Top Banner Header */}
      <DashboardHeader />

      {/* Siklus Akuntansi Status Card (Clean, Read-Only, No Upload Clutter) */}
      <div className="max-w-md mx-auto px-4 mt-3">
        <div className="bg-gradient-to-r from-[#0E3B2F] to-[#155342] text-white rounded-2xl p-3.5 shadow-sm border border-emerald-800/40 flex items-center justify-between">
          <div className="flex items-center space-x-3">
            <div className="w-9 h-9 rounded-xl bg-white/10 flex items-center justify-center text-[#7BE495] shrink-0">
              <Layers className="w-5 h-5" />
            </div>
            <div className="min-w-0">
              <span className="text-[10px] font-bold uppercase tracking-wider text-emerald-300 block truncate">
                Siklus Akuntansi Keuangan
              </span>
              <p className="text-xs font-bold text-white truncate">Dirty Ledger • 1 - 15 September 2026</p>
            </div>
          </div>
          <div className="text-right shrink-0">
            <span className="text-[11px] font-semibold bg-emerald-400/20 text-emerald-200 px-2.5 py-1 rounded-full border border-emerald-400/30">
              {transactions.length} Transaksi
            </span>
          </div>
        </div>
      </div>

      {/* Date & Filter Control Center */}
      <div className="max-w-md mx-auto px-4 mt-3">
        <div className="bg-white rounded-2xl p-4 shadow-xs border border-gray-100">
          <div className="flex items-center justify-between mb-2">
            <span className="text-xs font-semibold text-gray-500 uppercase tracking-wider">
              Tanggal Transaksi
            </span>
            <div className="flex space-x-1 text-xs">
              <button
                onClick={() => setViewMode('all')}
                className={`px-2.5 py-1 rounded-full font-medium transition-colors cursor-pointer ${
                  viewMode === 'all'
                    ? 'bg-[#0E3B2F] text-white font-semibold'
                    : 'bg-gray-100 text-gray-600 hover:bg-gray-200'
                }`}
              >
                Semua Transaksi
              </button>
              <button
                onClick={() => setViewMode('selectedDate')}
                className={`px-2.5 py-1 rounded-full font-medium transition-colors cursor-pointer ${
                  viewMode === 'selectedDate'
                    ? 'bg-[#0E3B2F] text-white font-semibold'
                    : 'bg-gray-100 text-gray-600 hover:bg-gray-200'
                }`}
              >
                Hari Terpilih
              </button>
            </div>
          </div>

          <div className="flex items-center justify-between pt-1">
            <div className="flex items-center space-x-2">
              <Calendar className="w-5 h-5 text-[#0E3B2F]" />
              <span className="text-base font-bold text-gray-900">
                {viewMode === 'all'
                  ? 'Semua Transaksi'
                  : formatDate(selectedDate, 'long')}
              </span>
            </div>

            {viewMode === 'selectedDate' && (
              <label className="cursor-pointer text-xs font-semibold text-emerald-700 hover:underline flex items-center">
                <span>Ganti Tanggal</span>
                <input
                  type="date"
                  className="sr-only"
                  value={selectedDate.toISOString().substring(0, 10)}
                  onChange={(e) => {
                    if (e.target.value) {
                      setSelectedDate(new Date(e.target.value));
                    }
                  }}
                />
              </label>
            )}
          </div>
        </div>
      </div>

      {/* Transactions List */}
      <div className="max-w-md mx-auto px-4 mt-4">
        <div className="flex items-center justify-between mb-3">
          <h3 className="text-sm font-bold text-gray-800">
            Daftar Transaksi ({filteredTransactions.length})
          </h3>
          {filteredTransactions.length > 0 && (
            <button
              onClick={() => navigate('report/transaksi')}
              className="text-xs font-semibold text-[#0E3B2F] hover:underline cursor-pointer"
            >
              Lihat di Laporan
            </button>
          )}
        </div>

        {filteredTransactions.length === 0 ? (
          <EmptyWarning
            title="Tidak ada transaksi pada tanggal ini"
            message="Ketuk tombol '+' di bawah untuk mencatat transaksi keuangan Anda."
          />
        ) : (
          <div className="space-y-2">
            {filteredTransactions.map((tx) => (
              <TransactionCard
                key={tx.id}
                transaction={tx}
                onSelect={handleSelectTransaction}
                onDelete={removeTransaction}
              />
            ))}
          </div>
        )}
      </div>

      {/* Floating Action Button (FAB) */}
      <div className="fixed bottom-20 right-4 md:right-[calc(50%-200px)] z-30">
        <button
          onClick={() => navigate('add-transaction')}
          className="w-14 h-14 rounded-full bg-gradient-primary text-white shadow-xl hover:shadow-2xl flex items-center justify-center transition-transform hover:scale-105 active:scale-95 border-2 border-white cursor-pointer"
          title="Tambah Transaksi Baru"
          aria-label="Tambah Transaksi Baru"
        >
          <Plus className="w-7 h-7" />
        </button>
      </div>
    </div>
  );
};
