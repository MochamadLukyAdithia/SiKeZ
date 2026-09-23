import React, { useState } from 'react';
import { ChevronDown, ChevronUp } from 'lucide-react';
import { useApp } from '../../context/AppContext';
import { HeaderBar } from '../../components/HeaderBar';
import { DateFilterBar } from '../../components/DateFilterBar';
import { EmptyWarning } from '../../components/EmptyWarning';
import { PrintReportModal } from '../../components/PrintReportModal';
import { FilterMode, BookModel } from '../../types';
import { calculateBukuBesar } from '../../utils/accounting';
import { filterTransactions, formatCurrency, formatDate } from '../../utils/formatters';

export const BukuBesarPage: React.FC = () => {
  const { transactions } = useApp();
  const [filterMode, setFilterMode] = useState<FilterMode>('thisMonth');
  const [selectedMonth, setSelectedMonth] = useState<number>(new Date().getMonth());
  const [selectedDate, setSelectedDate] = useState<Date>(new Date());
  const [rangeStart, setRangeStart] = useState<Date>(new Date(Date.now() - 30 * 24 * 60 * 60 * 1000));
  const [rangeEnd, setRangeEnd] = useState<Date>(new Date());
  const [showPrintModal, setShowPrintModal] = useState(false);
  const [expandedCodes, setExpandedCodes] = useState<Record<string, boolean>>({});

  const filteredTx = filterTransactions(transactions, filterMode, {
    selectedDate,
    selectedMonth,
    rangeStart,
    rangeEnd,
  });

  const books: BookModel[] = calculateBukuBesar(filteredTx);

  const toggleExpand = (code: string) => {
    setExpandedCodes((prev) => ({
      ...prev,
      [code]: !prev[code],
    }));
  };

  return (
    <div className="min-h-screen bg-[#F4F7F0] pb-24">
      <HeaderBar
        title="Buku Besar"
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
        {books.length === 0 ? (
          <EmptyWarning
            title="Tidak ada data buku besar"
            message="Belum ada transaksi pada periode yang dipilih."
          />
        ) : (
          books.map((book) => {
            const isExpanded = expandedCodes[book.code] ?? true;
            return (
              <div
                key={book.code}
                className="bg-white rounded-2xl shadow-xs border border-gray-100 overflow-hidden"
              >
                {/* Account Card Header */}
                <div
                  onClick={() => toggleExpand(book.code)}
                  className="p-4 flex items-center justify-between cursor-pointer hover:bg-gray-50/80 transition-colors"
                >
                  <div>
                    <div className="flex items-center space-x-2">
                      <span className="text-xs font-mono font-bold px-2 py-0.5 bg-gray-100 text-gray-700 rounded-md">
                        {book.code}
                      </span>
                      <h3 className="text-sm font-bold text-gray-900">{book.account}</h3>
                    </div>
                    <p className="text-[11px] text-gray-400 mt-1">
                      {book.history.length} mutasi pencatatan
                    </p>
                  </div>

                  <div className="flex items-center space-x-3 text-right">
                    <div>
                      <span className="text-[10px] text-gray-400 block font-medium">
                        Saldo Akhir
                      </span>
                      <span className="text-sm font-extrabold text-gray-900">
                        {formatCurrency(book.endingBalance ?? 0)}
                      </span>
                    </div>
                    <button className="text-gray-400 p-1">
                      {isExpanded ? (
                        <ChevronUp className="w-4 h-4" />
                      ) : (
                        <ChevronDown className="w-4 h-4" />
                      )}
                    </button>
                  </div>
                </div>

                {/* Account Movement Table */}
                {isExpanded && (
                  <div className="border-t border-gray-100 overflow-x-auto">
                    <table className="w-full text-xs text-left">
                      <thead className="bg-gray-50 text-gray-600 font-medium">
                        <tr>
                          <th className="px-3 py-2">Tgl</th>
                          <th className="px-3 py-2 text-right">Debit</th>
                          <th className="px-3 py-2 text-right">Kredit</th>
                          <th className="px-3 py-2 text-right">Saldo</th>
                        </tr>
                      </thead>
                      <tbody className="divide-y divide-gray-100">
                        {book.history.map((h, idx) => (
                          <tr key={idx} className="hover:bg-gray-50/50">
                            <td className="px-3 py-2 text-gray-500 font-medium">
                              {formatDate(h.dateTime, 'short')}
                            </td>
                            <td className="px-3 py-2 text-right font-medium text-emerald-700">
                              {h.debit > 0 ? formatCurrency(h.debit) : '-'}
                            </td>
                            <td className="px-3 py-2 text-right font-medium text-rose-700">
                              {h.kredit > 0 ? formatCurrency(h.kredit) : '-'}
                            </td>
                            <td className="px-3 py-2 text-right font-bold text-gray-900">
                              {formatCurrency(h.runningBalance ?? 0)}
                            </td>
                          </tr>
                        ))}
                      </tbody>
                      <tfoot className="bg-gray-50/80 font-semibold text-[11px] text-gray-700 border-t border-gray-200">
                        <tr>
                          <td className="px-3 py-2">Total Mutasi</td>
                          <td className="px-3 py-2 text-right text-emerald-700">
                            {formatCurrency(book.totalDebit ?? 0)}
                          </td>
                          <td className="px-3 py-2 text-right text-rose-700">
                            {formatCurrency(book.totalKredit ?? 0)}
                          </td>
                          <td className="px-3 py-2 text-right">
                            {formatCurrency(book.endingBalance ?? 0)}
                          </td>
                        </tr>
                      </tfoot>
                    </table>
                  </div>
                )}
              </div>
            );
          })
        )}
      </div>

      {/* Print PDF Preview Modal */}
      <PrintReportModal
        title="LAPORAN BUKU BESAR"
        subtitle="SiKeZ - Sistem Keuangan Gen Z"
        isOpen={showPrintModal}
        onClose={() => setShowPrintModal(false)}
      >
        <div className="space-y-6">
          {books.map((book) => (
            <div key={book.code} className="border border-gray-400 p-3 rounded-sm">
              <div className="flex justify-between items-center mb-2 pb-1 border-b border-gray-300">
                <span className="font-bold text-sm">
                  {book.code} - {book.account}
                </span>
                <span className="text-xs font-bold text-gray-800">
                  Saldo: {formatCurrency(book.endingBalance ?? 0)}
                </span>
              </div>
              <table className="w-full text-xs">
                <thead>
                  <tr className="border-b border-gray-300 text-gray-600">
                    <th className="py-1 text-left">Tanggal</th>
                    <th className="py-1 text-left">Keterangan</th>
                    <th className="py-1 text-right">Debit (Rp)</th>
                    <th className="py-1 text-right">Kredit (Rp)</th>
                    <th className="py-1 text-right">Saldo (Rp)</th>
                  </tr>
                </thead>
                <tbody className="divide-y divide-gray-200">
                  {book.history.map((h, i) => (
                    <tr key={i}>
                      <td className="py-1 text-gray-500">{formatDate(h.dateTime, 'short')}</td>
                      <td className="py-1 text-gray-700">{h.notes || '-'}</td>
                      <td className="py-1 text-right">{h.debit > 0 ? formatCurrency(h.debit) : '0'}</td>
                      <td className="py-1 text-right">{h.kredit > 0 ? formatCurrency(h.kredit) : '0'}</td>
                      <td className="py-1 text-right font-medium">
                        {formatCurrency(h.runningBalance ?? 0)}
                      </td>
                    </tr>
                  ))}
                </tbody>
              </table>
            </div>
          ))}
        </div>
      </PrintReportModal>
    </div>
  );
};
