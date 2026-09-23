import React from 'react';
import { useApp } from '../context/AppContext';
import { calculateTotalAsset, calculateLabaRugi } from '../utils/accounting';
import { filterTransactions, formatCurrency } from '../utils/formatters';

export const DashboardHeader: React.FC = () => {
  const { transactions } = useApp();

  // 1. Total Assets from all transactions
  const totalAsset = calculateTotalAsset(transactions);

  // 2. This month transactions & profit
  const thisMonthTx = filterTransactions(transactions, 'thisMonth');
  const lastMonthTx = filterTransactions(transactions, 'lastMonth');

  const thisMonthLaba = calculateLabaRugi(thisMonthTx).cleanResult;
  const lastMonthLaba = calculateLabaRugi(lastMonthTx).cleanResult;

  let diffPercentage = 0;
  if (lastMonthLaba !== 0) {
    diffPercentage = Math.round(((thisMonthLaba - lastMonthLaba) / Math.abs(lastMonthLaba)) * 100);
  } else if (thisMonthLaba > 0) {
    diffPercentage = 100;
  }

  const isProfitPositive = thisMonthLaba >= 0;

  return (
    <div className="bg-gradient-header text-white pt-6 pb-6 px-4 rounded-b-3xl shadow-lg relative">
      <div className="max-w-md mx-auto">
        {/* Top greeting / title */}
        <div className="flex items-center justify-between mb-4">
          <div>
            <span className="text-[11px] uppercase tracking-wider text-emerald-200 font-bold">
              Aplikasi Keuangan Gen Z
            </span>
            <h2 className="text-2xl font-black tracking-tight text-white flex items-center gap-1.5">
              <span>SiKeZ</span>
              <span className="w-2 h-2 rounded-full bg-[#F59E0B] inline-block"></span>
            </h2>
          </div>
          <div className="w-12 h-12 rounded-2xl bg-white/95 p-1 shadow-md border border-emerald-200/50 flex items-center justify-center">
            <img
              src="/assets/images/logo.png"
              alt="SiKeZ Logo"
              className="w-full h-full object-contain"
            />
          </div>
        </div>

        {/* Total Asset */}
        <div className="mb-5">
          <p className="text-xs text-emerald-200/90 font-medium">Total Aset Anda</p>
          <h1 className="text-2xl font-extrabold tracking-tight mt-0.5 text-white">
            {formatCurrency(totalAsset)}
          </h1>
        </div>

        {/* Laba Rugi Card */}
        <div className="bg-white text-gray-900 rounded-2xl p-4 shadow-md flex items-center justify-between border border-emerald-100">
          <div>
            <p className="text-xs font-semibold text-gray-500">Laba Rugi Bulan Ini</p>
            <h3
              className={`text-lg font-bold mt-0.5 ${
                isProfitPositive ? 'text-emerald-700' : 'text-amber-700'
              }`}
            >
              {formatCurrency(thisMonthLaba)}
            </h3>
            <div className="flex items-center space-x-1.5 mt-1.5">
              <span
                className={`text-[10px] font-bold px-1.5 py-0.5 rounded-full ${
                  diffPercentage >= 0
                    ? 'bg-emerald-100 text-emerald-800'
                    : 'bg-amber-100 text-amber-800'
                }`}
              >
                {diffPercentage >= 0 ? `+${diffPercentage}%` : `${diffPercentage}%`}
              </span>
              <span className="text-[10px] text-gray-400">dibanding bulan lalu</span>
            </div>
          </div>

          <div className="w-14 h-14 bg-emerald-50 rounded-xl flex items-center justify-center p-2 shrink-0 border border-emerald-100">
            <img
              src="/assets/images/icon_bullish.png"
              alt="Bullish"
              className="w-10 h-10 object-contain"
            />
          </div>
        </div>
      </div>
    </div>
  );
};
