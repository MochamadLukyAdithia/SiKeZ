import React, { useState, useEffect } from 'react';
import { Camera, X, ArrowLeft, Check } from 'lucide-react';
import { useApp } from '../context/AppContext';
import { INITIAL_ACCOUNTS, TRANSACTION_TYPES } from '../constants/accounts';
import { AccountModel, TransactionTypeModel } from '../types';
import { formatCurrency } from '../utils/formatters';

export const AddTransactionPage: React.FC = () => {
  const { addTransaction, navigate, showNotification } = useApp();

  const [date, setDate] = useState<string>(new Date().toISOString().substring(0, 10));
  const [time, setTime] = useState<string>(
    new Date().toLocaleTimeString('id-ID', { hour: '2-digit', minute: '2-digit' }).replace('.', ':')
  );

  const [selectedType, setSelectedType] = useState<TransactionTypeModel>(TRANSACTION_TYPES[0]);
  const [debitAccount, setDebitAccount] = useState<AccountModel | null>(null);
  const [creditAccount, setCreditAccount] = useState<AccountModel | null>(null);
  const [nominal, setNominal] = useState<string>('');
  const [notes, setNotes] = useState<string>('');
  const [imagePreview, setImagePreview] = useState<string | null>(null);
  const [isSubmitting, setIsSubmitting] = useState(false);

  // Compute proper debits and credits based on transaction type rules from Flutter controller
  const getProperDebits = (typeId: number): AccountModel[] => {
    switch (typeId) {
      case 1:
        return INITIAL_ACCOUNTS.filter((a) => a.code === '1-1100');
      case 2:
        return INITIAL_ACCOUNTS.filter((a) => /^[125]/.test(a.code));
      case 3:
        return INITIAL_ACCOUNTS.filter((a) => a.code === '1-1300');
      case 4:
      case 5:
        return INITIAL_ACCOUNTS.filter((a) => /^[15]/.test(a.code));
      case 6:
        return INITIAL_ACCOUNTS.filter((a) => a.code.startsWith('1'));
      case 7:
        return INITIAL_ACCOUNTS.filter((a) => a.code === '3-1200');
      case 8:
        return INITIAL_ACCOUNTS.filter((a) => a.code === '1-1100');
      default:
        return INITIAL_ACCOUNTS;
    }
  };

  const getProperCredits = (typeId: number): AccountModel[] => {
    switch (typeId) {
      case 1:
        return INITIAL_ACCOUNTS.filter((a) => a.code === '4-1100');
      case 2:
        return INITIAL_ACCOUNTS.filter((a) => a.code === '1-1100');
      case 3:
        return INITIAL_ACCOUNTS.filter((a) => a.code === '4-1100');
      case 4:
        return INITIAL_ACCOUNTS.filter((a) => a.code === '2-1100');
      case 5:
        return INITIAL_ACCOUNTS.filter((a) => a.code === '1-1100');
      case 6:
        return INITIAL_ACCOUNTS.filter((a) => a.code === '3-1100');
      case 7:
        return INITIAL_ACCOUNTS.filter((a) => a.code.startsWith('1'));
      case 8:
        return INITIAL_ACCOUNTS.filter((a) => a.code === '2-2100');
      default:
        return INITIAL_ACCOUNTS;
    }
  };

  // Sync default debit and credit when transaction type changes
  useEffect(() => {
    const debits = getProperDebits(selectedType.id);
    const credits = getProperCredits(selectedType.id);

    if (selectedType.id === 1) {
      setDebitAccount(INITIAL_ACCOUNTS.find((a) => a.code === '1-1100') || debits[0]);
      setCreditAccount(INITIAL_ACCOUNTS.find((a) => a.code === '4-1100') || credits[0]);
    } else if (selectedType.id === 2) {
      setDebitAccount(INITIAL_ACCOUNTS.find((a) => a.code === '5-1100') || debits[0]);
      setCreditAccount(INITIAL_ACCOUNTS.find((a) => a.code === '1-1100') || credits[0]);
    } else if (selectedType.id === 3) {
      setDebitAccount(INITIAL_ACCOUNTS.find((a) => a.code === '1-1300') || debits[0]);
      setCreditAccount(INITIAL_ACCOUNTS.find((a) => a.code === '4-1100') || credits[0]);
    } else if (selectedType.id === 4) {
      setDebitAccount(INITIAL_ACCOUNTS.find((a) => a.code === '1-1500') || debits[0]);
      setCreditAccount(INITIAL_ACCOUNTS.find((a) => a.code === '2-1100') || credits[0]);
    } else if (selectedType.id === 5) {
      setDebitAccount(INITIAL_ACCOUNTS.find((a) => a.code === '5-1200') || debits[0]);
      setCreditAccount(INITIAL_ACCOUNTS.find((a) => a.code === '1-1100') || credits[0]);
    } else if (selectedType.id === 6) {
      setDebitAccount(INITIAL_ACCOUNTS.find((a) => a.code === '1-1100') || debits[0]);
      setCreditAccount(INITIAL_ACCOUNTS.find((a) => a.code === '3-1100') || credits[0]);
    } else if (selectedType.id === 7) {
      setDebitAccount(INITIAL_ACCOUNTS.find((a) => a.code === '3-1200') || debits[0]);
      setCreditAccount(INITIAL_ACCOUNTS.find((a) => a.code === '1-1100') || credits[0]);
    } else if (selectedType.id === 8) {
      setDebitAccount(INITIAL_ACCOUNTS.find((a) => a.code === '1-1100') || debits[0]);
      setCreditAccount(INITIAL_ACCOUNTS.find((a) => a.code === '2-2100') || credits[0]);
    }
  }, [selectedType]);

  const handleImageChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const file = e.target.files?.[0];
    if (file) {
      const reader = new FileReader();
      reader.onloadend = () => {
        setImagePreview(reader.result as string);
      };
      reader.readAsDataURL(file);
    }
  };

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();

    const numericNominal = Number(nominal.replace(/[^0-9]/g, ''));
    if (!numericNominal || numericNominal <= 0) {
      showNotification('Mohon masukkan nominal yang valid', 'error');
      return;
    }

    if (!debitAccount || !creditAccount) {
      showNotification('Mohon lengkapi akun Debit dan Kredit', 'error');
      return;
    }

    setIsSubmitting(true);

    const [hours, minutes] = time.split(':').map(Number);
    const txDate = new Date(date);
    if (!isNaN(hours) && !isNaN(minutes)) {
      txDate.setHours(hours, minutes, 0, 0);
    }

    await addTransaction({
      transactionId: selectedType.id,
      transactionName: selectedType.name,
      debitCode: debitAccount.code,
      debitName: debitAccount.name,
      creditCode: creditAccount.code,
      creditName: creditAccount.name,
      nominal: numericNominal,
      notes: notes || '-',
      imageUrl: imagePreview || '',
      date: txDate.getTime(),
    });

    setIsSubmitting(false);
    navigate('dashboard');
  };

  const properDebits = getProperDebits(selectedType.id);
  const properCredits = getProperCredits(selectedType.id);
  const numVal = Number(nominal.replace(/[^0-9]/g, '')) || 0;

  return (
    <div className="min-h-screen bg-[#F4F7F0] pb-24">
      {/* Header */}
      <div className="sticky top-0 z-30 bg-gradient-primary text-white shadow-md">
        <div className="flex items-center justify-between px-4 h-14">
          <div className="flex items-center space-x-3">
            <button
              onClick={() => navigate('dashboard')}
              className="p-1.5 -ml-1 text-white hover:bg-white/10 rounded-full transition-colors active:scale-95"
            >
              <ArrowLeft className="w-5 h-5" />
            </button>
            <h1 className="text-lg font-semibold tracking-wide">Tambah Transaksi</h1>
          </div>
        </div>
      </div>

      <div className="max-w-md mx-auto p-4">
        <form onSubmit={handleSubmit} className="space-y-4">
          {/* Tanggal & Waktu */}
          <div className="bg-white p-4 rounded-2xl shadow-xs border border-gray-100">
            <label className="text-xs font-bold text-gray-700 uppercase tracking-wider block mb-2">
              Tanggal & Waktu Transaksi*
            </label>
            <div className="grid grid-cols-2 gap-3">
              <div>
                <span className="text-[10px] text-gray-500 block mb-1">Tanggal:</span>
                <input
                  type="date"
                  value={date}
                  onChange={(e) => setDate(e.target.value)}
                  className="w-full bg-gray-50 border border-gray-300 rounded-lg p-2.5 text-xs text-gray-900 font-medium outline-none focus:ring-2 focus:ring-[#A1B57D]"
                  required
                />
              </div>
              <div>
                <span className="text-[10px] text-gray-500 block mb-1">Jam:</span>
                <input
                  type="time"
                  value={time}
                  onChange={(e) => setTime(e.target.value)}
                  className="w-full bg-gray-50 border border-gray-300 rounded-lg p-2.5 text-xs text-gray-900 font-medium outline-none focus:ring-2 focus:ring-[#A1B57D]"
                  required
                />
              </div>
            </div>
          </div>

          {/* Jenis Transaksi */}
          <div className="bg-white p-4 rounded-2xl shadow-xs border border-gray-100">
            <label className="text-xs font-bold text-gray-700 uppercase tracking-wider block mb-2">
              Jenis Transaksi*
            </label>
            <select
              value={selectedType.id}
              onChange={(e) => {
                const found = TRANSACTION_TYPES.find((t) => t.id === Number(e.target.value));
                if (found) setSelectedType(found);
              }}
              className="w-full bg-gray-50 border border-gray-300 rounded-lg p-2.5 text-sm text-gray-900 font-medium outline-none focus:ring-2 focus:ring-[#A1B57D] cursor-pointer"
            >
              {TRANSACTION_TYPES.map((type) => (
                <option key={type.id} value={type.id}>
                  {type.name}
                </option>
              ))}
            </select>
            {selectedType.description && (
              <p className="text-[11px] text-gray-500 mt-1.5 italic">
                {selectedType.description}
              </p>
            )}
          </div>

          {/* Debit & Credit Accounts */}
          <div className="bg-white p-4 rounded-2xl shadow-xs border border-gray-100 space-y-3">
            <div>
              <div className="flex justify-between items-center mb-1">
                <label className="text-xs font-bold text-gray-700 uppercase tracking-wider">
                  Debit*
                </label>
                <span className="text-[10px] text-gray-400">
                  {properDebits.length > 1 ? 'Pilih akun yang sesuai' : 'Ditentukan otomatis'}
                </span>
              </div>
              <select
                value={debitAccount?.code || ''}
                onChange={(e) => {
                  const acc = INITIAL_ACCOUNTS.find((a) => a.code === e.target.value);
                  if (acc) setDebitAccount(acc);
                }}
                disabled={properDebits.length <= 1}
                className={`w-full border rounded-lg p-2.5 text-sm font-medium outline-none ${
                  properDebits.length <= 1
                    ? 'bg-gray-100 border-gray-200 text-gray-600 cursor-not-allowed'
                    : 'bg-gray-50 border-gray-300 text-gray-900 focus:ring-2 focus:ring-[#A1B57D]'
                }`}
              >
                {properDebits.map((acc) => (
                  <option key={acc.code} value={acc.code}>
                    {acc.code} - {acc.name}
                  </option>
                ))}
              </select>
            </div>

            <div>
              <div className="flex justify-between items-center mb-1">
                <label className="text-xs font-bold text-gray-700 uppercase tracking-wider">
                  Kredit*
                </label>
                <span className="text-[10px] text-gray-400">
                  {properCredits.length > 1 ? 'Pilih akun yang sesuai' : 'Ditentukan otomatis'}
                </span>
              </div>
              <select
                value={creditAccount?.code || ''}
                onChange={(e) => {
                  const acc = INITIAL_ACCOUNTS.find((a) => a.code === e.target.value);
                  if (acc) setCreditAccount(acc);
                }}
                disabled={properCredits.length <= 1}
                className={`w-full border rounded-lg p-2.5 text-sm font-medium outline-none ${
                  properCredits.length <= 1
                    ? 'bg-gray-100 border-gray-200 text-gray-600 cursor-not-allowed'
                    : 'bg-gray-50 border-gray-300 text-gray-900 focus:ring-2 focus:ring-[#A1B57D]'
                }`}
              >
                {properCredits.map((acc) => (
                  <option key={acc.code} value={acc.code}>
                    {acc.code} - {acc.name}
                  </option>
                ))}
              </select>
            </div>
          </div>

          {/* Nominal */}
          <div className="bg-white p-4 rounded-2xl shadow-xs border border-gray-100">
            <div className="flex justify-between items-center mb-1">
              <label className="text-xs font-bold text-gray-700 uppercase tracking-wider">
                Nominal Transaksi*
              </label>
              {numVal > 0 && (
                <span className="text-xs font-bold text-emerald-700">
                  {formatCurrency(numVal)}
                </span>
              )}
            </div>
            <div className="relative mt-1">
              <span className="absolute left-3 top-3 text-sm font-semibold text-gray-500">
                Rp
              </span>
              <input
                type="number"
                value={nominal}
                onChange={(e) => setNominal(e.target.value)}
                placeholder="Masukkan nominal (contoh: 500000)"
                className="w-full bg-gray-50 border border-gray-300 rounded-lg py-2.5 pl-10 pr-3 text-sm text-gray-900 font-semibold outline-none focus:ring-2 focus:ring-[#A1B57D]"
                required
                min="1"
              />
            </div>
          </div>

          {/* Catatan */}
          <div className="bg-white p-4 rounded-2xl shadow-xs border border-gray-100">
            <label className="text-xs font-bold text-gray-700 uppercase tracking-wider block mb-1">
              Catatan / Keterangan
            </label>
            <textarea
              value={notes}
              onChange={(e) => setNotes(e.target.value)}
              placeholder="Contoh: Pembelian bibit kopi Robusta 200 batang..."
              rows={2}
              className="w-full bg-gray-50 border border-gray-300 rounded-lg p-2.5 text-xs text-gray-900 outline-none focus:ring-2 focus:ring-[#A1B57D]"
            />
          </div>

          {/* Bukti Transaksi */}
          <div className="bg-white p-4 rounded-2xl shadow-xs border border-gray-100">
            <label className="text-xs font-bold text-gray-700 uppercase tracking-wider block mb-2">
              Bukti Transaksi (Nota / Foto Fisik)
            </label>

            {imagePreview ? (
              <div className="relative rounded-xl overflow-hidden border border-gray-200 mb-3 w-32 h-32 group">
                <img
                  src={imagePreview}
                  alt="Bukti preview"
                  className="w-full h-full object-cover"
                />
                <button
                  type="button"
                  onClick={() => setImagePreview(null)}
                  className="absolute top-1 right-1 bg-black/60 text-white rounded-full p-1 hover:bg-black/80 transition-colors"
                >
                  <X className="w-4 h-4" />
                </button>
              </div>
            ) : null}

            <label className="flex items-center justify-center space-x-2 border-2 border-dashed border-gray-300 rounded-xl p-3 text-center cursor-pointer hover:border-[#A1B57D] transition-colors bg-gray-50">
              <Camera className="w-5 h-5 text-gray-500" />
              <span className="text-xs font-semibold text-gray-600">
                Ambil Foto atau Pilih Gambar
              </span>
              <input
                type="file"
                accept="image/*"
                onChange={handleImageChange}
                className="hidden"
              />
            </label>
          </div>

          {/* Submit Button */}
          <div className="pt-2">
            <button
              type="submit"
              disabled={isSubmitting}
              className="w-full py-3.5 px-4 bg-gradient-primary text-white rounded-xl font-bold text-sm shadow-md hover:shadow-lg transition-transform active:scale-[0.98] flex items-center justify-center space-x-2"
            >
              <Check className="w-4 h-4" />
              <span>{isSubmitting ? 'Menyimpan...' : 'Simpan Transaksi'}</span>
            </button>
          </div>
        </form>
      </div>
    </div>
  );
};
