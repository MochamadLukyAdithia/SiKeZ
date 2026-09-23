import React from 'react';
import { ArrowLeft, Printer } from 'lucide-react';
import { useApp } from '../context/AppContext';

interface HeaderBarProps {
  title: string;
  showBack?: boolean;
  onBack?: () => void;
  onPrint?: () => void;
  customAction?: React.ReactNode;
}

export const HeaderBar: React.FC<HeaderBarProps> = ({
  title,
  showBack = false,
  onBack,
  onPrint,
  customAction,
}) => {
  const { navigate } = useApp();

  const handleBack = () => {
    if (onBack) {
      onBack();
    } else {
      navigate('report');
    }
  };

  return (
    <div className="sticky top-0 z-30 bg-gradient-primary text-white shadow-md">
      <div className="flex items-center justify-between px-4 h-14">
        <div className="flex items-center space-x-3">
          {showBack && (
            <button
              onClick={handleBack}
              className="p-1.5 -ml-1 text-white hover:bg-white/10 rounded-full transition-colors active:scale-95"
              aria-label="Kembali"
            >
              <ArrowLeft className="w-5 h-5" />
            </button>
          )}
          <h1 className="text-lg font-semibold tracking-wide truncate">{title}</h1>
        </div>

        <div className="flex items-center space-x-1">
          {onPrint && (
            <button
              onClick={onPrint}
              className="p-2 text-white hover:bg-white/10 rounded-full transition-colors active:scale-95"
              title="Cetak / Simpan PDF"
              aria-label="Cetak / Simpan PDF"
            >
              <Printer className="w-5 h-5" />
            </button>
          )}
          {customAction}
        </div>
      </div>
    </div>
  );
};
