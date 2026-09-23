import React from 'react';
import { useApp } from './context/AppContext';
import { BottomNavbar } from './components/BottomNavbar';
import { LoginPage } from './pages/LoginPage';
import { DashboardPage } from './pages/DashboardPage';
import { AddTransactionPage } from './pages/AddTransactionPage';
import { ReportMenuPage } from './pages/ReportMenuPage';
import { ReportDetailPage } from './pages/ReportDetailPage';
import { ProfilePage } from './pages/ProfilePage';
import { ProfileEditPage } from './pages/ProfileEditPage';
import { JurnalUmumPage } from './pages/reports/JurnalUmumPage';
import { BukuBesarPage } from './pages/reports/BukuBesarPage';
import { NeracaSaldoPage } from './pages/reports/NeracaSaldoPage';
import { LabaRugiPage } from './pages/reports/LabaRugiPage';
import { PerubahanModalPage } from './pages/reports/PerubahanModalPage';
import { NeracaPage } from './pages/reports/NeracaPage';
import { TransaksiListPage } from './pages/reports/TransaksiListPage';
import { CheckCircle2, AlertCircle } from 'lucide-react';

export const App: React.FC = () => {
  const { currentRoute, isAuthenticated, notification } = useApp();

  if (!isAuthenticated || currentRoute === 'login') {
    return <LoginPage />;
  }

  const renderRoute = () => {
    switch (currentRoute) {
      case 'dashboard':
        return <DashboardPage />;
      case 'add-transaction':
        return <AddTransactionPage />;
      case 'report':
        return <ReportMenuPage />;
      case 'report-detail':
        return <ReportDetailPage />;
      case 'report/transaksi':
        return <TransaksiListPage />;
      case 'report/jurnal':
        return <JurnalUmumPage />;
      case 'report/buku':
        return <BukuBesarPage />;
      case 'report/neracaSaldo':
        return <NeracaSaldoPage />;
      case 'report/laba':
        return <LabaRugiPage />;
      case 'report/modal':
        return <PerubahanModalPage />;
      case 'report/neraca':
        return <NeracaPage />;
      case 'profile':
        return <ProfilePage />;
      case 'profile/edit':
        return <ProfileEditPage />;
      default:
        return <DashboardPage />;
    }
  };

  return (
    <div className="min-h-screen bg-[#F4F7F0] flex justify-center text-gray-800 antialiased font-['Poppins',sans-serif]">
      {/* Toast Notification */}
      {notification && (
        <div className="fixed top-4 left-1/2 -translate-x-1/2 z-50 animate-bounce duration-300">
          <div
            className={`flex items-center space-x-2 px-4 py-2.5 rounded-full shadow-lg text-xs font-semibold ${
              notification.type === 'error'
                ? 'bg-rose-600 text-white'
                : 'bg-emerald-700 text-white'
            }`}
          >
            {notification.type === 'error' ? (
              <AlertCircle className="w-4 h-4" />
            ) : (
              <CheckCircle2 className="w-4 h-4" />
            )}
            <span>{notification.message}</span>
          </div>
        </div>
      )}

      {/* Main Container constrained to mobile phone screen / desktop card */}
      <div className="w-full max-w-md bg-[#F4F7F0] min-h-screen relative shadow-lg">
        {renderRoute()}
        <BottomNavbar />
      </div>
    </div>
  );
};
