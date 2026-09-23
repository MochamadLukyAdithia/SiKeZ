import { FilterMode, TransactionModel } from '../types';

export function formatCurrency(amount: number): string {
  const isNegative = amount < 0;
  const absVal = Math.abs(amount);
  const formatted = new Intl.NumberFormat('id-ID', {
    style: 'decimal',
    minimumFractionDigits: 0,
    maximumFractionDigits: 0,
  }).format(absVal);

  return `${isNegative ? '-Rp ' : 'Rp '}${formatted}`;
}

export function formatDate(dateInput: number | Date, style: 'short' | 'medium' | 'long' = 'medium'): string {
  const date = typeof dateInput === 'number' ? new Date(dateInput) : dateInput;
  if (isNaN(date.getTime())) return '-';

  if (style === 'short') {
    return date.toLocaleDateString('id-ID', {
      day: 'numeric',
      month: 'short',
      year: 'numeric',
    });
  }

  if (style === 'long') {
    return date.toLocaleDateString('id-ID', {
      weekday: 'long',
      day: 'numeric',
      month: 'long',
      year: 'numeric',
    });
  }

  return date.toLocaleDateString('id-ID', {
    day: 'numeric',
    month: 'long',
    year: 'numeric',
  });
}

export function formatTime(dateInput: number | Date): string {
  const date = typeof dateInput === 'number' ? new Date(dateInput) : dateInput;
  if (isNaN(date.getTime())) return '-';

  return date.toLocaleTimeString('id-ID', {
    hour: '2-digit',
    minute: '2-digit',
  });
}

export function isSameDay(d1: Date, d2: Date): boolean {
  return (
    d1.getFullYear() === d2.getFullYear() &&
    d1.getMonth() === d2.getMonth() &&
    d1.getDate() === d2.getDate()
  );
}

export function isSameMonth(d1: Date, targetMonth: number, targetYear?: number): boolean {
  const year = targetYear ?? new Date().getFullYear();
  return d1.getFullYear() === year && d1.getMonth() === targetMonth;
}

export function filterTransactions(
  transactions: TransactionModel[],
  filter: FilterMode,
  options?: {
    selectedDate?: Date;
    selectedMonth?: number;
    rangeStart?: Date;
    rangeEnd?: Date;
  }
): TransactionModel[] {
  const now = new Date();
  const todayStart = new Date(now.getFullYear(), now.getMonth(), now.getDate()).getTime();
  const todayEnd = todayStart + 24 * 60 * 60 * 1000 - 1;

  const yesterdayStart = todayStart - 24 * 60 * 60 * 1000;
  const yesterdayEnd = todayStart - 1;

  const last7DaysStart = todayStart - 6 * 24 * 60 * 60 * 1000;
  const last30DaysStart = todayStart - 29 * 24 * 60 * 60 * 1000;

  const thisMonthStart = new Date(now.getFullYear(), now.getMonth(), 1).getTime();
  const nextMonthStart = new Date(now.getFullYear(), now.getMonth() + 1, 1).getTime();

  const lastMonthStart = new Date(now.getFullYear(), now.getMonth() - 1, 1).getTime();
  const lastMonthEnd = thisMonthStart - 1;

  return transactions.filter((tx) => {
    const txTime = tx.date;
    const txDate = new Date(txTime);

    switch (filter) {
      case 'today':
        return txTime >= todayStart && txTime <= todayEnd;
      case 'yesterday':
        return txTime >= yesterdayStart && txTime <= yesterdayEnd;
      case 'last7Days':
        return txTime >= last7DaysStart && txTime <= todayEnd;
      case 'last30Days':
        return txTime >= last30DaysStart && txTime <= todayEnd;
      case 'thisMonth':
        return txTime >= thisMonthStart && txTime < nextMonthStart;
      case 'lastMonth':
        return txTime >= lastMonthStart && txTime <= lastMonthEnd;
      case 'selectMonth': {
        const targetM = options?.selectedMonth ?? now.getMonth();
        return isSameMonth(txDate, targetM, now.getFullYear());
      }
      case 'selectDay': {
        const targetD = options?.selectedDate ?? now;
        return isSameDay(txDate, targetD);
      }
      case 'selectRangeDate': {
        if (!options?.rangeStart || !options?.rangeEnd) return true;
        const rStart = new Date(options.rangeStart).setHours(0, 0, 0, 0);
        const rEnd = new Date(options.rangeEnd).setHours(23, 59, 59, 999);
        return txTime >= rStart && txTime <= rEnd;
      }
      case 'selectRangeMonth':
      default:
        return true;
    }
  });
}
