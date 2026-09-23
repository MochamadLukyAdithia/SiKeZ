import React, { useState } from 'react';
import { useApp } from '../context/AppContext';

export const LoginPage: React.FC = () => {
  const { login, register } = useApp();
  const [isRegisterMode, setIsRegisterMode] = useState(false);
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [name, setName] = useState('');
  const [isLoading, setIsLoading] = useState(false);

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setIsLoading(true);
    if (isRegisterMode) {
      await register(email, password, name);
    } else {
      await login(email, password);
    }
    setIsLoading(false);
  };

  return (
    <div className="min-h-screen bg-gradient-to-b from-[#E8F5E9] via-[#F2F9F5] to-[#E2F5EB] relative flex flex-col justify-center items-center p-4 overflow-hidden">
      {/* Subtle organic pattern overlay */}
      <div
        className="absolute inset-x-0 bottom-0 top-[28%] bg-cover bg-bottom opacity-10 pointer-events-none"
        style={{ backgroundImage: "url('/assets/images/coffee_background.png')" }}
      />

      <div className="relative z-10 w-full max-w-sm my-auto">
        {/* Collaboration Partner Logos Grid */}
        <div className="flex flex-wrap items-center justify-center gap-2 mb-4 bg-white/70 p-2.5 rounded-2xl backdrop-blur-xs border border-emerald-100 shadow-xs">
          <img src="/assets/images/kemendikbud.png" alt="Kemendikbud" className="h-6 object-contain" />
          <img src="/assets/images/kampusmerdeka.png" alt="Kampus Merdeka" className="h-6 object-contain" />
          <img src="/assets/images/simbelmawa.png" alt="Simbelmawa" className="h-6 object-contain" />
          <img src="/assets/images/ppkormawa.png" alt="PPK Ormawa" className="h-6 object-contain" />
          <img src="/assets/images/unej.png" alt="UNEJ" className="h-6 object-contain" />
          <img src="/assets/images/hmja.png" alt="HMJA" className="h-6 object-contain" />
          <img src="/assets/images/ppkcompo.png" alt="PPK Compo" className="h-6 object-contain" />
          <img src="/assets/images/ojk.png" alt="OJK" className="h-6 object-contain" />
        </div>

        {/* Logo and Brand Title matching the uploaded design */}
        <div className="text-center mb-5">
          <div className="w-24 h-24 mx-auto mb-2 bg-white rounded-3xl p-2.5 shadow-lg border border-emerald-100 flex items-center justify-center">
            <img
              src="/assets/images/logo.png"
              alt="SiKeZ Logo"
              className="w-full h-full object-contain drop-shadow-sm"
            />
          </div>
          <h1 className="text-3xl font-black tracking-tight text-[#0E3B2F]">SiKeZ</h1>
          <p className="text-xs font-bold text-[#134638] tracking-wide mt-0.5">
            Aplikasi Keuangan Gen Z
          </p>
        </div>

        {/* Auth Box */}
        <div className="bg-white/95 backdrop-blur-md rounded-3xl p-6 shadow-xl border border-emerald-100">
          <h2 className="text-base font-bold text-gray-800 mb-4 text-center">
            {isRegisterMode ? 'Daftar Akun SiKeZ' : 'Masuk ke Akun Anda'}
          </h2>

          <form onSubmit={handleSubmit} className="space-y-3.5">
            {isRegisterMode && (
              <div>
                <label className="text-xs font-bold text-gray-700 block mb-1">
                  Nama Lengkap / Usaha
                </label>
                <input
                  type="text"
                  value={name}
                  onChange={(e) => setName(e.target.value)}
                  placeholder="Contoh: Alex Pratama"
                  className="w-full bg-emerald-50/50 border border-gray-200 rounded-xl p-2.5 text-xs text-gray-900 outline-none focus:ring-2 focus:ring-[#10B981] focus:border-[#10B981]"
                  required
                />
              </div>
            )}

            <div>
              <label className="text-xs font-bold text-gray-700 block mb-1">Email</label>
              <input
                type="email"
                value={email}
                onChange={(e) => setEmail(e.target.value)}
                placeholder="Masukkan email anda..."
                className="w-full bg-emerald-50/50 border border-gray-200 rounded-xl p-2.5 text-xs text-gray-900 outline-none focus:ring-2 focus:ring-[#10B981] focus:border-[#10B981]"
                required
              />
            </div>

            <div>
              <label className="text-xs font-bold text-gray-700 block mb-1">Password</label>
              <input
                type="password"
                value={password}
                onChange={(e) => setPassword(e.target.value)}
                placeholder="Masukkan kata sandi anda..."
                className="w-full bg-emerald-50/50 border border-gray-200 rounded-xl p-2.5 text-xs text-gray-900 outline-none focus:ring-2 focus:ring-[#10B981] focus:border-[#10B981]"
                required
              />
            </div>

            <div className="pt-2">
              <button
                type="submit"
                disabled={isLoading}
                className="w-full py-3 px-4 bg-gradient-primary text-white rounded-xl font-bold text-xs shadow-md hover:shadow-lg transition-transform active:scale-[0.98] cursor-pointer"
              >
                {isLoading ? 'Memproses...' : isRegisterMode ? 'Daftar Sekarang' : 'Masuk'}
              </button>
            </div>
          </form>

          {/* Divider */}
          <div className="flex items-center my-4">
            <div className="flex-1 border-t border-gray-200" />
            <span className="px-3 text-[11px] text-gray-400 font-semibold">atau</span>
            <div className="flex-1 border-t border-gray-200" />
          </div>

          <button
            type="button"
            onClick={() => setIsRegisterMode(!isRegisterMode)}
            className="w-full py-2.5 px-4 bg-gray-50 hover:bg-gray-100 text-gray-700 rounded-xl font-semibold text-xs transition-colors border border-gray-200"
          >
            {isRegisterMode ? 'Sudah punya akun? Masuk' : 'Belum punya akun? Daftar'}
          </button>
        </div>

        <p className="text-[10px] text-center text-[#0E3B2F] mt-4 font-semibold opacity-80">
          PPK Ormawa HMJA FEB Universitas Jember © {new Date().getFullYear()}
        </p>
      </div>
    </div>
  );
};
