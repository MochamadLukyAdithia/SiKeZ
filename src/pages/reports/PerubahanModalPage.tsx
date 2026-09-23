import React, { useState } from 'react';
import { useApp } from '../../context/AppContext';
import { HeaderBar } from '../../components/HeaderBar';
import { DateFilterBar } from '../../components/DateFilterBar';
import { PrintReportModal } from '../../components/PrintReportModal';
import { FilterMode } from '../../types';
import { calculatePerubahanModal } from '../../utils/accounting';
import { formatCurrency, formatDate } from '../../utils/formatters';

export const PerubahanModalPage: React.FC = () => {
  const { transactions } = useApp();
  const [filterMode, setFilterMode] = useState<FilterMode>('today');
  const [selectedDate, setSelectedDate] = useState<Date>(new Date());
  const [showPrintModal, setShowPrintModal] = useState(false);

  const modalData = calculatePerubahanModal(transactions, selectedDate);

  return (
    <div className="min-h-screen bg-[#F4F7F0] pb-24">
      <HeaderBar
        title="Perubahan Modal"
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
        {/* Modal Akhir Banner */}
        <div className="bg-gradient-header text-white rounded-2xl p-5 shadow-sm">
          <span className="text-xs uppercase tracking-wider text-rose-200 font-semibold">
            Modal Akhir ({formatDate(selectedDate, 'short')})
          </span>
          <h2 className="text-2xl font-extrabold mt-1">
            {formatCurrency(modalData.getModalAkhir)}
          </h2>
          <p className="text-[11px] text-rose-100 mt-2">
            Posisi modal pemilik setelah penyesuaian laba bersih dan mutasi prive.
          </p>
        </div>

        {/* Breakdown Card */}
        <div className="bg-white rounded-2xl p-5 shadow-xs border border-gray-100 space-y-3.5 text-xs">
          <div className="flex justify-between items-center py-1">
            <span className="font-semibold text-gray-700">1. Modal Awal</span>
            <span className="font-bold text-gray-900">
              {formatCurrency(modalData.modalAwal)}
            </span>
          </div>

          <div className="border-t border-gray-100" />

          <div className="flex justify-between items-center py-1">
            <div>
              <span className="font-semibold text-gray-700 block">2. Laba / Rugi Bersih</span>
              <span className="text-[10px] text-gray-400">Periode berjalan</span>
            </div>
            <span
              className={`font-bold ${
                modalData.cleanLaba >= 0 ? 'text-emerald-700' : 'text-rose-700'
              }`}
            >
              {modalData.cleanLaba >= 0 ? '+' : ''}
              {formatCurrency(modalData.cleanLaba)}
            </span>
          </div>

          <div className="border-t border-gray-100" />

          <div className="flex justify-between items-center py-1">
            <div>
              <span className="font-semibold text-gray-700 block">3. Penambahan Modal</span>
              <span className="text-[10px] text-gray-400">
                {modalData.addedModal.length} transaksi setoran
              </span>
            </div>
            <span className="font-bold text-emerald-700">
              +{formatCurrency(modalData.addedModalAmount)}
            </span>
          </div>

          <div className="border-t border-gray-100" />

          <div className="flex justify-between items-center py-1">
            <div>
              <span className="font-semibold text-gray-700 block">4. Penarikan Modal (Prive)</span>
              <span className="text-[10px] text-gray-400">
                {modalData.takedModal.length} transaksi prive
              </span>
            </div>
            <span className="font-bold text-rose-700">
              -{formatCurrency(modalData.takedModalAmount)}
            </span>
          </div>

          <div className="border-t-2 border-gray-200 pt-2 flex justify-between items-center text-sm font-bold text-gray-900">
            <span>Modal Akhir:</span>
            <span className="text-[#B33030]">{formatCurrency(modalData.getModalAkhir)}</span>
          </div>
        </div>
      </div>

      {/* Print PDF Preview Modal */}
      <PrintReportModal
        title="LAPORAN PERUBAHAN MODAL"
        subtitle="SiKeZ - Sistem Keuangan Gen Z"
        isOpen={showPrintModal}
        onClose={() => setShowPrintModal(false)}
      >
        <table className="w-full text-xs border border-gray-400">
          <thead className="bg-gray-100 font-bold border-b border-gray-400">
            <tr>
              <th className="p-2 border-r border-gray-400 text-left">Komponen Modal</th>
              <th className="p-2 text-right">Nominal (Rp)</th>
            </tr>
          </thead>
          <tbody className="divide-y divide-gray-300">
            <tr>
              <td className="p-2 border-r border-gray-300 font-medium">Modal Awal</td>
              <td className="p-2 text-right">{formatCurrency(modalData.modalAwal)}</td>
            </tr>
            <tr>
              <td className="p-2 border-r border-gray-300 font-medium">Laba / (Rugi) Bersih</td>
              <td className="p-2 text-right">{formatCurrency(modalData.cleanLaba)}</td>
            </tr>
            <tr>
              <td className="p-2 border-r border-gray-300 font-medium">Penambahan Modal</td>
              <td className="p-2 text-right">{formatCurrency(modalData.addedModalAmount)}</td>
            </tr>
            <tr>
              <td className="p-2 border-r border-gray-300 font-medium">Penarikan Modal (Prive)</td>
              <td className="p-2 text-right">({formatCurrency(modalData.takedModalAmount)})</td>
            </tr>
          </tbody>
          <tfoot className="bg-gray-100 font-bold border-t-2 border-gray-400">
            <tr>
              <td className="p-2.5 border-r border-gray-400 text-right text-sm">MODAL AKHIR:</td>
              <td className="p-2.5 text-right text-sm">{formatCurrency(modalData.getModalAkhir)}</td>
            </tr>
          </tfoot>
        </table>
      </PrintReportModal>
    </div>
  );
};
