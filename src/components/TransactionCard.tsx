import React from 'react';
import { Trash2, ChevronRight, ArrowUpRight, ArrowDownLeft } from 'lucide-react';
import { TransactionModel } from '../types';
import { formatCurrency, formatDate } from '../utils/formatters';

interface TransactionCardProps {
  transaction: TransactionModel;
  onSelect: (tx: TransactionModel) => void;
  onDelete?: (id: string) => void;
}

export const TransactionCard: React.FC<TransactionCardProps> = ({
  transaction,
  onSelect,
  onDelete,
}) => {
  const isIncome = transaction.creditCode.startsWith('4') || transaction.creditCode.startsWith('3');
  const isExpense = transaction.debitCode.startsWith('5');

  return (
    <div
      onClick={() => onSelect(transaction)}
      className="bg-white rounded-xl p-3.5 mb-2.5 shadow-xs border border-gray-100 hover:shadow-md transition-all cursor-pointer flex items-center justify-between group active:scale-[0.99]"
    >
      <div className="flex items-center space-x-3 min-w-0">
        <div
          className={`w-11 h-11 rounded-full flex items-center justify-center shrink-0 ${
            isIncome
              ? 'bg-emerald-50 text-emerald-600'
              : isExpense
              ? 'bg-rose-50 text-rose-600'
              : 'bg-amber-50 text-amber-700'
          }`}
        >
          {isIncome ? (
            <ArrowDownLeft className="w-5 h-5" />
          ) : isExpense ? (
            <ArrowUpRight className="w-5 h-5" />
          ) : (
            <img src="/assets/icons/transaction.svg" alt="tx" className="w-5 h-5 opacity-70" />
          )}
        </div>

        <div className="min-w-0">
          <div className="flex items-center space-x-2">
            <h4 className="text-sm font-semibold text-gray-900 truncate">
              {transaction.transactionName}
            </h4>
          </div>
          <p className="text-xs text-gray-500 truncate">
            {transaction.debitName} <span className="text-gray-400">→</span> {transaction.creditName}
          </p>
          <div className="flex items-center space-x-2 mt-0.5">
            <span className="text-[11px] text-gray-400">
              {formatDate(transaction.date, 'short')}
            </span>
            {transaction.imageUrl && (
              <span className="text-[10px] bg-blue-50 text-blue-600 px-1.5 py-0.5 rounded-sm font-medium">
                Ada Bukti
              </span>
            )}
          </div>
        </div>
      </div>

      <div className="flex items-center space-x-2 pl-2 shrink-0">
        <div className="text-right">
          <p
            className={`text-sm font-bold ${
              isIncome
                ? 'text-emerald-600'
                : isExpense
                ? 'text-rose-600'
                : 'text-gray-900'
            }`}
          >
            {isIncome ? '+' : isExpense ? '-' : ''}
            {formatCurrency(transaction.nominal)}
          </p>
          <p className="text-[10px] text-gray-400 capitalize">
            {transaction.notes ? (transaction.notes.length > 15 ? transaction.notes.slice(0, 15) + '...' : transaction.notes) : 'Tanpa catatan'}
          </p>
        </div>

        {onDelete && (
          <button
            onClick={(e) => {
              e.stopPropagation();
              if (window.confirm(`Hapus transaksi "${transaction.transactionName}"?`)) {
                onDelete(transaction.id);
              }
            }}
            className="p-1.5 text-gray-300 hover:text-rose-500 rounded-md transition-colors opacity-0 group-hover:opacity-100 focus:opacity-100"
            title="Hapus Transaksi"
          >
            <Trash2 className="w-4 h-4" />
          </button>
        )}

        <ChevronRight className="w-4 h-4 text-gray-300" />
      </div>
    </div>
  );
};
