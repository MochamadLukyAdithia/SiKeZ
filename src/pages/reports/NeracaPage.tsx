import React, { useState } from 'react';
import { useApp } from '../../context/AppContext';
import { HeaderBar } from '../../components/HeaderBar';
import { DateFilterBar } from '../../components/DateFilterBar';
import { PrintReportModal } from '../../components/PrintReportModal';
import { FilterMode } from '../../types';
import { calculateNeraca } from '../../utils/accounting';
import { formatCurrency, formatDate } from '../../utils/formatters';

export const NeracaPage: React.FC = () => {
  const { transactions } = useApp();
  const [filterMode, setFilterMode] = useState<FilterMode>('today');
  const [selectedDate, setSelectedDate] = useState<Date>(new Date());
  const [showPrintModal, setShowPrintModal] = useState(false);

  const neracaData = calculateNeraca(transactions, selectedDate);
  const totalPasiva = neracaData.hutangTotal + neracaData.modalTotal;
  const isBalanced = Math.abs(neracaData.hartaLancarTotal - totalPasiva) < 2;

  return (
    <div className="min-h-screen bg-[#F4F7F0] pb-24">
      <HeaderBar
        title="Laporan Neraca"
        showBack
        onPrint={() => setShowPrintModal(true)}
      />

      <DateFilterBar
        currentFilter={filterMode}
        onFilterChange={setFilterMode}
        availableFilters={['today', 'selectDay']}
        selectedDate={selectedDate}
        onDateChange={setSelectedDate}
      />

      <div className="max-w-md mx-auto p-4 space-y-4">
        {/* Balance Status Banner */}
        <div className="bg-white rounded-2xl p-4 shadow-xs border border-gray-100 flex items-center justify-between">
          <div>
            <span className="text-[10px] uppercase tracking-wider text-gray-400 font-bold block">
              Posisi Keuangan per {formatDate(selectedDate, 'short')}
            </span>
            <span className="text-xs font-semibold text-gray-700">Keseimbangan Neraca:</span>
          </div>
          <span
            className={`text-xs font-bold px-3 py-1 rounded-full border ${
              isBalanced
                ? 'text-emerald-800 bg-emerald-50 border-emerald-300'
                : 'text-amber-800 bg-amber-50 border-amber-300'
            }`}
          >
            {isBalanced ? '✓ Seimbang (Balanced)' : 'Selisih Pembukuan'}
          </span>
        </div>

        {/* 1. AKTIVA (Aset / Harta) */}
        <div className="bg-white rounded-2xl shadow-xs border border-gray-100 overflow-hidden">
          <div className="bg-[#09231C] text-white px-4 py-2.5 flex justify-between items-center">
            <h3 className="text-xs font-bold uppercase tracking-wider">AKTIVA (ASET USAHA)</h3>
            <span className="text-xs font-bold text-[#7BE495]">
              {formatCurrency(neracaData.hartaLancarTotal)}
            </span>
          </div>

          <div className="divide-y divide-gray-100 text-xs">
            {neracaData.hartaLancarList.map((harta) => (
              <div key={harta.code} className="p-3 flex justify-between items-center">
                <div>
                  <span className="font-semibold text-gray-800 block">{harta.name}</span>
                  <span className="text-[10px] font-mono text-gray-400">{harta.code}</span>
                </div>
                <span className="font-bold text-gray-900">{formatCurrency(harta.nominal)}</span>
              </div>
            ))}
          </div>

          <div className="bg-gray-50 px-4 py-3 border-t border-gray-200 flex justify-between items-center text-xs font-bold text-gray-900">
            <span>TOTAL AKTIVA:</span>
            <span className="text-emerald-700">{formatCurrency(neracaData.hartaLancarTotal)}</span>
          </div>
        </div>

        {/* 2. PASIVA (Kewajiban & Ekuitas) */}
        <div className="bg-white rounded-2xl shadow-xs border border-gray-100 overflow-hidden">
          <div className="bg-[#0E3B2F] text-white px-4 py-2.5 flex justify-between items-center">
            <h3 className="text-xs font-bold uppercase tracking-wider">
              PASIVA (KEWAJIBAN & EKUITAS)
            </h3>
            <span className="text-xs font-bold text-white">{formatCurrency(totalPasiva)}</span>
          </div>

          {/* Kewajiban / Hutang Section */}
          <div className="p-3 bg-gray-50 font-bold text-gray-700 text-xs border-b border-gray-200 flex justify-between">
            <span>A. KEWAJIBAN / HUTANG</span>
            <span>{formatCurrency(neracaData.hutangTotal)}</span>
          </div>
          <div className="divide-y divide-gray-100 text-xs">
            {neracaData.hutangList.length === 0 ? (
              <p className="p-3 text-gray-400 italic">Tidak ada hutang tercatat.</p>
            ) : (
              neracaData.hutangList.map((hutang) => (
                <div key={hutang.code} className="p-3 flex justify-between items-center">
                  <div>
                    <span className="font-semibold text-gray-800 block">{hutang.name}</span>
                    <span className="text-[10px] font-mono text-gray-400">{hutang.code}</span>
                  </div>
                  <span className="font-bold text-gray-900">{formatCurrency(hutang.nominal)}</span>
                </div>
              ))
            )}
          </div>

          {/* Ekuitas / Modal Section */}
          <div className="p-3 bg-gray-50 font-bold text-gray-700 text-xs border-y border-gray-200 flex justify-between">
            <span>B. EKUITAS / MODAL</span>
            <span>{formatCurrency(neracaData.modalTotal)}</span>
          </div>
          <div className="divide-y divide-gray-100 text-xs">
            {neracaData.modalList.map((modal) => (
              <div key={modal.code} className="p-3 flex justify-between items-center">
                <div>
                  <span className="font-semibold text-gray-800 block">{modal.name}</span>
                  <span className="text-[10px] font-mono text-gray-400">{modal.code}</span>
                </div>
                <span className="font-bold text-gray-900">{formatCurrency(modal.nominal)}</span>
              </div>
            ))}
            {/* Laba Rugi Berjalan row */}
            <div className="p-3 flex justify-between items-center bg-gray-50/50">
              <div>
                <span className="font-semibold text-gray-800 block">Laba / Rugi Berjalan</span>
                <span className="text-[10px] text-gray-400">Akumulasi hasil usaha tani</span>
              </div>
              <span
                className={`font-bold ${
                  neracaData.labaRugi >= 0 ? 'text-emerald-700' : 'text-rose-700'
                }`}
              >
                {formatCurrency(neracaData.labaRugi)}
              </span>
            </div>
          </div>

          <div className="bg-gray-100 px-4 py-3 border-t-2 border-gray-300 flex justify-between items-center text-xs font-bold text-gray-900">
            <span>TOTAL PASIVA (Hutang + Modal):</span>
            <span className="text-[#0E3B2F]">{formatCurrency(totalPasiva)}</span>
          </div>
        </div>
      </div>

      {/* Print PDF Preview Modal */}
      <PrintReportModal
        title="LAPORAN NERACA (POSISI KEUANGAN)"
        subtitle="SiKeZ - Aplikasi Keuangan Gen Z (Standar SAK EMKM)"
        isOpen={showPrintModal}
        onClose={() => setShowPrintModal(false)}
      >
        <div className="grid grid-cols-2 gap-4">
          {/* Kolom Aktiva */}
          <div className="border border-gray-400">
            <div className="bg-gray-100 p-2 font-bold text-center border-b border-gray-400 text-xs">
              AKTIVA (ASET)
            </div>
            <table className="w-full text-xs">
              <tbody className="divide-y divide-gray-200">
                {neracaData.hartaLancarList.map((it) => (
                  <tr key={it.code}>
                    <td className="p-2">{it.name}</td>
                    <td className="p-2 text-right font-medium">{formatCurrency(it.nominal)}</td>
                  </tr>
                ))}
              </tbody>
              <tfoot className="border-t-2 border-gray-400 bg-gray-50 font-bold">
                <tr>
                  <td className="p-2">TOTAL AKTIVA:</td>
                  <td className="p-2 text-right text-emerald-800">
                    {formatCurrency(neracaData.hartaLancarTotal)}
                  </td>
                </tr>
              </tfoot>
            </table>
          </div>

          {/* Kolom Pasiva */}
          <div className="border border-gray-400">
            <div className="bg-gray-100 p-2 font-bold text-center border-b border-gray-400 text-xs">
              PASIVA (KEWAJIBAN & EKUITAS)
            </div>
            <table className="w-full text-xs">
              <tbody className="divide-y divide-gray-200">
                <tr className="bg-gray-50 font-semibold">
                  <td colSpan={2} className="p-1 text-[11px] text-gray-600">
                    Kewajiban:
                  </td>
                </tr>
                {neracaData.hutangList.map((it) => (
                  <tr key={it.code}>
                    <td className="p-2 pl-4">{it.name}</td>
                    <td className="p-2 text-right">{formatCurrency(it.nominal)}</td>
                  </tr>
                ))}
                <tr className="bg-gray-50 font-semibold">
                  <td colSpan={2} className="p-1 text-[11px] text-gray-600">
                    Ekuitas / Modal:
                  </td>
                </tr>
                {neracaData.modalList.map((it) => (
                  <tr key={it.code}>
                    <td className="p-2 pl-4">{it.name}</td>
                    <td className="p-2 text-right">{formatCurrency(it.nominal)}</td>
                  </tr>
                ))}
                <tr>
                  <td className="p-2 pl-4 font-medium">Laba / (Rugi) Berjalan</td>
                  <td className="p-2 text-right font-medium">
                    {formatCurrency(neracaData.labaRugi)}
                  </td>
                </tr>
              </tbody>
              <tfoot className="border-t-2 border-gray-400 bg-gray-50 font-bold">
                <tr>
                  <td className="p-2">TOTAL PASIVA:</td>
                  <td className="p-2 text-right text-rose-800">{formatCurrency(totalPasiva)}</td>
                </tr>
              </tfoot>
            </table>
          </div>
        </div>
      </PrintReportModal>
    </div>
  );
};
