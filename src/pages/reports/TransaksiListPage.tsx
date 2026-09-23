import React, { useState } from 'react';
import { Search } from 'lucide-react';
import { useApp } from '../../context/AppContext';
import { HeaderBar } from '../../components/HeaderBar';
import { DateFilterBar } from '../../components/DateFilterBar';
import { TransactionCard } from '../../components/TransactionCard';
import { EmptyWarning } from '../../components/EmptyWarning';
import { PrintReportModal } from '../../components/PrintReportModal';
import { FilterMode } from '../../types';
import { filterTransactions, formatCurrency, formatDate } from '../../utils/formatters';

export const TransaksiListPage: React.FC = () => {
  const { transactions, navigate, removeTransaction } = useApp();
  const [filterMode, setFilterMode] = useState<FilterMode>('thisMonth');
  const [selectedMonth, setSelectedMonth] = useState<number>(new Date().getMonth());
  const [selectedDate, setSelectedDate] = useState<Date>(new Date());
  const [rangeStart, setRangeStart] = useState<Date>(new Date(Date.now() - 30 * 24 * 60 * 60 * 1000));
  const [rangeEnd, setRangeEnd] = useState<Date>(new Date());
  const [searchQuery, setSearchQuery] = useState('');
  const [showPrintModal, setShowPrintModal] = useState(false);

  const filteredTx = filterTransactions(transactions, filterMode, {
    selectedDate,
    selectedMonth,
    rangeStart,
    rangeEnd,
  }).filter((tx) => {
    if (!searchQuery.trim()) return true;
    const q = searchQuery.toLowerCase();
    return (
      tx.transactionName.toLowerCase().includes(q) ||
      tx.notes.toLowerCase().includes(q) ||
      tx.debitName.toLowerCase().includes(q) ||
      tx.creditName.toLowerCase().includes(q) ||
      tx.nominal.toString().includes(q)
    );
  });

  const totalNominal = filteredTx.reduce((sum, tx) => sum + tx.nominal, 0);

  return (
    <div className="min-h-screen bg-[#F4F7F0] pb-24">
      <HeaderBar
        title="Daftar Transaksi"
        showBack
        onPrint={() => setShowPrintModal(true)}
      />

      <DateFilterBar
        currentFilter={filterMode}
        onFilterChange={setFilterMode}
        selectedDate={selectedDate}
        onDateChange={setSelectedDate}
        selectedMonth={selectedMonth}
        onMonthChange={setSelectedMonth}
        rangeStart={rangeStart}
        rangeEnd={rangeEnd}
        onRangeChange={(start, end) => {
          setRangeStart(start);
          setRangeEnd(end);
        }}
      />

      <div className="max-w-md mx-auto p-4 space-y-3">
        {/* Search Input */}
        <div className="relative">
          <Search className="w-4 h-4 text-gray-400 absolute left-3 top-3" />
          <input
            type="text"
            placeholder="Cari transaksi, akun, atau catatan..."
            value={searchQuery}
            onChange={(e) => setSearchQuery(e.target.value)}
            className="w-full bg-white border border-gray-200 rounded-xl py-2 pl-9 pr-3 text-xs outline-none focus:ring-2 focus:ring-[#A1B57D] shadow-xs"
          />
        </div>

        {/* Results count & sum */}
        <div className="flex justify-between items-center px-1 text-xs text-gray-500 font-medium">
          <span>Menampilkan {filteredTx.length} transaksi</span>
          <span>Total: {formatCurrency(totalNominal)}</span>
        </div>

        {filteredTx.length === 0 ? (
          <EmptyWarning
            title="Tidak ada transaksi yang cocok"
            message="Coba ubah kata kunci pencarian atau rentang tanggal."
          />
        ) : (
          filteredTx.map((tx) => (
            <TransactionCard
              key={tx.id}
              transaction={tx}
              onSelect={(item) => navigate('report-detail', item)}
              onDelete={removeTransaction}
            />
          ))
        )}
      </div>

      {/* Print PDF Preview Modal */}
      <PrintReportModal
        title="LAPORAN DAFTAR TRANSAKSI"
        subtitle="SiKeZ - Aplikasi Keuangan Gen Z"
        isOpen={showPrintModal}
        onClose={() => setShowPrintModal(false)}
      >
        <table className="w-full text-xs border border-gray-400">
          <thead className="bg-gray-100 font-bold border-b border-gray-400">
            <tr>
              <th className="p-2 border-r border-gray-400 text-left">Tanggal</th>
              <th className="p-2 border-r border-gray-400 text-left">Nama Transaksi</th>
              <th className="p-2 border-r border-gray-400 text-left">Akun Terlibat</th>
              <th className="p-2 border-r border-gray-400 text-left">Catatan</th>
              <th className="p-2 text-right">Nominal (Rp)</th>
            </tr>
          </thead>
          <tbody className="divide-y divide-gray-300">
            {filteredTx.map((tx) => (
              <tr key={tx.id}>
                <td className="p-2 border-r border-gray-300 whitespace-nowrap">
                  {formatDate(tx.date, 'short')}
                </td>
                <td className="p-2 border-r border-gray-300 font-medium">{tx.transactionName}</td>
                <td className="p-2 border-r border-gray-300 text-[11px] text-gray-600">
                  {tx.debitName} → {tx.creditName}
                </td>
                <td className="p-2 border-r border-gray-300 text-[11px] text-gray-600">
                  {tx.notes || '-'}
                </td>
                <td className="p-2 text-right font-medium">{formatCurrency(tx.nominal)}</td>
              </tr>
            ))}
          </tbody>
          <tfoot className="bg-gray-100 font-bold border-t-2 border-gray-400">
            <tr>
              <td colSpan={4} className="p-2 border-r border-gray-400 text-right">
                TOTAL NOMINAL:
              </td>
              <td className="p-2 text-right font-bold text-gray-900">
                {formatCurrency(totalNominal)}
              </td>
            </tr>
          </tfoot>
        </table>
      </PrintReportModal>
    </div>
  );
};
