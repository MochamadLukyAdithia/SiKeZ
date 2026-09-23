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
  selectedDate: Date;
  setSelectedDate: (d: Date) => void;
  resetDemoData: () => void;
  currentRoute: string;
  navigate: (route: string, state?: unknown) => void;
  routeState: unknown;
  notification: { message: string; type: 'success' | 'error' } | null;
  showNotification: (message: string, type?: 'success' | 'error') => void;
}

const AppContext = createContext<AppContextType | undefined>(undefined);

const STORAGE_KEY_TX = 'sikez_transactions_v1';
const STORAGE_KEY_USER = 'sikez_user_v1';

export const AppProvider: React.FC<{ children: React.ReactNode }> = ({ children }) => {
  const [currentUser, setCurrentUser] = useState<UserModel | null>(() => {
    const saved = localStorage.getItem(STORAGE_KEY_USER) || localStorage.getItem('sikepi_user_v1');
    if (saved) {
      try {
        return JSON.parse(saved);
      } catch {
        return INITIAL_USER;
      }
    }
    return INITIAL_USER;
  });

  const [transactions, setTransactions] = useState<TransactionModel[]>(() => {
    const saved = localStorage.getItem(STORAGE_KEY_TX) || localStorage.getItem('sikepi_transactions_v1');
    if (saved) {
      try {
        return JSON.parse(saved);
      } catch {
        return INITIAL_TRANSACTIONS;
      }
    }
    return INITIAL_TRANSACTIONS;
  });

  const [selectedDate, setSelectedDate] = useState<Date>(new Date());
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
    // Authenticate
    const user: UserModel = {
      ...INITIAL_USER,
      email: email || INITIAL_USER.email,
    };
    setCurrentUser(user);
    showNotification('Berhasil masuk!');
    navigate('dashboard');
    return true;
  };

  const register = async (email: string, _pass: string, name?: string): Promise<boolean> => {
    const user: UserModel = {
      id: 'usr_' + Date.now(),
      name: name || 'Pengguna SiKeZ',
      email,
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
    showNotification('Transaksi berhasil dibuat!');
  };

  const removeTransaction = async (id: string) => {
    setTransactions((prev) => prev.filter((t) => t.id !== id));
    showNotification('Transaksi telah dihapus.');
  };

  const resetDemoData = () => {
    setTransactions(INITIAL_TRANSACTIONS);
    setCurrentUser(INITIAL_USER);
    showNotification('Data telah direset ke data contoh.');
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
        selectedDate,
        setSelectedDate,
        resetDemoData,
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
