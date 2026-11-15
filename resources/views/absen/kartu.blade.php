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
            width: 340px;
            height: 215px;
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

    <!-- Grid Kartu Pelajar (2 Kolom per Baris agar Muat Rapi di Kertas A4) -->
    <div class="print-grid max-w-3xl mx-auto p-6 grid grid-cols-1 md:grid-cols-2 gap-6 justify-items-center">
        @forelse($siswas as $siswa)
            <div class="kartu-pelajar bg-white border-2 border-emerald-800 rounded-xl shadow-md overflow-hidden flex flex-col justify-between break-inside-avoid relative">
                
                <!-- Header Kartu Pelajar -->
                <div class="bg-emerald-800 text-white px-3.5 py-2 border-b-2 border-amber-400 flex items-center justify-between">
                    <div>
                        <p class="text-[8px] tracking-widest uppercase text-amber-300 font-bold leading-none">Kartu Tanda Santri & Presensi</p>
                        <p class="text-xs font-extrabold tracking-wide mt-0.5 leading-tight">PONPES ZIYADATUL ILMI</p>
                    </div>
                    <span class="bg-emerald-950/60 text-amber-300 border border-amber-400/40 text-[8px] font-bold px-2 py-0.5 rounded uppercase">
                        Pelajar
                    </span>
                </div>

                <!-- Isi Utama Kartu: Foto (Kiri) + Identitas (Tengah) + QR Code (Kanan) -->
                <div class="flex-1 px-3 py-2.5 flex items-center justify-between gap-2.5 bg-gradient-to-br from-white via-white to-emerald-50/60">
                    
                    <!-- Kotak Pas Foto 3x4 -->
                    <div class="w-[62px] h-[82px] border border-emerald-700 rounded-md bg-gray-50 flex-shrink-0 overflow-hidden flex items-center justify-center shadow-inner">
                        @if(!empty($siswa->foto))
                            <img src="{{ asset('storage/' . $siswa->foto) }}" alt="Foto {{ $siswa->nama }}" class="w-full h-full object-cover">
                        @else
                            <div class="text-center px-1">
                                <svg class="w-6 h-6 text-emerald-700/40 mx-auto" fill="currentColor" viewBox="0 0 24 24">
                                    <path d="M12 12c2.7 0 4.8-2.1 4.8-4.8S14.7 2.4 12 2.4 7.2 4.5 7.2 7.2 9.3 12 12 12zm0 2.4c-3.2 0-9.6 1.6-9.6 4.8v2.4h19.2v-2.4c0-3.2-6.4-4.8-9.6-4.8z"/>
                                </svg>
                                <span class="block text-[7px] font-semibold text-gray-400 leading-tight mt-0.5">FOTO<br>3x4</span>
                            </div>
                        @endif
                    </div>

                    <!-- Detail Identitas Santri -->
                    <div class="flex-1 min-w-0 text-left">
                        <p class="text-[8px] font-bold uppercase tracking-wider text-emerald-700">Nama Lengkap</p>
                        <h3 class="font-extrabold text-gray-900 text-xs uppercase leading-snug line-clamp-2 mb-1.5">
                            {{ $siswa->nama }}
                        </h3>

                        <div class="space-y-0.5 text-[10px] leading-tight">
                            <div class="flex">
                                <span class="w-10 text-gray-500 font-medium">NISN</span>
                                <span class="font-bold text-gray-800">: {{ $siswa->nisn ?? '-' }}</span>
                            </div>
                            <div class="flex">
                                <span class="w-10 text-gray-500 font-medium">Kelas</span>
                                <span class="font-bold text-emerald-800 truncate">: {{ $siswa->kelas ?? '-' }}</span>
                            </div>
                            <div class="flex">
                                <span class="w-10 text-gray-500 font-medium">Status</span>
                                <span class="font-semibold text-gray-700">: Santri Aktif</span>
                            </div>
                        </div>
                    </div>

                    <!-- Kotak QR Code -->
                    <div class="flex flex-col items-center flex-shrink-0">
                        <div id="qr-{{ $siswa->id }}" class="p-1 bg-white border border-emerald-200 rounded-lg shadow-xs"></div>
                        <p class="text-[7px] font-mono font-bold text-gray-500 mt-1 tracking-tight">{{ $siswa->qr_token }}</p>
                    </div>
                </div>

                <!-- Footer Kartu -->
                <div class="bg-emerald-50 border-t border-emerald-200 px-3.5 py-1 flex justify-between items-center text-[8px] font-semibold text-emerald-800">
                    <span>Kartu ini wajib dibawa saat kegiatan belajar</span>
                    <span class="font-mono text-emerald-900">ziyadatulilmi.my.id</span>
                </div>
            </div>

            <script>
                new QRCode(document.getElementById("qr-{{ $siswa->id }}"), {
                    text: "{{ $siswa->qr_token }}",
                    width: 68,
                    height: 68,
                    colorDark: "#064e3b",
                    colorLight: "#ffffff",
                    correctLevel: QRCode.CorrectLevel.H
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