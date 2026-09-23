import React from 'react';
import { User, Phone, MapPin, Edit3, LogOut, RefreshCw, Mail } from 'lucide-react';
import { useApp } from '../context/AppContext';

export const ProfilePage: React.FC = () => {
  const { currentUser, logout, navigate, resetDemoData } = useApp();

  return (
    <div className="min-h-screen bg-[#F4F7F0] pb-24">
      {/* Header Banner with Coffee Background */}
      <div className="relative">
        <div
          className="h-44 w-full bg-cover bg-center relative"
          style={{ backgroundImage: "url('/assets/images/coffee_background.png')" }}
        >
          <div className="absolute inset-0 bg-gradient-to-b from-[#19282F]/70 via-[#19282F]/50 to-[#B33030]/80" />
          <div className="absolute top-4 left-4 right-4 flex justify-between items-center text-white">
            <h1 className="text-lg font-bold">Profil Pengguna</h1>
            <span className="text-xs bg-white/20 px-2 py-0.5 rounded-full font-medium">
              Petani Kopi
            </span>
          </div>
        </div>

        {/* Circular Avatar */}
        <div className="absolute -bottom-12 left-1/2 -translate-x-1/2">
          <div className="w-24 h-24 rounded-full border-4 border-white shadow-lg overflow-hidden bg-gray-200">
            <img
              src={currentUser?.imageUrl || 'https://images.unsplash.com/photo-1544717305-2782549b5136?w=400&auto=format&fit=crop&q=80'}
              alt="Avatar"
              className="w-full h-full object-cover"
            />
          </div>
        </div>
      </div>

      {/* Spacing for avatar */}
      <div className="h-16" />

      <div className="max-w-md mx-auto px-4 space-y-4">
        {/* Name & Title */}
        <div className="text-center mb-2">
          <h2 className="text-lg font-bold text-gray-900">{currentUser?.name || 'Petani Kopi'}</h2>
          <p className="text-xs text-gray-500">{currentUser?.email || 'petanikopi@unej.ac.id'}</p>
        </div>

        {/* User Info Card with Primary Gradient */}
        <div className="bg-gradient-primary text-white rounded-3xl p-6 shadow-md space-y-4">
          <div className="flex items-center space-x-3">
            <div className="w-9 h-9 rounded-full bg-white/10 flex items-center justify-center shrink-0">
              <User className="w-5 h-5 text-white" />
            </div>
            <div className="min-w-0">
              <span className="text-[10px] text-rose-200 block uppercase tracking-wider font-semibold">
                Nama Lengkap / Kelompok
              </span>
              <p className="text-sm font-bold truncate">{currentUser?.name || '-'}</p>
            </div>
          </div>

          <div className="border-t border-white/10" />

          <div className="flex items-center space-x-3">
            <div className="w-9 h-9 rounded-full bg-white/10 flex items-center justify-center shrink-0">
              <Mail className="w-5 h-5 text-white" />
            </div>
            <div className="min-w-0">
              <span className="text-[10px] text-rose-200 block uppercase tracking-wider font-semibold">
                Email
              </span>
              <p className="text-sm font-medium truncate">{currentUser?.email || '-'}</p>
            </div>
          </div>

          <div className="border-t border-white/10" />

          <div className="flex items-center space-x-3">
            <div className="w-9 h-9 rounded-full bg-white/10 flex items-center justify-center shrink-0">
              <Phone className="w-5 h-5 text-white" />
            </div>
            <div className="min-w-0">
              <span className="text-[10px] text-rose-200 block uppercase tracking-wider font-semibold">
                Nomor Telepon / WhatsApp
              </span>
              <p className="text-sm font-medium truncate">{currentUser?.phoneNumber || '-'}</p>
            </div>
          </div>

          <div className="border-t border-white/10" />

          <div className="flex items-center space-x-3">
            <div className="w-9 h-9 rounded-full bg-white/10 flex items-center justify-center shrink-0">
              <MapPin className="w-5 h-5 text-white" />
            </div>
            <div className="min-w-0">
              <span className="text-[10px] text-rose-200 block uppercase tracking-wider font-semibold">
                Alamat Kebun / Domisili
              </span>
              <p className="text-sm font-medium leading-tight">{currentUser?.address || '-'}</p>
            </div>
          </div>
        </div>

        {/* Action Buttons */}
        <div className="space-y-2 pt-2">
          <button
            onClick={() => navigate('profile/edit')}
            className="w-full py-3 px-4 bg-gradient-quaternary text-white rounded-xl font-bold text-xs shadow-sm hover:shadow-md transition-all active:scale-[0.99] flex items-center justify-center space-x-2"
          >
            <Edit3 className="w-4 h-4" />
            <span>Edit Profil</span>
          </button>

          <button
            onClick={resetDemoData}
            className="w-full py-3 px-4 bg-white border border-gray-200 text-gray-700 rounded-xl font-semibold text-xs shadow-xs hover:bg-gray-50 transition-all flex items-center justify-center space-x-2"
          >
            <RefreshCw className="w-4 h-4 text-gray-500" />
            <span>Reset Data Contoh (Demo)</span>
          </button>

          <button
            onClick={logout}
            className="w-full py-3 px-4 bg-white border border-rose-200 text-rose-600 rounded-xl font-bold text-xs shadow-xs hover:bg-rose-50 transition-all flex items-center justify-center space-x-2"
          >
            <LogOut className="w-4 h-4" />
            <span>Keluar (Log Out)</span>
          </button>
        </div>

        {/* Partner Logos */}
        <div className="mt-8 pt-6 border-t border-gray-200">
          <p className="text-[11px] text-center text-gray-400 font-semibold uppercase tracking-wider mb-4">
            Didukung Oleh & Kerjasama
          </p>
          <div className="flex flex-wrap items-center justify-center gap-3 opacity-80">
            <img src="/assets/images/kemendikbud.png" alt="Kemendikbud" className="h-8 object-contain" />
            <img src="/assets/images/kampusmerdeka.png" alt="Kampus Merdeka" className="h-8 object-contain" />
            <img src="/assets/images/simbelmawa.png" alt="Simbelmawa" className="h-8 object-contain" />
            <img src="/assets/images/ppkormawa.png" alt="PPK Ormawa" className="h-8 object-contain" />
            <img src="/assets/images/unej.png" alt="UNEJ" className="h-8 object-contain" />
            <img src="/assets/images/hmja.png" alt="HMJA" className="h-8 object-contain" />
            <img src="/assets/images/ojk.png" alt="OJK" className="h-8 object-contain" />
          </div>
          <p className="text-[10px] text-center text-gray-400 mt-4 leading-relaxed">
            SIKEPI • Sistem Keuangan Petani Kopi
            <br />
            Program Penguatan Kapasitas Organisasi Kemahasiswaan (PPK Ormawa)
            <br />
            Himpunan Mahasiswa Jurusan Akuntansi - Universitas Jember
          </p>
        </div>
      </div>
    </div>
  );
};
