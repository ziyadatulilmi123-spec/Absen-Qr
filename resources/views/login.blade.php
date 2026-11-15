<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login Operator - SMA Ziyadatul Ilmi</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 min-h-screen flex items-center justify-center p-4 font-sans">

    <div class="bg-white w-full max-w-md rounded-2xl shadow-lg p-8 border border-gray-100">
        <!-- Logo & Judul -->
        <div class="text-center mb-7">
            <div class="w-12 h-12 bg-emerald-900 text-amber-300 font-bold text-lg rounded-full flex items-center justify-center mx-auto mb-3 shadow-xs">
                Z
            </div>
            <h1 class="text-xl font-bold text-gray-900">Login Portal Sekolah</h1>
            <p class="text-xs text-gray-500 mt-1">SMA / PONPES ZIYADATUL ILMI</p>
        </div>

        <!-- Notifikasi Sukses Daftar -->
        @if (session('success'))
            <div class="bg-emerald-50 border border-emerald-200 text-emerald-800 text-xs font-medium rounded-lg p-3 mb-4">
                {{ session('success') }}
            </div>
        @endif

        <!-- Notifikasi Error Login -->
        @if ($errors->any())
            <div class="bg-red-50 border border-red-200 text-red-700 text-xs rounded-lg p-3 mb-4">
                <ul class="list-disc list-inside space-y-0.5">
                    @foreach ($errors->all() as $error)
                        <li>{{ $error }}</li>
                    @endforeach
                </ul>
            </div>
        @endif

        <!-- Form Login (Tanpa value bawaan & autocomplete dimatikan) -->
        <form action="{{ url('/login') }}" method="POST" autocomplete="off" class="space-y-4">
            @csrf

            <div>
                <label for="email" class="block text-[11px] font-bold text-gray-600 uppercase tracking-wide mb-1.5">
                    Email / Username
                </label>
                <input
                    type="email"
                    id="email"
                    name="email"
                    required
                    autocomplete="new-email"
                    placeholder="Masukkan email operator"
                    class="w-full px-3.5 py-2.5 text-sm text-gray-800 border border-gray-300 rounded-lg focus:outline-none focus:border-emerald-800 focus:ring-1 focus:ring-emerald-800"
                >
            </div>

            <div>
                <label for="password" class="block text-[11px] font-bold text-gray-600 uppercase tracking-wide mb-1.5">
                    Password
                </label>
                <input
                    type="password"
                    id="password"
                    name="password"
                    required
                    autocomplete="new-password"
                    placeholder="Masukkan password"
                    class="w-full px-3.5 py-2.5 text-sm text-gray-800 border border-gray-300 rounded-lg focus:outline-none focus:border-emerald-800 focus:ring-1 focus:ring-emerald-800"
                >
            </div>

            <button
                type="submit"
                class="w-full bg-emerald-900 hover:bg-emerald-800 text-white font-semibold text-sm py-3 rounded-lg transition shadow-xs cursor-pointer mt-2"
            >
                Masuk ke Dashboard
            </button>
        </form>

        <!-- Navigasi Bawah -->
        <div class="mt-6 pt-4 border-t border-gray-100 flex items-center justify-between text-xs">
            <a href="{{ url('/') }}" class="text-gray-500 hover:text-emerald-800 transition">
                &larr; Kembali ke Beranda
            </a>
            <a href="{{ route('register') }}" class="font-semibold text-emerald-800 hover:text-emerald-950 transition">
                Daftar Operator Baru
            </a>
        </div>
    </div>

</body>
</html>