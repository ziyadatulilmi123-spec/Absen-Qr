<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Matriks Rekap Absensi Cepat - Ziyadatul Ilmi</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        .sticky-col {
            position: sticky;
            left: 0;
            z-index: 10;
            background-color: #ffffff;
        }
        .sticky-col-header {
            position: sticky;
            left: 0;
            z-index: 20;
            background-color: #f3f4f6;
        }
    </style>
</head>
<body class="bg-gray-100 min-h-screen font-sans text-gray-800">

    <!-- Navbar Atas -->
    <nav class="bg-[#064e3b] text-white px-6 py-4 shadow-md flex flex-wrap justify-between items-center gap-3">
        <div>
            <h1 class="text-base font-bold tracking-wide">MATRIKS REKAP ABSENSI BULANAN (CEPAT)</h1>
            <p class="text-xs text-emerald-200">Klik kotak tanggal untuk ganti status: <b>H</b> (Hadir) &rarr; <b>I</b> (Izin) &rarr; <b>S</b> (Sakit) &rarr; <b>A</b> (Alpa) &rarr; <b>-</b> (Libur)</p>
        </div>
        <div class="flex items-center gap-2">
            <a href="{{ route('admin.absensi.export') }}" class="bg-blue-600 hover:bg-blue-500 text-white text-xs font-bold px-3.5 py-2 rounded-lg transition">
                📄 Download Excel (.XLS)
            </a>
            <a href="{{ route('admin.dashboard') }}" class="bg-amber-400 hover:bg-amber-300 text-[#064e3b] text-xs font-bold px-3.5 py-2 rounded-lg transition">
                &larr; Kembali ke Dashboard
            </a>
        </div>
    </nav>

    <div class="max-w-full mx-auto p-4 md:p-6 space-y-4">

        @if (session('success'))
            <div class="bg-emerald-100 border border-emerald-400 text-emerald-900 text-xs font-bold p-3.5 rounded-xl">
                ✅ {{ session('success') }}
            </div>
        @endif

        <!-- Filter Kelas & Bulan -->
        <div class="bg-white p-4 rounded-xl shadow-xs border border-gray-200">
            <form method="GET" action="{{ route('admin.absensi.matriks') }}" class="flex flex-wrap items-end gap-4">
                <div class="min-w-[220px]">
                    <label class="block text-xs font-bold text-gray-600 uppercase mb-1">1. Pilih Kelas</label>
                    <select name="kelas" onchange="this.form.submit()" required class="w-full px-3 py-2 text-sm border border-gray-300 rounded-lg bg-white font-semibold">
                        <option value="">-- Pilih Kelas --</option>
                        @foreach($siswas->pluck('kelas')->unique()->sort() as $k)
                            @if(!empty($k))
                                <option value="{{ $k }}" {{ $kelasDipilih === $k ? 'selected' : '' }}>{{ $k }}</option>
                            @endif
                        @endforeach
                    </select>
                </div>

                <div class="min-w-[180px]">
                    <label class="block text-xs font-bold text-gray-600 uppercase mb-1">2. Pilih Bulan</label>
                    <input type="month" name="bulan" value="{{ $bulanDipilih }}" onchange="this.form.submit()" required class="w-full px-3 py-2 text-sm border border-gray-300 rounded-lg font-semibold">
                </div>

                <button type="submit" class="bg-[#064e3b] hover:bg-emerald-800 text-white text-xs font-bold px-4 py-2.5 rounded-lg cursor-pointer">
                    Tampilkan Tabel
                </button>
            </form>
        </div>

        @if($kelasDipilih && $bulanDipilih)
            @php
                $siswaKelas = $siswas->where('kelas', $kelasDipilih)->sortBy('nama')->values();
                $jumlahHari = \Carbon\Carbon::parse($bulanDipilih . '-01')->daysInMonth;
                $sudahAdaDataBulanIni = !empty($absensiBulanIni);
            @endphp

            <!-- Tabel Matriks 1 Bulan -->
            <form action="{{ route('admin.absensi.matriks.simpan') }}" method="POST" class="bg-white p-4 rounded-xl shadow-xs border border-gray-200 space-y-4">
                @csrf
                <input type="hidden" name="kelas" value="{{ $kelasDipilih }}">
                <input type="hidden" name="bulan" value="{{ $bulanDipilih }}">

                <div class="flex flex-wrap justify-between items-center gap-2">
                    <div class="text-xs font-bold text-gray-700">
                        Kelas: <span class="text-emerald-700">{{ $kelasDipilih }}</span> |
                        Bulan: <span class="text-emerald-700">{{ \Carbon\Carbon::parse($bulanDipilih . '-01')->translatedFormat('F Y') }}</span>
                        ({{ $siswaKelas->count() }} Santri)
                    </div>
                    <div class="flex flex-wrap gap-2">
                        <button type="button" onclick="isiSemuaHadir()" class="bg-emerald-100 hover:bg-emerald-200 text-emerald-900 text-xs font-bold px-3 py-1.5 rounded-lg cursor-pointer">
                            Set Semua Hari Aktif = Hadir (H)
                        </button>
                        <button type="button" onclick="kosongkanSemua()" class="bg-gray-100 hover:bg-gray-200 text-gray-700 text-xs font-semibold px-3 py-1.5 rounded-lg cursor-pointer">
                            Kosongkan Semua (-)
                        </button>
                    </div>
                </div>

                <div class="overflow-x-auto border border-gray-200 rounded-lg">
                    <table class="w-full text-left border-collapse text-xs">
                        <thead>
                            <tr class="bg-gray-100 border-b border-gray-300 text-gray-700">
                                <th class="py-2 px-2 border-r border-gray-200 text-center w-8">No</th>
                                <th class="py-2 px-3 border-r border-gray-300 min-w-[200px] sticky-col-header">Nama Santri</th>
                                @for($tgl = 1; $tgl <= $jumlahHari; $tgl++)
                                    @php
                                        $dateStr = $bulanDipilih . '-' . str_pad($tgl, 2, '0', STR_PAD_LEFT);
                                        $carbonDate = \Carbon\Carbon::parse($dateStr);
                                        $isMinggu = $carbonDate->isSunday();
                                    @endphp
                                    <th class="py-1.5 px-1 border-r border-gray-200 text-center min-w-[32px] {{ $isMinggu ? 'bg-red-100 text-red-700' : '' }}" title="Klik untuk liburkan seluruh kelas di tanggal {{ $tgl }}">
                                        <button type="button" onclick="toggleKolomTanggal('{{ $dateStr }}')" class="w-full font-bold cursor-pointer hover:underline">
                                            {{ $tgl }}
                                        </button>
                                    </th>
                                @endfor
                            </tr>
                        </thead>
                        <tbody class="divide-y divide-gray-200">
                            @foreach($siswaKelas as $idx => $s)
                                <tr class="hover:bg-gray-50">
                                    <td class="py-1.5 px-2 border-r border-gray-200 text-center text-gray-500">{{ $idx + 1 }}</td>
                                    <td class="py-1.5 px-3 border-r border-gray-300 font-bold text-gray-900 sticky-col whitespace-nowrap">
                                        {{ $s->nama }}
                                    </td>
                                    @for($tgl = 1; $tgl <= $jumlahHari; $tgl++)
                                        @php
                                            $dateStr = $bulanDipilih . '-' . str_pad($tgl, 2, '0', STR_PAD_LEFT);
                                            $carbonDate = \Carbon\Carbon::parse($dateStr);
                                            $isMinggu = $carbonDate->isSunday();

                                            if ($sudahAdaDataBulanIni) {
                                                $val = $absensiBulanIni[$s->id][$dateStr] ?? '';
                                            } else {
                                                $val = $isMinggu ? '' : 'Hadir';
                                            }
                                        @endphp
                                        <td class="p-0.5 border-r border-gray-200 text-center {{ $isMinggu ? 'bg-red-50' : '' }}">
                                            <input type="hidden" name="data[{{ $s->id }}][{{ $dateStr }}]" value="{{ $val }}" data-tgl="{{ $dateStr }}" data-minggu="{{ $isMinggu ? '1' : '0' }}" class="input-status">
                                            <button type="button" onclick="ubahStatus(this)" class="btn-status w-7 h-7 rounded font-extrabold text-[11px] cursor-pointer transition"></button>
                                        </td>
                                    @endfor
                                </tr>
                            @endforeach
                        </tbody>
                    </table>
                </div>

                <div class="flex flex-wrap justify-between items-center gap-3 pt-2">
                    <p class="text-[11px] text-gray-500">
                        *Tips: Klik <b>angka tanggal di baris paling atas</b> (misal tgl 17) untuk meliburkan / mengaktifkan satu kolom tanggal sekaligus.
                    </p>
                    <button type="submit" class="bg-[#064e3b] hover:bg-emerald-800 text-white font-bold text-sm px-6 py-3 rounded-xl cursor-pointer shadow-xs">
                        Simpan Absensi Bulan Ini
                    </button>
                </div>
            </form>
        @else
            <div class="bg-white p-10 rounded-xl border border-gray-200 text-center text-sm text-gray-400">
                Silakan pilih <b>Kelas</b> dan <b>Bulan</b> di atas untuk memunculkan matriks absensi.
            </div>
        @endif

    </div>

    <script>
        const urutanStatus = ['Hadir', 'Izin', 'Sakit', 'Alpa', ''];

        function renderTampilanTombol(btn, val) {
            btn.className = 'btn-status w-7 h-7 rounded font-extrabold text-[11px] cursor-pointer transition ';
            if (val === 'Hadir') {
                btn.textContent = 'H';
                btn.className += 'bg-emerald-100 text-emerald-800 hover:bg-emerald-200';
            } else if (val === 'Izin') {
                btn.textContent = 'I';
                btn.className += 'bg-blue-500 text-white hover:bg-blue-600';
            } else if (val === 'Sakit') {
                btn.textContent = 'S';
                btn.className += 'bg-amber-400 text-gray-900 hover:bg-amber-500';
            } else if (val === 'Alpa') {
                btn.textContent = 'A';
                btn.className += 'bg-red-600 text-white hover:bg-red-700';
            } else {
                btn.textContent = '-';
                btn.className += 'bg-gray-100 text-gray-400 hover:bg-gray-200';
            }
        }

        document.querySelectorAll('.btn-status').forEach(btn => {
            const input = btn.previousElementSibling;
            renderTampilanTombol(btn, input.value);
        });

        function ubahStatus(btn) {
            const input = btn.previousElementSibling;
            const idxSekarang = urutanStatus.indexOf(input.value);
            const nextVal = urutanStatus[(idxSekarang + 1) % urutanStatus.length];
            input.value = nextVal;
            renderTampilanTombol(btn, nextVal);
        }

        function toggleKolomTanggal(tgl) {
            const inputs = document.querySelectorAll(`.input-status[data-tgl="${tgl}"]`);
            if (inputs.length === 0) return;

            const adaYangTerisi = Array.from(inputs).some(inp => inp.value !== '');
            const targetVal = adaYangTerisi ? '' : 'Hadir';

            inputs.forEach(inp => {
                inp.value = targetVal;
                renderTampilanTombol(inp.nextElementSibling, targetVal);
            });
        }

        function isiSemuaHadir() {
            document.querySelectorAll('.input-status').forEach(inp => {
                if (inp.dataset.minggu === '0') {
                    inp.value = 'Hadir';
                    renderTampilanTombol(inp.nextElementSibling, 'Hadir');
                }
            });
        }

        function kosongkanSemua() {
            document.querySelectorAll('.input-status').forEach(inp => {
                inp.value = '';
                renderTampilanTombol(inp.nextElementSibling, '');
            });
        }
    </script>

</body>
</html>