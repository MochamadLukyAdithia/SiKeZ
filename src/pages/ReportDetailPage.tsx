import React, { useState } from 'react';
import { ArrowLeft, Printer, Image as ImageIcon } from 'lucide-react';
import { useApp } from '../context/AppContext';
import { TransactionModel } from '../types';
import { formatCurrency, formatDate, formatTime } from '../utils/formatters';
import { PrintReportModal } from '../components/PrintReportModal';

export const ReportDetailPage: React.FC = () => {
  const { routeState, navigate } = useApp();
  const transaction = routeState as TransactionModel | undefined;
  const [showPrintModal, setShowPrintModal] = useState(false);

  if (!transaction) {
    return (
      <div className="min-h-screen bg-[#F4F7F0] flex flex-col items-center justify-center p-6 text-center">
        <p className="text-sm text-gray-600 mb-4">Transaksi tidak ditemukan.</p>
        <button
          onClick={() => navigate('dashboard')}
          className="px-4 py-2 bg-[#B33030] text-white rounded-lg text-xs font-semibold"
        >
          Kembali ke Dashboard
        </button>
      </div>
    );
  }

  return (
    <div className="min-h-screen bg-[#F4F7F0] pb-24">
      {/* Header */}
      <div className="sticky top-0 z-30 bg-gradient-primary text-white shadow-md">
        <div className="flex items-center justify-between px-4 h-14">
          <div className="flex items-center space-x-3">
            <button
              onClick={() => navigate('dashboard')}
              className="p-1.5 -ml-1 text-white hover:bg-white/10 rounded-full transition-colors active:scale-95"
            >
              <ArrowLeft className="w-5 h-5" />
            </button>
            <h1 className="text-lg font-semibold tracking-wide">Detail Laporan</h1>
          </div>
          <button
            onClick={() => setShowPrintModal(true)}
            className="p-2 text-white hover:bg-white/10 rounded-full transition-colors active:scale-95"
            title="Cetak Bukti Transaksi"
          >
            <Printer className="w-5 h-5" />
          </button>
        </div>
      </div>

      <div className="max-w-md mx-auto p-4 space-y-4">
        {/* Main Details Card */}
        <div className="bg-white rounded-2xl p-5 shadow-xs border border-gray-100 space-y-4">
          {/* Transaksi Name */}
          <div className="flex justify-between items-center text-sm">
            <span className="text-gray-500 font-medium">Transaksi</span>
            <span className="font-bold text-gray-900">{transaction.transactionName}</span>
          </div>

          <div className="border-t border-gray-100" />

          {/* Tanggal & Waktu */}
          <div className="flex justify-between items-center text-sm">
            <span className="text-gray-500 font-medium">Tanggal</span>
            <div className="text-right">
              <span className="font-bold text-gray-900 block">
                {formatDate(transaction.date, 'long')}
              </span>
              <span className="text-xs text-gray-400">
                Pukul {formatTime(transaction.date)} WIB
              </span>
            </div>
          </div>

          <div className="border-t border-gray-100" />

          {/* Nominal */}
          <div className="flex justify-between items-center text-sm">
            <span className="text-gray-500 font-medium">Nominal</span>
            <span className="text-lg font-extrabold text-[#B33030]">
              {formatCurrency(transaction.nominal)}
            </span>
          </div>

          <div className="border-t border-gray-100" />

          {/* Double entry accounting table */}
          <div>
            <span className="text-xs font-bold text-gray-600 block mb-2 uppercase tracking-wider">
              Jurnal Berpasangan
            </span>
            <div className="border border-gray-200 rounded-xl overflow-hidden">
              <table className="w-full text-xs text-left">
                <thead className="bg-gray-100 font-bold text-gray-700 border-b border-gray-200">
                  <tr>
                    <th className="p-2.5">Akun</th>
                    <th className="p-2.5 text-right">Debit</th>
                    <th className="p-2.5 text-right">Kredit</th>
                  </tr>
                </thead>
                <tbody className="divide-y divide-gray-200">
                  <tr>
                    <td className="p-2.5 font-medium text-gray-900">
                      {transaction.debitName}{' '}
                      <span className="text-gray-400 text-[10px]">({transaction.debitCode})</span>
                    </td>
                    <td className="p-2.5 text-right font-bold text-emerald-700">
                      {formatCurrency(transaction.nominal)}
                    </td>
                    <td className="p-2.5 text-right text-gray-400">Rp 0</td>
                  </tr>
                  <tr>
                    <td className="p-2.5 pl-6 font-medium text-gray-900">
                      {transaction.creditName}{' '}
                      <span className="text-gray-400 text-[10px]">({transaction.creditCode})</span>
                    </td>
                    <td className="p-2.5 text-right text-gray-400">Rp 0</td>
                    <td className="p-2.5 text-right font-bold text-rose-700">
                      {formatCurrency(transaction.nominal)}
                    </td>
                  </tr>
                </tbody>
              </table>
            </div>
          </div>

          <div className="border-t border-gray-100" />

          {/* Catatan */}
          <div className="text-sm">
            <span className="text-gray-500 font-medium block mb-1">Catatan</span>
            <p className="bg-gray-50 p-3 rounded-xl text-gray-800 font-medium text-xs leading-relaxed border border-gray-100">
              {transaction.notes || 'Tidak ada catatan.'}
            </p>
          </div>

          <div className="border-t border-gray-100" />

          {/* Lampiran */}
          <div>
            <span className="text-xs font-bold text-gray-600 block mb-2 uppercase tracking-wider">
              Lampiran Bukti Fisik
            </span>
            {transaction.imageUrl ? (
              <div className="rounded-xl overflow-hidden border border-gray-200 shadow-xs">
                <img
                  src={transaction.imageUrl}
                  alt="Bukti transaksi"
                  className="w-full max-h-64 object-cover"
                />
              </div>
            ) : (
              <div className="p-6 bg-gray-50 rounded-xl border border-dashed border-gray-300 text-center">
                <ImageIcon className="w-8 h-8 text-gray-400 mx-auto mb-1" />
                <p className="text-xs text-gray-400 font-medium">Belum ada bukti dilampirkan</p>
              </div>
            )}
          </div>
        </div>
      </div>

      {/* Printable Voucher Modal */}
      <PrintReportModal
        title="BUKTI TRANSAKSI KEUANGAN"
        subtitle="SiKeZ - Sistem Keuangan Gen Z"
        isOpen={showPrintModal}
        onClose={() => setShowPrintModal(false)}
      >
        <div className="space-y-4">
          <div className="grid grid-cols-2 gap-4 pb-4 border-b border-gray-200 text-xs">
            <div>
              <p className="text-gray-500">ID Transaksi:</p>
              <p className="font-bold text-gray-800 font-mono">{transaction.id}</p>
              <p className="text-gray-500 mt-2">Jenis Transaksi:</p>
              <p className="font-bold text-gray-800">{transaction.transactionName}</p>
            </div>
            <div className="text-right">
              <p className="text-gray-500">Tanggal & Waktu:</p>
              <p className="font-bold text-gray-800">
                {formatDate(transaction.date, 'long')} {formatTime(transaction.date)} WIB
              </p>
              <p className="text-gray-500 mt-2">Status:</p>
              <p className="font-bold text-emerald-700">Tercatat di Pembukuan</p>
            </div>
          </div>

          <div className="py-2">
            <h4 className="font-bold text-xs uppercase tracking-wider mb-2 text-gray-700">
              Rincian Jurnal Akuntansi
            </h4>
            <table className="w-full text-xs border border-gray-300">
              <thead className="bg-gray-100 font-bold border-b border-gray-300">
                <tr>
                  <th className="p-2 border-r border-gray-300 text-left">Kode</th>
                  <th className="p-2 border-r border-gray-300 text-left">Nama Akun</th>
                  <th className="p-2 border-r border-gray-300 text-right">Debit (Rp)</th>
                  <th className="p-2 text-right">Kredit (Rp)</th>
                </tr>
              </thead>
              <tbody className="divide-y divide-gray-300">
                <tr>
                  <td className="p-2 border-r border-gray-300 font-mono">{transaction.debitCode}</td>
                  <td className="p-2 border-r border-gray-300">{transaction.debitName}</td>
                  <td className="p-2 border-r border-gray-300 text-right font-medium">
                    {formatCurrency(transaction.nominal)}
                  </td>
                  <td className="p-2 text-right text-gray-400">0</td>
                </tr>
                <tr>
                  <td className="p-2 border-r border-gray-300 font-mono">{transaction.creditCode}</td>
                  <td className="p-2 border-r border-gray-300 pl-6">{transaction.creditName}</td>
                  <td className="p-2 border-r border-gray-300 text-right text-gray-400">0</td>
                  <td className="p-2 text-right font-medium">
                    {formatCurrency(transaction.nominal)}
                  </td>
                </tr>
              </tbody>
              <tfoot className="bg-gray-50 font-bold border-t-2 border-gray-400">
                <tr>
                  <td colSpan={2} className="p-2 border-r border-gray-300 text-right">
                    Total:
                  </td>
                  <td className="p-2 border-r border-gray-300 text-right">
                    {formatCurrency(transaction.nominal)}
                  </td>
                  <td className="p-2 text-right">{formatCurrency(transaction.nominal)}</td>
                </tr>
              </tfoot>
            </table>
          </div>

          <div className="pt-2">
            <p className="text-xs text-gray-500 font-medium">Catatan / Keterangan:</p>
            <p className="text-xs text-gray-800 italic bg-gray-50 p-2 rounded border border-gray-200 mt-1">
              "{transaction.notes || '-'}"
            </p>
          </div>
        </div>
      </PrintReportModal>
    </div>
  );
};
