import React, { useState } from 'react';
import { useApp } from '../../context/AppContext';
import { HeaderBar } from '../../components/HeaderBar';
import { DateFilterBar } from '../../components/DateFilterBar';
import { EmptyWarning } from '../../components/EmptyWarning';
import { PrintReportModal } from '../../components/PrintReportModal';
import { FilterMode } from '../../types';
import { calculateBukuBesar, calculateNeracaSaldo } from '../../utils/accounting';
import { filterTransactions, formatCurrency } from '../../utils/formatters';

export const NeracaSaldoPage: React.FC = () => {
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
  });

  const books = calculateBukuBesar(filteredTx);
  const { items, totalDebit, totalCredit } = calculateNeracaSaldo(books);

  const isBalanced = totalDebit === totalCredit;

  return (
    <div className="min-h-screen bg-[#F4F7F0] pb-24">
      <HeaderBar
        title="Neraca Saldo"
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
        {items.length === 0 ? (
          <EmptyWarning
            title="Tidak ada data neraca saldo"
            message="Belum ada transaksi pada periode yang dipilih."
          />
        ) : (
          <div className="bg-white rounded-2xl shadow-xs border border-gray-100 overflow-hidden">
            <div className="overflow-x-auto">
              <table className="w-full text-xs text-left">
                <thead className="bg-[#19282F] text-white font-semibold">
                  <tr>
                    <th className="p-3">Nama Akun</th>
                    <th className="p-3 text-right">Debit</th>
                    <th className="p-3 text-right">Kredit</th>
                  </tr>
                </thead>
                <tbody className="divide-y divide-gray-100">
                  {items.map((it) => (
                    <tr key={it.accountCode} className="hover:bg-gray-50/50">
                      <td className="p-3">
                        <span className="font-semibold text-gray-900 block">{it.accountName}</span>
                        <span className="text-[10px] font-mono text-gray-400">
                          {it.accountCode}
                        </span>
                      </td>
                      <td className="p-3 text-right font-medium text-emerald-700">
                        {it.debit > 0 ? formatCurrency(it.debit) : '-'}
                      </td>
                      <td className="p-3 text-right font-medium text-rose-700">
                        {it.credit > 0 ? formatCurrency(it.credit) : '-'}
                      </td>
                    </tr>
                  ))}
                </tbody>
                <tfoot className="bg-gray-100 font-bold text-gray-900 border-t-2 border-gray-300">
                  <tr>
                    <td className="p-3">Total Saldo:</td>
                    <td className="p-3 text-right text-emerald-700">
                      {formatCurrency(totalDebit)}
                    </td>
                    <td className="p-3 text-right text-rose-700">
                      {formatCurrency(totalCredit)}
                    </td>
                  </tr>
                </tfoot>
              </table>
            </div>

            <div className="p-3 bg-gray-50 border-t border-gray-100 flex items-center justify-between text-xs">
              <span className="text-gray-600 font-medium">Status Keseimbangan:</span>
              <span
                className={`font-bold px-2 py-0.5 rounded-full border ${
                  isBalanced
                    ? 'text-emerald-700 bg-emerald-50 border-emerald-200'
                    : 'text-rose-700 bg-rose-50 border-rose-200'
                }`}
              >
                {isBalanced ? '✓ Seimbang (Balance)' : '⚠ Tidak Seimbang'}
              </span>
            </div>
          </div>
        )}
      </div>

      {/* Print PDF Preview Modal */}
      <PrintReportModal
        title="LAPORAN NERACA SALDO"
        subtitle="SIKEPI - Petani Kopi"
        isOpen={showPrintModal}
        onClose={() => setShowPrintModal(false)}
      >
        <table className="w-full text-xs border border-gray-400">
          <thead className="bg-gray-100 font-bold border-b border-gray-400">
            <tr>
              <th className="p-2 border-r border-gray-400 text-left">Kode Akun</th>
              <th className="p-2 border-r border-gray-400 text-left">Nama Akun</th>
              <th className="p-2 border-r border-gray-400 text-right">Debit (Rp)</th>
              <th className="p-2 text-right">Kredit (Rp)</th>
            </tr>
          </thead>
          <tbody className="divide-y divide-gray-300">
            {items.map((it) => (
              <tr key={it.accountCode}>
                <td className="p-2 border-r border-gray-300 font-mono">{it.accountCode}</td>
                <td className="p-2 border-r border-gray-300 font-medium">{it.accountName}</td>
                <td className="p-2 border-r border-gray-300 text-right">
                  {it.debit > 0 ? formatCurrency(it.debit) : '0'}
                </td>
                <td className="p-2 text-right">{it.credit > 0 ? formatCurrency(it.credit) : '0'}</td>
              </tr>
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
              <td className="p-2 text-right">{formatCurrency(totalCredit)}</td>
            </tr>
          </tfoot>
        </table>
      </PrintReportModal>
    </div>
  );
};
