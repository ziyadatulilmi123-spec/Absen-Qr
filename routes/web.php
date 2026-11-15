<?php

use App\Http\Controllers\AbsensiQrController;
use App\Http\Controllers\HomeController;
use App\Http\Controllers\NilaiController;
use App\Http\Controllers\RaportController;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| Halaman Publik & Beranda
|--------------------------------------------------------------------------
*/

// 1. Halaman Utama / Beranda & PPDB
Route::get('/', [HomeController::class, 'index'])->name('home');
Route::post('/ppdb', [HomeController::class, 'storePpdb'])->name('ppdb.store');

// 2. Detail Profil Yayasan
Route::get('/profil/{slug}', [HomeController::class, 'detailProfil'])->name('profil.detail');

// 3. Cek Absensi, Nilai & E-Raport Publik
Route::get('/absensi', [HomeController::class, 'absensi'])->name('absensi');
Route::get('/nilai', [HomeController::class, 'nilai'])->name('nilai');
Route::get('/raport/{siswa_id}', [RaportController::class, 'show'])->name('raport.show');

/*
|--------------------------------------------------------------------------
| Autentikasi Operator (Login, Register Rahasia, Logout)
|--------------------------------------------------------------------------
*/

Route::middleware('guest')->group(function () {
    // Halaman & Proses Login
    Route::get('/login', function () {
        return view('login');
    })->name('login');

    Route::post('/login', function (Request $request) {
        $credentials = $request->validate([
            'email' => 'required|email',
            'password' => 'required',
        ]);

        if (Auth::attempt($credentials)) {
            $request->session()->regenerate();
            return redirect()->intended(route('admin.dashboard'));
        }

        return back()->withErrors([
            'email' => 'Email atau password yang Anda masukkan salah.',
        ])->onlyInput('email');
    })->name('login.post');

    // Halaman & Proses Register Operator Khusus (Kode Rahasia)
    Route::get('/register', function () {
        return view('register');
    })->name('register');

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
                ->withErrors(['kode_rahasia' => 'Kode Rahasia Pondok salah!'])
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

// Logout (Mendukung tombol POST maupun link GET)
Route::match(['get', 'post'], '/logout', function (Request $request) {
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

Route::middleware('auth')->group(function () {
    // 4. Dashboard Admin
    Route::get('/admin/dashboard', [HomeController::class, 'adminDashboard'])->name('admin.dashboard');

    // 5. Fitur Absensi QR Code (Scan & Cetak Kartu Pelajar)
    Route::get('/admin/absensi/scan', [AbsensiQrController::class, 'scan'])->name('absen.scan');
    Route::post('/admin/absensi/scan', [AbsensiQrController::class, 'storeScan'])->name('absen.scan.store');
    Route::get('/admin/absensi/kartu', [AbsensiQrController::class, 'kartu'])->name('absen.kartu');

    // 6. Aksi SPMB / PPDB Admin
    Route::post('/admin/ppdb/status/{id}', [HomeController::class, 'updatePpdbStatus'])->name('admin.ppdb.updateStatus');
    Route::delete('/admin/ppdb/delete/{id}', [HomeController::class, 'deletePpdb'])->name('admin.ppdb.delete');

    // 7. Input Presensi, Nilai Batch & Reset Admin
    Route::post('/admin/absensi/store', [HomeController::class, 'storeAbsensi'])->name('admin.absensi.store');
    Route::post('/admin/nilai/store', [HomeController::class, 'storeNilai'])->name('admin.nilai.store');
    Route::post('/nilai/store', [NilaiController::class, 'store'])->name('nilai.store');
    Route::post('/nilai/batch', [NilaiController::class, 'storeBatch'])->name('nilai.storeBatch');
    Route::any('/admin/absensi/reset', [HomeController::class, 'resetAbsensi'])->name('admin.absensi.reset');
    Route::any('/admin/nilai/reset', [HomeController::class, 'resetNilai'])->name('admin.nilai.reset');

    // 8. Export Rekap Excel / XLS
    Route::get('/admin/absensi/export', [HomeController::class, 'exportAbsensi'])->name('absensi.export');
    Route::get('/admin/absensi/export-alias', [HomeController::class, 'exportAbsensi'])->name('admin.absensi.export');
    Route::get('/admin/nilai/export', [HomeController::class, 'exportNilai'])->name('admin.nilai.export');
});