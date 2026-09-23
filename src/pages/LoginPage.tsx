import React, { useState } from 'react';
import { useApp } from '../context/AppContext';

export const LoginPage: React.FC = () => {
  const { login, register } = useApp();
  const [isRegisterMode, setIsRegisterMode] = useState(false);
  const [email, setEmail] = useState('sikez@unej.ac.id');
  const [password, setPassword] = useState('password123');
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

  const handleDemoLogin = async () => {
    setIsLoading(true);
    await login('sikez@unej.ac.id', 'demo123');
    setIsLoading(false);
  };

  return (
    <div className="min-h-screen bg-[#D3ECA7] relative flex flex-col justify-center items-center p-4 overflow-hidden">
      {/* Coffee background texture overlay */}
      <div
        className="absolute inset-x-0 bottom-0 top-[28%] bg-cover bg-bottom opacity-20 pointer-events-none"
        style={{ backgroundImage: "url('/assets/images/coffee_background.png')" }}
      />

      <div className="relative z-10 w-full max-w-sm my-auto">
        {/* Collaboration Partner Logos Grid */}
        <div className="flex flex-wrap items-center justify-center gap-2 mb-4 bg-white/40 p-2.5 rounded-2xl backdrop-blur-xs">
          <img src="/assets/images/kemendikbud.png" alt="Kemendikbud" className="h-6 object-contain" />
          <img src="/assets/images/kampusmerdeka.png" alt="Kampus Merdeka" className="h-6 object-contain" />
          <img src="/assets/images/simbelmawa.png" alt="Simbelmawa" className="h-6 object-contain" />
          <img src="/assets/images/ppkormawa.png" alt="PPK Ormawa" className="h-6 object-contain" />
          <img src="/assets/images/unej.png" alt="UNEJ" className="h-6 object-contain" />
          <img src="/assets/images/hmja.png" alt="HMJA" className="h-6 object-contain" />
          <img src="/assets/images/ppkcompo.png" alt="PPK Compo" className="h-6 object-contain" />
          <img src="/assets/images/ojk.png" alt="OJK" className="h-6 object-contain" />
        </div>

        {/* Title */}
        <div className="text-center mb-6">
          <h1 className="text-3xl font-extrabold tracking-tight text-[#B33030]">SiKeZ</h1>
          <p className="text-xs font-semibold text-[#4D1515] italic mt-0.5">
            "Sistem Keuangan Gen Z"
          </p>
        </div>

        {/* Auth Box */}
        <div className="bg-white/95 backdrop-blur-md rounded-3xl p-6 shadow-xl border border-white/60">
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
                  className="w-full bg-gray-50 border border-gray-300 rounded-xl p-2.5 text-xs text-gray-900 outline-none focus:ring-2 focus:ring-[#A1B57D]"
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
                className="w-full bg-gray-50 border border-gray-300 rounded-xl p-2.5 text-xs text-gray-900 outline-none focus:ring-2 focus:ring-[#A1B57D]"
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
                className="w-full bg-gray-50 border border-gray-300 rounded-xl p-2.5 text-xs text-gray-900 outline-none focus:ring-2 focus:ring-[#A1B57D]"
                required
              />
            </div>

            <div className="pt-2 space-y-2">
              <button
                type="submit"
                disabled={isLoading}
                className="w-full py-3 px-4 bg-gradient-primary text-white rounded-xl font-bold text-xs shadow-md hover:shadow-lg transition-transform active:scale-[0.98]"
              >
                {isLoading ? 'Memproses...' : isRegisterMode ? 'Daftar Sekarang' : 'Masuk'}
              </button>

              <button
                type="button"
                onClick={handleDemoLogin}
                className="w-full py-2.5 px-4 bg-[#A1B57D] hover:bg-[#8f9e6b] text-white rounded-xl font-semibold text-xs shadow-xs transition-colors"
              >
                Masuk Cepat Sebagai Demo SiKeZ
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
            className="w-full py-2.5 px-4 bg-gray-100 hover:bg-gray-200 text-gray-800 rounded-xl font-semibold text-xs transition-colors"
          >
            {isRegisterMode ? 'Sudah punya akun? Masuk' : 'Belum punya akun? Daftar'}
          </button>
        </div>

        <p className="text-[10px] text-center text-[#4D1515] mt-4 font-medium">
          PPK Ormawa HMJA FEB Universitas Jember © {new Date().getFullYear()}
        </p>
      </div>
    </div>
  );
};
