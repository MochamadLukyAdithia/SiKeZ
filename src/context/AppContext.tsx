import React, { createContext, useContext, useState, useEffect } from 'react';
import { TransactionModel, UserModel } from '../types';

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
  clearAllTransactions: () => void;
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

const STORAGE_KEY_TX = 'sikez_transactions_v2';
const STORAGE_KEY_USER = 'sikez_user_v2';
const STORAGE_KEY_USERS_DB = 'sikez_users_db_v2';

export const AppProvider: React.FC<{ children: React.ReactNode }> = ({ children }) => {
  const [currentUser, setCurrentUser] = useState<UserModel | null>(() => {
    const saved = localStorage.getItem(STORAGE_KEY_USER);
    if (saved) {
      try {
        const parsed = JSON.parse(saved);
        if (parsed && parsed.email) return parsed;
      } catch {
        return null;
      }
    }
    return null;
  });

  const [transactions, setTransactions] = useState<TransactionModel[]>(() => {
    const saved = localStorage.getItem(STORAGE_KEY_TX);
    if (saved) {
      try {
        const parsed = JSON.parse(saved);
        if (Array.isArray(parsed)) return parsed;
      } catch {
        return [];
      }
    }
    return [];
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

  const login = async (email: string, pass: string): Promise<boolean> => {
    if (!email.trim()) {
      showNotification('Silakan masukkan email Anda.', 'error');
      return false;
    }

    try {
      const usersDbRaw = localStorage.getItem(STORAGE_KEY_USERS_DB);
      const usersDb: Record<string, { password?: string; user: UserModel }> = usersDbRaw ? JSON.parse(usersDbRaw) : {};
      const normalizedEmail = email.trim().toLowerCase();

      let targetUser: UserModel;
      if (usersDb[normalizedEmail]) {
        // Registered user found
        if (pass && usersDb[normalizedEmail].password && usersDb[normalizedEmail].password !== pass) {
          showNotification('Kata sandi salah. Silakan coba lagi.', 'error');
          return false;
        }
        targetUser = usersDb[normalizedEmail].user;
      } else {
        // Allow seamless login for new real users
        targetUser = {
          id: 'usr_' + Date.now(),
          name: '',
          email: email.trim(),
          phoneNumber: '',
          address: '',
          imageUrl: '',
          joinedAt: Date.now(),
        };
        usersDb[normalizedEmail] = { password: pass, user: targetUser };
        localStorage.setItem(STORAGE_KEY_USERS_DB, JSON.stringify(usersDb));
      }

      setCurrentUser(targetUser);
      showNotification('Berhasil masuk!');
      navigate('dashboard');
      return true;
    } catch {
      const fallbackUser: UserModel = {
        id: 'usr_' + Date.now(),
        name: '',
        email: email.trim(),
        phoneNumber: '',
        address: '',
        imageUrl: '',
        joinedAt: Date.now(),
      };
      setCurrentUser(fallbackUser);
      showNotification('Berhasil masuk!');
      navigate('dashboard');
      return true;
    }
  };

  const register = async (email: string, pass: string, name?: string): Promise<boolean> => {
    if (!email.trim()) {
      showNotification('Silakan masukkan email Anda.', 'error');
      return false;
    }

    const normalizedEmail = email.trim().toLowerCase();
    const newUser: UserModel = {
      id: 'usr_' + Date.now(),
      name: name?.trim() || '',
      email: normalizedEmail,
      phoneNumber: '',
      address: '',
      imageUrl: '',
      joinedAt: Date.now(),
    };

    try {
      const usersDbRaw = localStorage.getItem(STORAGE_KEY_USERS_DB);
      const usersDb: Record<string, { password?: string; user: UserModel }> = usersDbRaw ? JSON.parse(usersDbRaw) : {};
      usersDb[normalizedEmail] = { password: pass, user: newUser };
      localStorage.setItem(STORAGE_KEY_USERS_DB, JSON.stringify(usersDb));
    } catch (e) {
      console.warn('Gagal menyimpan ke users DB', e);
    }

    setCurrentUser(newUser);
    showNotification('Akun berhasil didaftarkan!');
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
    const updated: UserModel = { ...currentUser, ...data };
    setCurrentUser(updated);

    // Also update users DB
    try {
      const usersDbRaw = localStorage.getItem(STORAGE_KEY_USERS_DB);
      const usersDb: Record<string, { password?: string; user: UserModel }> = usersDbRaw ? JSON.parse(usersDbRaw) : {};
      const normalizedEmail = currentUser.email.trim().toLowerCase();
      if (usersDb[normalizedEmail]) {
        usersDb[normalizedEmail].user = updated;
        localStorage.setItem(STORAGE_KEY_USERS_DB, JSON.stringify(usersDb));
      }
    } catch (e) {
      console.warn('Gagal update users DB', e);
    }

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

  const clearAllTransactions = () => {
    setTransactions([]);
    localStorage.removeItem(STORAGE_KEY_TX);
    showNotification('Semua transaksi telah dibersihkan.');
  };

  const resetDemoData = () => {
    clearAllTransactions();
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
        clearAllTransactions,
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
