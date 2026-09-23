import { TransactionModel, UserModel } from '../types';

export const INITIAL_USER: UserModel = {
  id: '',
  name: '',
  email: '',
  phoneNumber: '',
  address: '',
  imageUrl: '',
  joinedAt: Date.now(),
};

// Default empty transactions for real user onboarding
export const INITIAL_TRANSACTIONS: TransactionModel[] = [];

