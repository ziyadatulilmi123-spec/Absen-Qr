<?php

use App\Http\Controllers\AbsenQrController;
use App\Http\Controllers\HomeController;
use App\Http\Controllers\RaportController;
use App\Models\Absensi;
use App\Models\Siswa;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| HALAMAN PUBLIK
|--------------------------------------------------------------------------
*/
Route::get('/', [HomeController::class, 'index'])->name('home');
Route::post('/spmb/daftar', [HomeController::class, 'storePpdb'])->name('ppdb.store');
Route::get('/profil/{slug?}', [HomeController::class, 'detailProfil'])->name('profil.detail');
Route::get('/absensi', [HomeController::class, 'absensi'])->name('absensi');
Route::get('/nilai', [HomeController::class, 'nilai'])->name('nilai');

/*
|--------------------------------------------------------------------------
| AUTENTIKASI (LOGIN & REGISTER)
|--------------------------------------------------------------------------
*/
Route::get('/login', function () {
    return view('login');
})->name('login');

Route::post('/login', function (Request $request) {
    $credentials = $request->validate([
        'email'    => ['required', 'email'],
        'password' => ['required'],
    ]);

    if (Auth::attempt($credentials, $request->boolean('remember'))) {
        $request->session()->regenerate();
        return redirect()->intended(route('admin.dashboard'));
    }

    return back()->withErrors([
        'email' => 'Email atau password tidak sesuai.',
    ])->onlyInput('email');
});

Route::get('/register', function () {
    return view('register');
})->name('register');

Route::post('/register', function (Request $request) {
    $request->validate([
        'name'     => ['required', 'string', 'max:255'],
        'email'    => ['required', 'string', 'email', 'max:255', 'unique:users'],
        'password' => ['required', 'string', 'min:6', 'confirmed'],
    ]);

    $user = User::create([
        'name'     => $request->name,
        'email'    => $request->email,
        'password' => Hash::make($request->password),
    ]);

    Auth::login($user);

    return redirect()->route('admin.dashboard');
});

Route::match(['get', 'post'], '/logout', function (Request $request) {
    Auth::logout();
    $request->session()->invalidate();
    $request->session()->regenerateToken();

    return redirect()->route('login');
})->name('logout');

/*
|--------------------------------------------------------------------------
| FITUR ABSENSI QR
|--------------------------------------------------------------------------
*/
Route::get('/absen/scan', [AbsenQrController::class, 'scan'])->name('absen.scan');
Route::post('/absen/scan/proses', [AbsenQrController::class, 'prosesScan'])->name('absen.scan.proses');
Route::get('/absen/kartu', [AbsenQrController::class, 'kartu'])->name('absen.kartu');

/*
|--------------------------------------------------------------------------
| PANEL ADMIN & REKAP ABSENSI / NILAI
|--------------------------------------------------------------------------
*/
Route::get('/admin/dashboard', [HomeController::class, 'adminDashboard'])->name('admin.dashboard');

// SPMB / PPDB Admin
Route::post('/admin/ppdb/{id}/status', [HomeController::class, 'updatePpdbStatus'])->name('admin.ppdb.status');
Route::delete('/admin/ppdb/{id}', [HomeController::class, 'deletePpdb'])->name('admin.ppdb.delete');

// Input Absensi Manual (Dropdown Bertingkat) & Export/Reset
Route::post('/admin/absensi/store', [HomeController::class, 'storeAbsensi'])->name('admin.absensi.store');
Route::get('/admin/absensi/export', [HomeController::class, 'exportAbsensi'])->name('admin.absensi.export');
Route::post('/admin/absensi/reset', [HomeController::class, 'resetAbsensi'])->name('admin.absensi.reset');

// Matriks Absensi Bulanan (Input Cepat 1 Bulan Sekaligus)
Route::get('/admin/absensi/matriks', function (Request $request) {
    $siswas = Siswa::orderBy('kelas')->orderBy('nama')->get();
    $kelasDipilih = $request->get('kelas', '');
    $bulanDipilih = $request->get('bulan', date('Y-m'));

    $absensiBulanIni = [];
    if ($kelasDipilih && $bulanDipilih) {
        $siswaIds = $siswas->where('kelas', $kelasDipilih)->pluck('id');
        $records = Absensi::whereIn('siswa_id', $siswaIds)
            ->where('tanggal', 'like', $bulanDipilih . '%')
            ->get();

        foreach ($records as $rec) {
            $absensiBulanIni[$rec->siswa_id][$rec->tanggal] = $rec->status;
        }
    }

    return view('admin.absensi_matriks', compact('siswas', 'kelasDipilih', 'bulanDipilih', 'absensiBulanIni'));
})->name('admin.absensi.matriks');

Route::post('/admin/absensi/matriks/simpan', function (Request $request) {
    $request->validate([
        'kelas' => 'required|string',
        'bulan' => 'required|string',
        'data'  => 'nullable|array',
    ]);

    $kelas = $request->kelas;
    $bulan = $request->bulan;
    $dataInput = $request->input('data', []);

    $siswaIds = Siswa::where('kelas', $kelas)->pluck('id');

    Absensi::whereIn('siswa_id', $siswaIds)
        ->where('tanggal', 'like', $bulan . '%')
        ->delete();

    $insertBatch = [];
    $now = now();

    foreach ($dataInput as $siswaId => $tanggalList) {
        if (!in_array($siswaId, $siswaIds->toArray())) {
            continue;
        }

        foreach ($tanggalList as $tanggal => $status) {
            if (in_array($status, ['Hadir', 'Izin', 'Sakit', 'Alpa'])) {
                $insertBatch[] = [
                    'siswa_id'   => $siswaId,
                    'tanggal'    => $tanggal,
                    'status'     => $status,
                    'created_at' => $now,
                    'updated_at' => $now,
                ];
            }
        }
    }

    if (!empty($insertBatch)) {
        foreach (array_chunk($insertBatch, 500) as $chunk) {
            Absensi::insert($chunk);
        }
    }

    return redirect()->route('admin.absensi.matriks', ['kelas' => $kelas, 'bulan' => $bulan])
        ->with('success', "Berhasil menyimpan rekap bulan {$bulan} untuk kelas {$kelas} (" . count($insertBatch) . " catatan kehadiran).");
})->name('admin.absensi.matriks.simpan');

// Nilai & Raport Admin
Route::post('/admin/nilai/store', [HomeController::class, 'storeNilai'])->name('admin.nilai.store');
Route::get('/admin/nilai/export', [HomeController::class, 'exportNilai'])->name('admin.nilai.export');
Route::post('/admin/nilai/reset', [HomeController::class, 'resetNilai'])->name('admin.nilai.reset');

if (class_exists(RaportController::class)) {
    Route::get('/admin/raport/{siswa_id?}', [RaportController::class, 'index'])->name('admin.raport');
    Route::get('/admin/raport/{siswa_id}/cetak', [RaportController::class, 'cetak'])->name('admin.raport.cetak');
}