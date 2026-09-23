import React, { useState } from 'react';
import { useApp } from '../../context/AppContext';
import { HeaderBar } from '../../components/HeaderBar';
import { DateFilterBar } from '../../components/DateFilterBar';
import { PrintReportModal } from '../../components/PrintReportModal';
import { FilterMode } from '../../types';
import { calculateLabaRugi } from '../../utils/accounting';
import { filterTransactions, formatCurrency } from '../../utils/formatters';

export const LabaRugiPage: React.FC = () => {
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

  const labaData = calculateLabaRugi(filteredTx);
  const isProfit = labaData.cleanResult >= 0;

  return (
    <div className="min-h-screen bg-[#F4F7F0] pb-24">
      <HeaderBar
        title="Laporan Laba Rugi"
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

      <div className="max-w-md mx-auto p-4 space-y-4">
        {/* Clean Laba / Rugi Summary Card */}
        <div
          className={`rounded-2xl p-5 shadow-sm text-white ${
            isProfit
              ? 'bg-gradient-to-br from-emerald-700 to-teal-900'
              : 'bg-gradient-to-br from-rose-700 to-red-950'
          }`}
        >
          <div className="flex justify-between items-start">
            <div>
              <span className="text-xs uppercase tracking-wider text-emerald-100 font-semibold">
                {isProfit ? 'Laba Bersih Periode Ini' : 'Rugi Bersih Periode Ini'}
              </span>
              <h2 className="text-2xl font-extrabold mt-1">
                {formatCurrency(labaData.cleanResult)}
              </h2>
            </div>
            <span className="text-xs bg-white/20 px-2.5 py-1 rounded-full font-bold">
              {isProfit ? 'Surplus' : 'Defisit'}
            </span>
          </div>
          <p className="text-[11px] text-white/80 mt-2">
            Total Pendapatan ({formatCurrency(labaData.pendapatanDariPenjualan.totalAmount)}) dikurangi
            Total Semua Beban (
            {formatCurrency(
              labaData.bebanOperasional.totalAmount + labaData.bebanLainya.totalAmount
            )}
            )
          </p>
        </div>

        {/* 1. Pendapatan dari Penjualan */}
        <div className="bg-white rounded-2xl shadow-xs border border-gray-100 overflow-hidden">
          <div className="bg-emerald-50 px-4 py-2.5 border-b border-emerald-100 flex justify-between items-center">
            <h3 className="text-xs font-bold text-emerald-900 uppercase tracking-wider">
              1. Pendapatan Penjualan
            </h3>
            <span className="text-xs font-bold text-emerald-800">
              {formatCurrency(labaData.pendapatanDariPenjualan.totalAmount)}
            </span>
          </div>

          <div className="divide-y divide-gray-100 text-xs">
            {labaData.pendapatanDariPenjualan.items.length === 0 ? (
              <p className="p-3 text-gray-400 italic">Belum ada pendapatan pada periode ini.</p>
            ) : (
              labaData.pendapatanDariPenjualan.items.map((it) => (
                <div key={it.code} className="p-3 flex justify-between items-center">
                  <div>
                    <span className="font-semibold text-gray-800 block">{it.name}</span>
                    <span className="text-[10px] font-mono text-gray-400">{it.code}</span>
                  </div>
                  <span className="font-bold text-gray-900">{formatCurrency(it.amount)}</span>
                </div>
              ))
            )}
          </div>
        </div>

        {/* 2. Beban Operasional */}
        <div className="bg-white rounded-2xl shadow-xs border border-gray-100 overflow-hidden">
          <div className="bg-amber-50 px-4 py-2.5 border-b border-amber-100 flex justify-between items-center">
            <h3 className="text-xs font-bold text-amber-900 uppercase tracking-wider">
              2. Beban Operasional Usaha Tani
            </h3>
            <span className="text-xs font-bold text-amber-800">
              {formatCurrency(labaData.bebanOperasional.totalAmount)}
            </span>
          </div>

          <div className="divide-y divide-gray-100 text-xs">
            {labaData.bebanOperasional.items.length === 0 ? (
              <p className="p-3 text-gray-400 italic">Belum ada beban operasional tercatat.</p>
            ) : (
              labaData.bebanOperasional.items.map((it) => (
                <div key={it.code} className="p-3 flex justify-between items-center">
                  <div>
                    <span className="font-semibold text-gray-800 block">{it.name}</span>
                    <span className="text-[10px] font-mono text-gray-400">{it.code}</span>
                  </div>
                  <span className="font-bold text-rose-700">{formatCurrency(it.amount)}</span>
                </div>
              ))
            )}
          </div>
        </div>

        {/* 3. Beban Lainnya */}
        {labaData.bebanLainya.items.length > 0 && (
          <div className="bg-white rounded-2xl shadow-xs border border-gray-100 overflow-hidden">
            <div className="bg-gray-50 px-4 py-2.5 border-b border-gray-100 flex justify-between items-center">
              <h3 className="text-xs font-bold text-gray-700 uppercase tracking-wider">
                3. Beban Lainnya
              </h3>
              <span className="text-xs font-bold text-gray-800">
                {formatCurrency(labaData.bebanLainya.totalAmount)}
              </span>
            </div>

            <div className="divide-y divide-gray-100 text-xs">
              {labaData.bebanLainya.items.map((it) => (
                <div key={it.code} className="p-3 flex justify-between items-center">
                  <div>
                    <span className="font-semibold text-gray-800 block">{it.name}</span>
                    <span className="text-[10px] font-mono text-gray-400">{it.code}</span>
                  </div>
                  <span className="font-bold text-rose-700">{formatCurrency(it.amount)}</span>
                </div>
              ))}
            </div>
          </div>
        )}
      </div>

      {/* Print PDF Preview Modal */}
      <PrintReportModal
        title="LAPORAN LABA RUGI"
        subtitle="SiKeZ - Sistem Keuangan Gen Z"
        isOpen={showPrintModal}
        onClose={() => setShowPrintModal(false)}
      >
        <div className="space-y-4">
          <table className="w-full text-xs border border-gray-400">
            <thead className="bg-gray-100 font-bold border-b border-gray-400">
              <tr>
                <th className="p-2 border-r border-gray-400 text-left">Keterangan Akun</th>
                <th className="p-2 text-right">Jumlah (Rp)</th>
              </tr>
            </thead>
            <tbody className="divide-y divide-gray-300">
              {/* Pendapatan Header */}
              <tr className="bg-gray-50 font-bold">
                <td className="p-2 border-r border-gray-300">PENDAPATAN DARI PENJUALAN</td>
                <td className="p-2 text-right"></td>
              </tr>
              {labaData.pendapatanDariPenjualan.items.map((it) => (
                <tr key={it.code}>
                  <td className="p-2 pl-6 border-r border-gray-300">{it.name}</td>
                  <td className="p-2 text-right">{formatCurrency(it.amount)}</td>
                </tr>
              ))}
              <tr className="font-semibold bg-emerald-50">
                <td className="p-2 border-r border-gray-300 text-right">Total Pendapatan:</td>
                <td className="p-2 text-right font-bold text-emerald-800">
                  {formatCurrency(labaData.pendapatanDariPenjualan.totalAmount)}
                </td>
              </tr>

              {/* Beban Operasional */}
              <tr className="bg-gray-50 font-bold">
                <td className="p-2 border-r border-gray-300">BEBAN OPERASIONAL</td>
                <td className="p-2 text-right"></td>
              </tr>
              {labaData.bebanOperasional.items.map((it) => (
                <tr key={it.code}>
                  <td className="p-2 pl-6 border-r border-gray-300">{it.name}</td>
                  <td className="p-2 text-right">{formatCurrency(it.amount)}</td>
                </tr>
              ))}
              <tr className="font-semibold bg-rose-50">
                <td className="p-2 border-r border-gray-300 text-right">Total Beban Operasional:</td>
                <td className="p-2 text-right font-bold text-rose-800">
                  ({formatCurrency(labaData.bebanOperasional.totalAmount)})
                </td>
              </tr>

              {/* Beban Lainnya */}
              {labaData.bebanLainya.items.length > 0 && (
                <>
                  <tr className="bg-gray-50 font-bold">
                    <td className="p-2 border-r border-gray-300">BEBAN LAINNYA</td>
                    <td className="p-2 text-right"></td>
                  </tr>
                  {labaData.bebanLainya.items.map((it) => (
                    <tr key={it.code}>
                      <td className="p-2 pl-6 border-r border-gray-300">{it.name}</td>
                      <td className="p-2 text-right">{formatCurrency(it.amount)}</td>
                    </tr>
                  ))}
                  <tr className="font-semibold bg-rose-50">
                    <td className="p-2 border-r border-gray-300 text-right">Total Beban Lainnya:</td>
                    <td className="p-2 text-right font-bold text-rose-800">
                      ({formatCurrency(labaData.bebanLainya.totalAmount)})
                    </td>
                  </tr>
                </>
              )}
            </tbody>
            <tfoot className="bg-gray-100 font-bold border-t-2 border-gray-400">
              <tr>
                <td className="p-2.5 border-r border-gray-400 text-right text-sm">
                  {isProfit ? 'LABA BERSIH:' : 'RUGI BERSIH:'}
                </td>
                <td className={`p-2.5 text-right text-sm ${isProfit ? 'text-emerald-800' : 'text-rose-800'}`}>
                  {formatCurrency(labaData.cleanResult)}
                </td>
              </tr>
            </tfoot>
          </table>
        </div>
      </PrintReportModal>
    </div>
  );
};
