import React, { useState } from 'react';
import { useApp } from '../../context/AppContext';
import { HeaderBar } from '../../components/HeaderBar';
import { DateFilterBar } from '../../components/DateFilterBar';
import { EmptyWarning } from '../../components/EmptyWarning';
import { PrintReportModal } from '../../components/PrintReportModal';
import { FilterMode } from '../../types';
import { filterTransactions, formatCurrency, formatDate } from '../../utils/formatters';

export const JurnalUmumPage: React.FC = () => {
  const { transactions } = useApp();
  const [filterMode, setFilterMode] = useState<FilterMode>('thisMonth');
  const [selectedMonth, setSelectedMonth] = useState<number>(new Date().getMonth());
  const [selectedDate, setSelectedDate] = useState<Date>(new Date());
  const [rangeStart, setRangeStart] = useState<Date>(new Date(Date.now() - 30 * 24 * 60 * 60 * 1000));
  const [rangeEnd, setRangeEnd] = useState<Date>(new Date());
  const [showPrintModal, setShowPrintModal] = useState(false);

  const filteredTx = filterTransactions(transactions, filterMode, {
    selectedDate,
    selectedMonth,
    rangeStart,
    rangeEnd,
  }).sort((a, b) => a.date - b.date);

  const totalDebit = filteredTx.reduce((sum, tx) => sum + tx.nominal, 0);
  const totalKredit = filteredTx.reduce((sum, tx) => sum + tx.nominal, 0);

  return (
    <div className="min-h-screen bg-[#F4F7F0] pb-24">
      <HeaderBar
        title="Jurnal Umum"
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

      <div className="max-w-md mx-auto p-4">
        {filteredTx.length === 0 ? (
          <EmptyWarning
            title="Tidak ada transaksi jurnal"
            message="Ubah filter tanggal atau tambahkan transaksi baru."
          />
        ) : (
          <div className="bg-white rounded-2xl shadow-xs border border-gray-100 overflow-hidden">
            <div className="overflow-x-auto">
              <table className="w-full text-xs text-left">
                <thead className="bg-[#19282F] text-white font-semibold">
                  <tr>
                    <th className="p-3">Tanggal / Keterangan</th>
                    <th className="p-3 text-right">Debit</th>
                    <th className="p-3 text-right">Kredit</th>
                  </tr>
                </thead>
                <tbody className="divide-y divide-gray-100">
                  {filteredTx.map((tx) => (
                    <React.Fragment key={tx.id}>
                      {/* Transaction Header Banner */}
                      <tr className="bg-gray-50/80">
                        <td colSpan={3} className="px-3 py-1.5 font-bold text-gray-700 text-[11px]">
                          {formatDate(tx.date, 'short')} • {tx.transactionName}
                        </td>
                      </tr>
                      {/* Debit row */}
                      <tr>
                        <td className="px-3 py-1.5 font-medium text-gray-900">
                          {tx.debitName}{' '}
                          <span className="text-[10px] text-gray-400">({tx.debitCode})</span>
                        </td>
                        <td className="px-3 py-1.5 text-right font-semibold text-emerald-700">
                          {formatCurrency(tx.nominal)}
                        </td>
                        <td className="px-3 py-1.5 text-right text-gray-300">-</td>
                      </tr>
                      {/* Credit row */}
                      <tr>
                        <td className="px-3 py-1.5 pl-6 font-medium text-gray-800">
                          {tx.creditName}{' '}
                          <span className="text-[10px] text-gray-400">({tx.creditCode})</span>
                        </td>
                        <td className="px-3 py-1.5 text-right text-gray-300">-</td>
                        <td className="px-3 py-1.5 text-right font-semibold text-rose-700">
                          {formatCurrency(tx.nominal)}
                        </td>
                      </tr>
                    </React.Fragment>
                  ))}
                </tbody>
                <tfoot className="bg-gray-100 font-bold text-gray-900 border-t-2 border-gray-300">
                  <tr>
                    <td className="p-3 text-right">Total:</td>
                    <td className="p-3 text-right text-emerald-700">
                      {formatCurrency(totalDebit)}
                    </td>
                    <td className="p-3 text-right text-rose-700">
                      {formatCurrency(totalKredit)}
                    </td>
                  </tr>
                </tfoot>
              </table>
            </div>

            <div className="p-3 bg-gray-50 border-t border-gray-100 flex items-center justify-between text-xs">
              <span className="text-gray-500">Status Keseimbangan:</span>
              <span className="font-bold text-emerald-700 bg-emerald-50 px-2 py-0.5 rounded-full border border-emerald-200">
                ✓ Seimbang (Balance)
              </span>
            </div>
          </div>
        )}
      </div>

      {/* Print PDF Preview Modal */}
      <PrintReportModal
        title="LAPORAN JURNAL UMUM"
        subtitle="SIKEPI - Petani Kopi"
        isOpen={showPrintModal}
        onClose={() => setShowPrintModal(false)}
      >
        <table className="w-full text-xs border border-gray-400">
          <thead className="bg-gray-100 font-bold border-b border-gray-400">
            <tr>
              <th className="p-2 border-r border-gray-400 text-left">Tanggal</th>
              <th className="p-2 border-r border-gray-400 text-left">Nama Akun / Keterangan</th>
              <th className="p-2 border-r border-gray-400 text-right">Debit (Rp)</th>
              <th className="p-2 text-right">Kredit (Rp)</th>
            </tr>
          </thead>
          <tbody className="divide-y divide-gray-300">
            {filteredTx.map((tx) => (
              <React.Fragment key={tx.id}>
                <tr className="bg-gray-50 font-semibold">
                  <td colSpan={4} className="p-1.5 text-gray-700 text-[11px]">
                    {formatDate(tx.date, 'short')} - {tx.transactionName} ({tx.notes})
                  </td>
                </tr>
                <tr>
                  <td className="p-2 border-r border-gray-300 text-gray-500">
                    {formatDate(tx.date, 'short')}
                  </td>
                  <td className="p-2 border-r border-gray-300 font-medium">
                    {tx.debitName} ({tx.debitCode})
                  </td>
                  <td className="p-2 border-r border-gray-300 text-right font-medium">
                    {formatCurrency(tx.nominal)}
                  </td>
                  <td className="p-2 text-right text-gray-400">0</td>
                </tr>
                <tr>
                  <td className="p-2 border-r border-gray-300"></td>
                  <td className="p-2 border-r border-gray-300 pl-6 font-medium">
                    {tx.creditName} ({tx.creditCode})
                  </td>
                  <td className="p-2 border-r border-gray-300 text-right text-gray-400">0</td>
                  <td className="p-2 text-right font-medium">{formatCurrency(tx.nominal)}</td>
                </tr>
              </React.Fragment>
            ))}
          </tbody>
          <tfoot className="bg-gray-100 font-bold border-t-2 border-gray-400">
            <tr>
              <td colSpan={2} className="p-2 border-r border-gray-400 text-right">
                TOTAL:
              </td>
              <td className="p-2 border-r border-gray-400 text-right">
                {formatCurrency(totalDebit)}
              </td>
              <td className="p-2 text-right">{formatCurrency(totalKredit)}</td>
            </tr>
          </tfoot>
        </table>
      </PrintReportModal>
    </div>
  );
};
