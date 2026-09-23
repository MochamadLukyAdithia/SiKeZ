import React from 'react';

interface SikezLogoProps {
  className?: string;
  size?: number;
  showText?: boolean;
}

export const SikezLogo: React.FC<SikezLogoProps> = ({
  className = '',
  size = 40,
  showText = false,
}) => {
  return (
    <div className={`inline-flex items-center space-x-2.5 ${className}`}>
      <img
        src="/assets/images/logo.png"
        alt="SiKeZ Logo"
        style={{ width: size, height: size }}
        className="object-contain rounded-xl drop-shadow-sm shrink-0"
      />
      {showText && (
        <div className="flex flex-col">
          <span className="font-extrabold text-lg leading-tight tracking-tight text-[#0E3B2F]">
            SiKeZ
          </span>
          <span className="text-[10px] font-semibold text-[#134638] tracking-normal leading-none">
            Aplikasi Keuangan Gen Z
          </span>
        </div>
      )}
    </div>
  );
};
