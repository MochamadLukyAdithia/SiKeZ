import React from 'react';
import { useApp } from '../context/AppContext';

export const BottomNavbar: React.FC = () => {
  const { currentRoute, navigate } = useApp();

  const isMainTab = ['dashboard', 'report', 'profile'].includes(currentRoute);
  if (!isMainTab) return null;

  return (
    <div className="fixed bottom-0 left-0 right-0 max-w-md mx-auto bg-white border-t border-gray-200 shadow-[0_-4px_10px_rgba(0,0,0,0.06)] z-40">
      <div className="flex justify-around items-center h-16 px-4">
        {/* Home/Dashboard */}
        <button
          onClick={() => navigate('dashboard')}
          className="flex flex-col items-center justify-center flex-1 py-1 transition-colors"
        >
          <img
            src={
              currentRoute === 'dashboard'
                ? '/assets/icons/home-icon-on.svg'
                : '/assets/icons/home-icon-off.svg'
            }
            alt="Dashboard"
            className="w-6 h-6 object-contain"
          />
          <span
            className={`text-xs mt-1 font-medium ${
              currentRoute === 'dashboard' ? 'text-[#0E3B2F] font-bold' : 'text-gray-500'
            }`}
          >
            Dashboard
          </span>
        </button>

        {/* Laporan */}
        <button
          onClick={() => navigate('report')}
          className="flex flex-col items-center justify-center flex-1 py-1 transition-colors"
        >
          <img
            src={
              currentRoute === 'report'
                ? '/assets/icons/report-icon-on.svg'
                : '/assets/icons/report-icon-off.svg'
            }
            alt="Laporan"
            className="w-6 h-6 object-contain"
          />
          <span
            className={`text-xs mt-1 font-medium ${
              currentRoute === 'report' ? 'text-[#0E3B2F] font-bold' : 'text-gray-500'
            }`}
          >
            Laporan
          </span>
        </button>

        {/* Profile */}
        <button
          onClick={() => navigate('profile')}
          className="flex flex-col items-center justify-center flex-1 py-1 transition-colors"
        >
          <img
            src={
              currentRoute === 'profile'
                ? '/assets/icons/profile-icon-on.svg'
                : '/assets/icons/profile-icon-off.svg'
            }
            alt="Profile"
            className="w-6 h-6 object-contain"
          />
          <span
            className={`text-xs mt-1 font-medium ${
              currentRoute === 'profile' ? 'text-[#0E3B2F] font-bold' : 'text-gray-500'
            }`}
          >
            Profile
          </span>
        </button>
      </div>
    </div>
  );
};
