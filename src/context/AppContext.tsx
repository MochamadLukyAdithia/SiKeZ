import React, { createContext, useContext, useState, useEffect } from 'react';
import { TransactionModel, UserModel } from '../types';
import { INITIAL_TRANSACTIONS, INITIAL_USER } from '../constants/initialData';

interface AppContextType {
  currentUser: UserModel | null;
  isAuthenticated: boolean;
  login: (email: string, pass: string) => Promise<boolean>;
  register: (email: string, pass: string, name?: string) => Promise<boolean>;
  logout: () => void;
  updateProfile: (data: Partial<UserModel>) => void;
  transactions: TransactionModel[];
  addTransaction: (tx: Omit<TransactionModel, 'id'>) => Promise<void>;
  removeTransaction: (id: string) => Promise<void>;
  importTransactions: (newTxs: TransactionModel[], replace?: boolean) => void;
  selectedDate: Date;
  setSelectedDate: (d: Date) => void;
  resetDefaultData: () => void;
  currentRoute: string;
  navigate: (route: string, state?: unknown) => void;
  routeState: unknown;
  notification: { message: string; type: 'success' | 'error' } | null;
  showNotification: (message: string, type?: 'success' | 'error') => void;
}

const AppContext = createContext<AppContextType | undefined>(undefined);

// Bumped to v5 to ensure fresh Dirty Ledger dataset
const STORAGE_KEY_TX = 'sikez_transactions_v5';
const STORAGE_KEY_USER = 'sikez_user_v5';

export const AppProvider: React.FC<{ children: React.ReactNode }> = ({ children }) => {
  const [currentUser, setCurrentUser] = useState<UserModel | null>(() => {
    const saved = localStorage.getItem(STORAGE_KEY_USER);
    if (saved) {
      try {
        const parsed = JSON.parse(saved);
        if (parsed.email === 'dirtyledgergame@gmail.com') {
          return {
            ...INITIAL_USER,
            ...parsed,
            name: 'Dirty Ledger',
            address: 'Dusun Krajan, Lojejer, Wuluhan, Jember, Jawa Timur 68162',
            phoneNumber: '0821-4200-8899',
            imageUrl: '',
          };
        }
        return parsed;
      } catch {
        return INITIAL_USER;
      }
    }
    return INITIAL_USER;
  });

  const [transactions, setTransactions] = useState<TransactionModel[]>(() => {
    const saved = localStorage.getItem(STORAGE_KEY_TX);
    if (saved) {
      try {
        const parsed = JSON.parse(saved);
        // Cleanse if old coffee mock data was stored
        const hasStaleCoffee =
          Array.isArray(parsed) &&
          parsed.some(
            (t: TransactionModel) =>
              (t.debitName || '').toLowerCase().includes('kopi') ||
              (t.creditName || '').toLowerCase().includes('kopi') ||
              (t.notes || '').toLowerCase().includes('kopi') ||
              (t.notes || '').toLowerCase().includes('pupuk')
          );
        if (hasStaleCoffee || parsed.length === 0) {
          return INITIAL_TRANSACTIONS;
        }
        return parsed;
      } catch {
        return INITIAL_TRANSACTIONS;
      }
    }
    return INITIAL_TRANSACTIONS;
  });

  const [selectedDate, setSelectedDate] = useState<Date>(new Date(2026, 8, 15));
  const [currentRoute, setCurrentRoute] = useState<string>('dashboard');
  const [routeState, setRouteState] = useState<unknown>(null);
  const [notification, setNotification] = useState<{ message: string; type: 'success' | 'error' } | null>(null);

  useEffect(() => {
    localStorage.setItem(STORAGE_KEY_TX, JSON.stringify(transactions));
  }, [transactions]);

  useEffect(() => {
    if (currentUser) {
      localStorage.setItem(STORAGE_KEY_USER, JSON.stringify(currentUser));
    } else {
      localStorage.removeItem(STORAGE_KEY_USER);
    }
  }, [currentUser]);

  const showNotification = (message: string, type: 'success' | 'error' = 'success') => {
    setNotification({ message, type });
    setTimeout(() => {
      setNotification(null);
    }, 3500);
  };

  const login = async (email: string, _pass: string): Promise<boolean> => {
    const cleanEmail = email.trim() || 'dirtyledgergame@gmail.com';
    const isDirtyLedger = cleanEmail.toLowerCase().includes('dirtyledger');
    const user: UserModel = {
      ...INITIAL_USER,
      id: isDirtyLedger ? 'usr_dirtyledger' : 'usr_' + Date.now(),
      email: cleanEmail,
      name: isDirtyLedger ? 'Dirty Ledger' : 'Pengguna SiKeZ',
      phoneNumber: isDirtyLedger ? '0821-4200-8899' : '',
      address: isDirtyLedger ? 'Dusun Krajan, Lojejer, Wuluhan, Jember, Jawa Timur 68162' : '',
      imageUrl: '', // Blank by default, icon orang single
    };
    setCurrentUser(user);
    if (isDirtyLedger) {
      setTransactions(INITIAL_TRANSACTIONS);
    }
    showNotification('Berhasil masuk ke akun ' + cleanEmail);
    navigate('dashboard');
    return true;
  };

  const register = async (email: string, _pass: string, name?: string): Promise<boolean> => {
    const user: UserModel = {
      id: 'usr_' + Date.now(),
      name: name?.trim() || 'Pengguna SiKeZ',
      email: email.trim(),
      phoneNumber: '',
      address: '',
      imageUrl: '',
      joinedAt: Date.now(),
    };
    setCurrentUser(user);
    showNotification('Berhasil mendaftar akun baru!');
    navigate('dashboard');
    return true;
  };

  const logout = () => {
    setCurrentUser(null);
    setCurrentRoute('login');
    showNotification('Anda telah keluar dari aplikasi.');
  };

  const updateProfile = (data: Partial<UserModel>) => {
    if (!currentUser) return;
    const updated = { ...currentUser, ...data };
    setCurrentUser(updated);
    showNotification('Profil berhasil diperbarui!');
  };

  const addTransaction = async (txData: Omit<TransactionModel, 'id'>) => {
    const newTx: TransactionModel = {
      ...txData,
      id: 'tx_' + Date.now() + '_' + Math.random().toString(36).substring(2, 7),
    };
    setTransactions((prev) => [newTx, ...prev]);
    showNotification('Transaksi berhasil dicatat!');
  };

  const removeTransaction = async (id: string) => {
    setTransactions((prev) => prev.filter((t) => t.id !== id));
    showNotification('Transaksi telah dihapus.');
  };

  const importTransactions = (newTxs: TransactionModel[], replace: boolean = false) => {
    if (replace) {
      setTransactions(newTxs);
      showNotification(`Berhasil mengganti data dengan ${newTxs.length} transaksi dari CSV!`);
    } else {
      setTransactions((prev) => [...newTxs, ...prev]);
      showNotification(`Berhasil mengimpor ${newTxs.length} transaksi baru!`);
    }
  };

  const resetDefaultData = () => {
    setTransactions(INITIAL_TRANSACTIONS);
    setCurrentUser(INITIAL_USER);
    showNotification('Data telah dipulihkan ke siklus akuntansi Dirty Ledger 15 September 2026.');
  };

  const navigate = (route: string, state?: unknown) => {
    setRouteState(state);
    setCurrentRoute(route);
    window.scrollTo(0, 0);
  };

  return (
    <AppContext.Provider
      value={{
        currentUser,
        isAuthenticated: !!currentUser,
        login,
        register,
        logout,
        updateProfile,
        transactions,
        addTransaction,
        removeTransaction,
        importTransactions,
        selectedDate,
        setSelectedDate,
        resetDefaultData,
        currentRoute,
        navigate,
        routeState,
        notification,
        showNotification,
      }}
    >
      {children}
    </AppContext.Provider>
  );
};

export const useApp = () => {
  const context = useContext(AppContext);
  if (!context) {
    throw new Error('useApp must be used within an AppProvider');
  }
  return context;
};
