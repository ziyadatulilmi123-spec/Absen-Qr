<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Daftar Operator - SMA Ziyadatul Ilmi</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 min-h-screen flex items-center justify-center p-4 font-sans">

    <div class="bg-white w-full max-w-md rounded-2xl shadow-lg p-8 border border-gray-100">
        <!-- Logo & Judul -->
        <div class="text-center mb-6">
            <div class="w-12 h-12 bg-emerald-900 text-amber-300 font-bold text-lg rounded-full flex items-center justify-center mx-auto mb-3 shadow-xs">
                Z
            </div>
            <h1 class="text-xl font-bold text-gray-900">Daftar Akun Operator</h1>
            <p class="text-xs text-gray-500 mt-1">SMA / PONPES ZIYADATUL ILMI</p>
        </div>

        <!-- Notifikasi Error Validasi / Kode Salah -->
        @if ($errors->any())
            <div class="bg-red-50 border border-red-200 text-red-700 text-xs rounded-lg p-3 mb-4">
                <ul class="list-disc list-inside space-y-0.5">
                    @foreach ($errors->all() as $error)
                        <li>{{ $error }}</li>
                    @endforeach
                </ul>
            </div>
        @endif

        <!-- Form Pendaftaran Operator -->
        <form action="{{ route('register.post') }}" method="POST" autocomplete="off" class="space-y-3.5">
            @csrf

            <div>
                <label for="name" class="block text-[11px] font-bold text-gray-600 uppercase tracking-wide mb-1">
                    Nama Lengkap Operator
                </label>
                <input
                    type="text"
                    id="name"
                    name="name"
                    value="{{ old('name') }}"
                    required
                    placeholder="Contoh: Ustadz Ahmad"
                    class="w-full px-3.5 py-2.5 text-sm border border-gray-300 rounded-lg focus:outline-none focus:border-emerald-800"
                >
            </div>

            <div>
                <label for="email" class="block text-[11px] font-bold text-gray-600 uppercase tracking-wide mb-1">
                    Email
                </label>
                <input
                    type="email"
                    id="email"
                    name="email"
                    value="{{ old('email') }}"
                    required
                    autocomplete="new-email"
                    placeholder="operator@ziyadatulilmi.sch.id"
                    class="w-full px-3.5 py-2.5 text-sm border border-gray-300 rounded-lg focus:outline-none focus:border-emerald-800"
                >
            </div>

            <div>
                <label for="password" class="block text-[11px] font-bold text-gray-600 uppercase tracking-wide mb-1">
                    Password Baru
                </label>
                <input
                    type="password"
                    id="password"
                    name="password"
                    required
                    autocomplete="new-password"
                    placeholder="Minimal 6 karakter"
                    class="w-full px-3.5 py-2.5 text-sm border border-gray-300 rounded-lg focus:outline-none focus:border-emerald-800"
                >
            </div>

            <div>
                <label for="password_confirmation" class="block text-[11px] font-bold text-gray-600 uppercase tracking-wide mb-1">
                    Ulangi Password
                </label>
                <input
                    type="password"
                    id="password_confirmation"
                    name="password_confirmation"
                    required
                    autocomplete="new-password"
                    placeholder="Ketik ulang password"
                    class="w-full px-3.5 py-2.5 text-sm border border-gray-300 rounded-lg focus:outline-none focus:border-emerald-800"
                >
            </div>

            <div>
                <label for="kode_rahasia" class="block text-[11px] font-bold text-emerald-800 uppercase tracking-wide mb-1">
                    Kode Rahasia Pondok
                </label>
                <input
                    type="password"
                    id="kode_rahasia"
                    name="kode_rahasia"
                    required
                    autocomplete="off"
                    placeholder="Masukkan kode pendaftaran dari Admin"
                    class="w-full px-3.5 py-2.5 text-sm border-2 border-emerald-200 bg-emerald-50/40 rounded-lg focus:outline-none focus:border-emerald-800"
                >
            </div>

            <button
                type="submit"
                class="w-full bg-emerald-900 hover:bg-emerald-800 text-white font-semibold text-sm py-3 rounded-lg transition shadow-xs cursor-pointer mt-2"
            >
                Buat Akun Operator
            </button>
        </form>

        <!-- Kembali ke Login -->
        <div class="text-center mt-5 pt-4 border-t border-gray-100">
            <a href="{{ url('/login') }}" class="text-xs font-medium text-gray-500 hover:text-emerald-800 transition">
                &larr; Sudah punya akun? Kembali ke Login
            </a>
        </div>
    </div>

</body>
</html>