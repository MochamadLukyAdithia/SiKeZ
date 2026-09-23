import React from 'react';
import { Calendar, ChevronDown } from 'lucide-react';
import { FilterMode } from '../types';
import { formatDate } from '../utils/formatters';

interface DateFilterBarProps {
  currentFilter: FilterMode;
  onFilterChange: (filter: FilterMode) => void;
  availableFilters?: FilterMode[];
  selectedDate?: Date;
  onDateChange?: (date: Date) => void;
  selectedMonth?: number;
  onMonthChange?: (month: number) => void;
  rangeStart?: Date;
  rangeEnd?: Date;
  onRangeChange?: (start: Date, end: Date) => void;
}

const MONTH_NAMES = [
  'Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni',
  'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember',
];

export const DateFilterBar: React.FC<DateFilterBarProps> = ({
  currentFilter,
  onFilterChange,
  availableFilters = [
    'today',
    'thisMonth',
    'lastMonth',
    'selectMonth',
    'last7Days',
    'last30Days',
    'selectRangeDate',
  ],
  selectedDate = new Date(),
  onDateChange,
  selectedMonth = new Date().getMonth(),
  onMonthChange,
  rangeStart = new Date(Date.now() - 7 * 24 * 60 * 60 * 1000),
  rangeEnd = new Date(),
  onRangeChange,
}) => {
  const getFilterLabel = (filter: FilterMode): string => {
    switch (filter) {
      case 'today':
        return `Hari ini, ${formatDate(new Date(), 'short')}`;
      case 'yesterday':
        return 'Kemarin';
      case 'last7Days':
        return '7 Hari Terakhir';
      case 'last30Days':
        return '30 Hari Terakhir';
      case 'thisMonth':
        return 'Bulan ini';
      case 'lastMonth':
        return 'Bulan lalu';
      case 'selectMonth':
        return 'Pilih bulan';
      case 'selectRangeDate':
        return 'Pilih rentang tanggal';
      case 'selectDay':
        return 'Pilih hari';
      default:
        return filter;
    }
  };

  return (
    <div className="bg-white border-b border-gray-200 p-3 shadow-xs">
      <div className="flex flex-col gap-2">
        <div className="relative">
          <select
            value={currentFilter}
            onChange={(e) => onFilterChange(e.target.value as FilterMode)}
            className="w-full appearance-none bg-gray-50 border border-gray-300 text-gray-800 text-sm rounded-lg py-2.5 pl-3 pr-10 focus:ring-2 focus:ring-[#A1B57D] focus:border-[#A1B57D] outline-none font-medium cursor-pointer"
          >
            {availableFilters.map((f) => (
              <option key={f} value={f}>
                {getFilterLabel(f)}
              </option>
            ))}
          </select>
          <ChevronDown className="w-4 h-4 text-gray-500 absolute right-3 top-3.5 pointer-events-none" />
        </div>

        {/* Dynamic sub-pickers based on filter */}
        {currentFilter === 'selectMonth' && (
          <div className="flex items-center gap-2 pt-1">
            <span className="text-xs text-gray-500 font-medium whitespace-nowrap">Bulan:</span>
            <select
              value={selectedMonth}
              onChange={(e) => onMonthChange && onMonthChange(Number(e.target.value))}
              className="flex-1 bg-white border border-gray-300 text-xs rounded-md py-1.5 px-2 outline-none focus:ring-1 focus:ring-[#A1B57D]"
            >
              {MONTH_NAMES.map((name, idx) => (
                <option key={idx} value={idx}>
                  {name} {new Date().getFullYear()}
                </option>
              ))}
            </select>
          </div>
        )}

        {currentFilter === 'selectDay' && (
          <div className="flex items-center gap-2 pt-1">
            <Calendar className="w-4 h-4 text-[#A1B57D]" />
            <input
              type="date"
              value={selectedDate.toISOString().substring(0, 10)}
              onChange={(e) => {
                if (e.target.value && onDateChange) {
                  onDateChange(new Date(e.target.value));
                }
              }}
              className="flex-1 bg-white border border-gray-300 text-xs rounded-md py-1 px-2 outline-none focus:ring-1 focus:ring-[#A1B57D]"
            />
          </div>
        )}

        {currentFilter === 'selectRangeDate' && (
          <div className="grid grid-cols-2 gap-2 pt-1">
            <div>
              <span className="text-[10px] text-gray-500 block mb-0.5">Dari:</span>
              <input
                type="date"
                value={rangeStart.toISOString().substring(0, 10)}
                onChange={(e) => {
                  if (e.target.value && onRangeChange) {
                    onRangeChange(new Date(e.target.value), rangeEnd);
                  }
                }}
                className="w-full bg-white border border-gray-300 text-xs rounded-md py-1 px-2 outline-none focus:ring-1 focus:ring-[#A1B57D]"
              />
            </div>
            <div>
              <span className="text-[10px] text-gray-500 block mb-0.5">Sampai:</span>
              <input
                type="date"
                value={rangeEnd.toISOString().substring(0, 10)}
                onChange={(e) => {
                  if (e.target.value && onRangeChange) {
                    onRangeChange(rangeStart, new Date(e.target.value));
                  }
                }}
                className="w-full bg-white border border-gray-300 text-xs rounded-md py-1 px-2 outline-none focus:ring-1 focus:ring-[#A1B57D]"
              />
            </div>
          </div>
        )}
      </div>
    </div>
  );
};
