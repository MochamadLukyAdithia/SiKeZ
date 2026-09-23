import React, { useState } from 'react';
import { ArrowLeft, Camera, Check } from 'lucide-react';
import { useApp } from '../context/AppContext';

export const ProfileEditPage: React.FC = () => {
  const { currentUser, updateProfile, navigate } = useApp();

  const [name, setName] = useState(currentUser?.name || '');
  const [phone, setPhone] = useState(currentUser?.phoneNumber || '');
  const [address, setAddress] = useState(currentUser?.address || '');
  const [imageUrl, setImageUrl] = useState(currentUser?.imageUrl || '');

  const handleImageChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const file = e.target.files?.[0];
    if (file) {
      const reader = new FileReader();
      reader.onloadend = () => {
        setImageUrl(reader.result as string);
      };
      reader.readAsDataURL(file);
    }
  };

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    updateProfile({
      name,
      phoneNumber: phone,
      address,
      imageUrl,
    });
    navigate('profile');
  };

  return (
    <div className="min-h-screen bg-[#F4F7F0] pb-24">
      {/* Header */}
      <div className="sticky top-0 z-30 bg-gradient-primary text-white shadow-md">
        <div className="flex items-center justify-between px-4 h-14">
          <div className="flex items-center space-x-3">
            <button
              onClick={() => navigate('profile')}
              className="p-1.5 -ml-1 text-white hover:bg-white/10 rounded-full transition-colors active:scale-95"
            >
              <ArrowLeft className="w-5 h-5" />
            </button>
            <h1 className="text-lg font-semibold tracking-wide">Edit Profile</h1>
          </div>
        </div>
      </div>

      <div className="max-w-md mx-auto p-4">
        <form onSubmit={handleSubmit} className="space-y-4">
          {/* Avatar edit section */}
          <div className="bg-white p-6 rounded-2xl shadow-xs border border-gray-100 flex flex-col items-center">
            <div className="relative mb-3">
              <div className="w-24 h-24 rounded-full overflow-hidden border-2 border-[#A1B57D] shadow-sm bg-gray-100">
                <img
                  src={
                    imageUrl ||
                    'https://images.unsplash.com/photo-1544717305-2782549b5136?w=400&auto=format&fit=crop&q=80'
                  }
                  alt="Avatar"
                  className="w-full h-full object-cover"
                />
              </div>
              <label className="absolute bottom-0 right-0 p-2 bg-[#B33030] text-white rounded-full shadow-md cursor-pointer hover:bg-[#8e2424] transition-colors">
                <Camera className="w-4 h-4" />
                <input
                  type="file"
                  accept="image/*"
                  onChange={handleImageChange}
                  className="hidden"
                />
              </label>
            </div>
            <span className="text-xs text-gray-500 font-medium">Ketuk kamera untuk ubah foto</span>
          </div>

          {/* Form Fields */}
          <div className="bg-white p-4 rounded-2xl shadow-xs border border-gray-100 space-y-3">
            <div>
              <label className="text-xs font-bold text-gray-700 uppercase tracking-wider block mb-1">
                Nama Lengkap / Nama Kelompok Tani*
              </label>
              <input
                type="text"
                value={name}
                onChange={(e) => setName(e.target.value)}
                placeholder="Masukkan nama anda..."
                className="w-full bg-gray-50 border border-gray-300 rounded-lg p-2.5 text-xs text-gray-900 font-medium outline-none focus:ring-2 focus:ring-[#A1B57D]"
                required
              />
            </div>

            <div>
              <label className="text-xs font-bold text-gray-700 uppercase tracking-wider block mb-1">
                Email Terdaftar
              </label>
              <input
                type="email"
                value={currentUser?.email || ''}
                disabled
                className="w-full bg-gray-100 border border-gray-200 rounded-lg p-2.5 text-xs text-gray-500 font-medium cursor-not-allowed"
              />
              <span className="text-[10px] text-gray-400 mt-0.5 block">Email tidak dapat diubah</span>
            </div>

            <div>
              <label className="text-xs font-bold text-gray-700 uppercase tracking-wider block mb-1">
                Nomor WhatsApp / HP*
              </label>
              <input
                type="tel"
                value={phone}
                onChange={(e) => setPhone(e.target.value)}
                placeholder="Contoh: 081234567890"
                className="w-full bg-gray-50 border border-gray-300 rounded-lg p-2.5 text-xs text-gray-900 font-medium outline-none focus:ring-2 focus:ring-[#A1B57D]"
                required
              />
            </div>

            <div>
              <label className="text-xs font-bold text-gray-700 uppercase tracking-wider block mb-1">
                Alamat Kebun / Domisili*
              </label>
              <textarea
                value={address}
                onChange={(e) => setAddress(e.target.value)}
                placeholder="Masukkan alamat lengkap kebun kopi anda..."
                rows={2}
                className="w-full bg-gray-50 border border-gray-300 rounded-lg p-2.5 text-xs text-gray-900 font-medium outline-none focus:ring-2 focus:ring-[#A1B57D]"
                required
              />
            </div>
          </div>

          {/* Submit */}
          <div className="pt-2">
            <button
              type="submit"
              className="w-full py-3.5 px-4 bg-gradient-quaternary text-white rounded-xl font-bold text-sm shadow-md hover:shadow-lg transition-transform active:scale-[0.98] flex items-center justify-center space-x-2"
            >
              <Check className="w-4 h-4" />
              <span>Simpan Perubahan</span>
            </button>
          </div>
        </form>
      </div>
    </div>
  );
};
