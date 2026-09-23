import React from 'react';

interface EmptyWarningProps {
  title?: string;
  message?: string;
}

export const EmptyWarning: React.FC<EmptyWarningProps> = ({
  title = 'Tidak ada transaksi.',
  message = 'Silahkan tambahkan transaksi baru atau pilih tanggal lain.',
}) => {
  return (
    <div className="flex flex-col items-center justify-center p-8 text-center my-6">
      <img
        src="/assets/icons/transaction-minus-svgrepo-com.svg"
        alt="Kosong"
        className="w-28 h-28 mb-4 opacity-80"
      />
      <h3 className="text-lg font-bold text-gray-800 mb-1">{title}</h3>
      <p className="text-xs text-gray-500 max-w-xs">{message}</p>
    </div>
  );
};
