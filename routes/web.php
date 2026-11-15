<?php

use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Route;

// Import Controller yang ada di proyekmu (sesuaikan nama controller jika berbeda)
use App\Http\Controllers\AbsensiController;
use App\Http\Controllers\SiswaController;
use App\Http\Controllers\DashboardController;

/*
|--------------------------------------------------------------------------
| Halaman Publik & Beranda
|--------------------------------------------------------------------------
*/
Route::get('/', function () {
    return view('welcome');
})->name('home');

/*
|--------------------------------------------------------------------------
| Autentikasi Operator (Login, Register Rahasia, Logout)
|--------------------------------------------------------------------------
*/
Route::middleware('guest')->group(function () {
    // Halaman Login
    Route::get('/login', function () {
        return view('login');
    })->name('login');

    // Proses Login
    Route::post('/login', function (Request $request) {
        $credentials = $request->validate([
            'email' => 'required|email',
            'password' => 'required',
        ]);

        if (Auth::attempt($credentials)) {
            $request->session()->regenerate();
            return redirect()->intended('/admin/dashboard');
        }

        return back()->withErrors([
            'email' => 'Email atau password yang Anda masukkan salah.',
        ])->onlyInput('email');
    })->name('login.post');

    // Halaman Daftar Operator Khusus (Memerlukan Kode Rahasia)
    Route::get('/register', function () {
        return view('register');
    })->name('register');

    // Proses Pendaftaran Operator Baru
    Route::post('/register', function (Request $request) {
        $request->validate([
            'name' => 'required|string|max:255',
            'email' => 'required|email|unique:users,email',
            'password' => 'required|min:6|confirmed',
            'kode_rahasia' => 'required',
        ], [
            'email.unique' => 'Email ini sudah terdaftar sebagai operator.',
            'password.min' => 'Password minimal harus 6 karakter.',
            'password.confirmed' => 'Konfirmasi password tidak cocok.',
        ]);

        $kodeValid = env('KODE_DAFTAR_ADMIN', 'ZIYADATUL2026');

        if ($request->kode_rahasia !== $kodeValid) {
            return back()
                ->withErrors(['kode_rahasia' => 'Kode Rahasia Pondok salah! Hanya pengurus berwenang yang dapat mendaftar.'])
                ->withInput($request->except(['password', 'password_confirmation', 'kode_rahasia']));
        }

        User::create([
            'name' => $request->name,
            'email' => $request->email,
            'password' => Hash::make($request->password),
        ]);

        return redirect()->route('login')->with('success', 'Akun operator berhasil didaftarkan! Silakan login.');
    })->name('register.post');
});

// Proses Logout
Route::post('/logout', function (Request $request) {
    Auth::logout();
    $request->session()->invalidate();
    $request->session()->regenerateToken();
    return redirect()->route('login');
})->middleware('auth')->name('logout');

/*
|--------------------------------------------------------------------------
| Area Admin & Operator (Wajib Login)
|--------------------------------------------------------------------------
*/
Route::middleware('auth')->prefix('admin')->group(function () {
    // Dashboard Utama
    Route::get('/dashboard', [DashboardController::class, 'index'])->name('admin.dashboard');

    // Fitur Absensi QR & Cetak Kartu Pelajar
    Route::get('/absensi', [AbsensiController::class, 'index'])->name('absen.index');
    Route::get('/absensi/scan', [AbsensiController::class, 'scan'])->name('absen.scan');
    Route::post('/absensi/store', [AbsensiController::class, 'store'])->name('absen.store');
    Route::get('/absensi/kartu', [AbsensiController::class, 'kartu'])->name('absen.kartu');

    // Manajemen Data Santri / Siswa
    Route::resource('siswa', SiswaController::class);
});