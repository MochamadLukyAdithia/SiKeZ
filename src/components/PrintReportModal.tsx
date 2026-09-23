import React from 'react';
import { X, Printer } from 'lucide-react';
import { formatDate } from '../utils/formatters';

interface PrintReportModalProps {
  title: string;
  subtitle?: string;
  isOpen: boolean;
  onClose: () => void;
  children: React.ReactNode;
}

export const PrintReportModal: React.FC<PrintReportModalProps> = ({
  title,
  subtitle = 'Sistem Keuangan Petani Kopi (SIKEPI)',
  isOpen,
  onClose,
  children,
}) => {
  if (!isOpen) return null;

  const handlePrint = () => {
    window.print();
  };

  return (
    <div className="fixed inset-0 z-50 bg-black/70 flex flex-col justify-between overflow-hidden animate-fadeIn">
      {/* Top action bar */}
      <div className="bg-[#19282F] text-white px-4 py-3 flex items-center justify-between shadow-md shrink-0 no-print">
        <div className="flex items-center space-x-2">
          <span className="font-semibold text-sm">PDF Preview: {title}</span>
        </div>
        <div className="flex items-center space-x-2">
          <button
            onClick={handlePrint}
            className="flex items-center space-x-1.5 bg-[#A1B57D] hover:bg-[#8e9f6c] text-white text-xs px-3 py-1.5 rounded-md font-medium transition-colors"
          >
            <Printer className="w-3.5 h-3.5" />
            <span>Cetak / PDF</span>
          </button>
          <button
            onClick={onClose}
            className="p-1.5 hover:bg-white/10 rounded-full transition-colors text-gray-300 hover:text-white"
          >
            <X className="w-5 h-5" />
          </button>
        </div>
      </div>

      {/* Printable Sheet (A4 ratio feel) */}
      <div className="flex-1 overflow-y-auto p-4 md:p-8 flex justify-center bg-gray-600/40">
        <div className="bg-white text-gray-900 w-full max-w-3xl shadow-2xl rounded-sm p-6 md:p-10 my-auto min-h-[600px] border border-gray-200 print:shadow-none print:m-0 print:p-0 print:border-none">
          {/* Document Header */}
          <div className="border-b-2 border-dashed border-gray-400 pb-4 mb-6">
            <div className="flex justify-between items-start">
              <div>
                <h1 className="text-xl font-bold tracking-tight text-gray-900">{title}</h1>
                <p className="text-xs text-gray-600 font-medium mt-0.5">{subtitle}</p>
                <p className="text-[11px] text-gray-500 mt-1">
                  PPK Ormawa HMJA Universitas Jember • Kelompok Tani Kopi
                </p>
              </div>
              <div className="text-right">
                <span className="text-[10px] text-gray-400 block uppercase tracking-wider font-semibold">
                  Tanggal Cetak
                </span>
                <span className="text-xs font-semibold text-gray-800">
                  {formatDate(new Date(), 'long')}
                </span>
              </div>
            </div>
          </div>

          {/* Report Body */}
          <div className="text-sm">{children}</div>

          {/* Signature / Footer */}
          <div className="mt-12 pt-6 border-t border-gray-200 flex justify-between items-end text-xs text-gray-600">
            <div>
              <p className="text-[11px] text-gray-500">
                Dicetak melalui aplikasi SIKEPI (Sistem Keuangan Petani Kopi)
              </p>
            </div>
            <div className="text-center w-40">
              <p className="text-gray-500 mb-14">Petani / Pengelola</p>
              <div className="border-b border-gray-400 w-full mb-1"></div>
              <p className="font-semibold text-gray-800">( Pengurus Usaha )</p>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
};
