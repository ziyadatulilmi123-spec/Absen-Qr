<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Kartu Pelajar & QR Santri - Ziyadatul Ilmi</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/qrcodejs/1.0.0/qrcode.min.js"></script>
    <style>
        /* Ukuran standar Kartu Pelajar / ID Card (85.6mm x 54mm) */
        .kartu-pelajar {
            width: 350px;
            height: 222px;
        }
        @media print {
            @page {
                size: A4 portrait;
                margin: 10mm;
            }
            .no-print { display: none !important; }
            body {
                background: white !important;
                -webkit-print-color-adjust: exact !important;
                print-color-adjust: exact !important;
            }
            .print-grid {
                padding: 0 !important;
                gap: 14px !important;
            }
        }
    </style>
</head>
<body class="bg-gray-100 min-h-screen font-sans">

    <!-- Topbar (Tidak ikut tercetak) -->
    <div class="no-print bg-emerald-800 text-white py-4 px-6 shadow-md flex justify-between items-center">
        <div>
            <h1 class="text-lg font-bold">CETAK KARTU PELAJAR & ABSENSI QR</h1>
            <p class="text-xs text-emerald-200">Pondok Pesantren Ziyadatul Ilmi</p>
        </div>
        <div class="flex gap-2">
            <button onclick="window.print()" class="bg-amber-400 text-emerald-950 text-xs font-bold px-4 py-2 rounded-lg hover:bg-amber-300 cursor-pointer">
                Cetak / Save PDF
            </button>
            <a href="{{ route('absen.scan') }}" class="bg-emerald-700 text-white text-xs font-semibold px-3 py-2 rounded-lg hover:bg-emerald-600">
                Buka Scanner
            </a>
        </div>
    </div>

    <!-- Grid Kartu Pelajar (2 Kolom per Baris) -->
    <div class="print-grid max-w-3xl mx-auto p-6 grid grid-cols-1 md:grid-cols-2 gap-6 justify-items-center">
        @forelse($siswas as $siswa)
            <div class="kartu-pelajar bg-white border-2 border-emerald-800 rounded-xl shadow-md overflow-hidden flex flex-col justify-between break-inside-avoid relative">
                
                <!-- Header Kartu Pelajar -->
                <div class="bg-emerald-800 text-white px-4 py-2 border-b-2 border-amber-400 flex items-center justify-between">
                    <div>
                        <p class="text-[8px] tracking-widest uppercase text-amber-300 font-bold leading-none">Kartu Tanda Santri & Presensi</p>
                        <p class="text-xs font-extrabold tracking-wide mt-0.5 leading-tight">PONPES ZIYADATUL ILMI</p>
                    </div>
                    <span class="bg-emerald-950/60 text-amber-300 border border-amber-400/40 text-[8px] font-bold px-2 py-0.5 rounded uppercase">
                        Pelajar
                    </span>
                </div>

                <!-- Isi Utama Kartu: Identitas Santri (Kiri) + QR Code Besar (Kanan) -->
                <div class="flex-1 px-4 py-2 flex items-center justify-between gap-3 bg-gradient-to-br from-white via-white to-emerald-50/50">
                    
                    <!-- Detail Identitas Santri -->
                    <div class="flex-1 min-w-0 text-left">
                        <p class="text-[8px] font-bold uppercase tracking-wider text-emerald-700">Nama Lengkap</p>
                        <h3 class="font-extrabold text-gray-900 text-sm uppercase leading-snug line-clamp-2 mb-2">
                            {{ $siswa->nama }}
                        </h3>

                        <div class="space-y-1 text-[10.5px] leading-tight">
                            <div class="flex">
                                <span class="w-11 text-gray-500 font-medium flex-shrink-0">NISN</span>
                                <span class="font-bold text-gray-800 truncate">: {{ $siswa->nisn ?? '-' }}</span>
                            </div>
                            <div class="flex">
                                <span class="w-11 text-gray-500 font-medium flex-shrink-0">Kelas</span>
                                <span class="font-bold text-emerald-800 truncate">: {{ $siswa->kelas ?? '-' }}</span>
                            </div>
                            <div class="flex">
                                <span class="w-11 text-gray-500 font-medium flex-shrink-0">Status</span>
                                <span class="font-semibold text-gray-700 truncate">: Santri Aktif</span>
                            </div>
                        </div>
                    </div>

                    <!-- Kotak QR Code Besar & Kontras Tinggi (126x126 px) -->
                    <div class="flex flex-col items-center flex-shrink-0">
                        <div id="qr-{{ $siswa->id }}" class="p-1.5 bg-white border border-gray-300 rounded-lg"></div>
                        <p class="text-[8px] font-mono font-bold text-gray-700 mt-1 tracking-tight">{{ $siswa->qr_token }}</p>
                    </div>
                </div>

                <!-- Footer Kartu -->
                <div class="bg-emerald-50 border-t border-emerald-200 px-4 py-1 flex justify-between items-center text-[8px] font-semibold text-emerald-800">
                    <span>Kartu ini wajib dibawa saat kegiatan belajar</span>
                    <span class="font-mono text-emerald-900">ziyadatulilmi.my.id</span>
                </div>
            </div>

            <script>
                new QRCode(document.getElementById("qr-{{ $siswa->id }}"), {
                    text: "{{ $siswa->qr_token }}",
                    width: 126,
                    height: 126,
                    colorDark: "#000000",
                    colorLight: "#ffffff",
                    correctLevel: QRCode.CorrectLevel.M
                });
            </script>
        @empty
            <div class="col-span-2 text-center py-12 text-gray-500">
                Belum ada data siswa di database.
            </div>
        @endforelse
    </div>

</body>
</html>