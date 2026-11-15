-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 13, 2026 at 01:49 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `ziyadatulilmi`
--

-- --------------------------------------------------------

--
-- Table structure for table `absensis`
--

CREATE TABLE `absensis` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `siswa_id` bigint(20) UNSIGNED NOT NULL,
  `tanggal` date NOT NULL,
  `jam_masuk` time DEFAULT NULL,
  `status` enum('Hadir','Izin','Sakit','Alpa') NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `absensis`
--

INSERT INTO `absensis` (`id`, `siswa_id`, `tanggal`, `jam_masuk`, `status`, `created_at`, `updated_at`) VALUES
(1, 3, '2026-11-13', '06:42:53', 'Hadir', '2026-11-12 23:42:53', '2026-11-12 23:42:53');

-- --------------------------------------------------------

--
-- Table structure for table `cache`
--

CREATE TABLE `cache` (
  `key` varchar(255) NOT NULL,
  `value` mediumtext NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cache_locks`
--

CREATE TABLE `cache_locks` (
  `key` varchar(255) NOT NULL,
  `owner` varchar(255) NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `jobs`
--

CREATE TABLE `jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `queue` varchar(255) NOT NULL,
  `payload` longtext NOT NULL,
  `attempts` tinyint(3) UNSIGNED NOT NULL,
  `reserved_at` int(10) UNSIGNED DEFAULT NULL,
  `available_at` int(10) UNSIGNED NOT NULL,
  `created_at` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `job_batches`
--

CREATE TABLE `job_batches` (
  `id` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `total_jobs` int(11) NOT NULL,
  `pending_jobs` int(11) NOT NULL,
  `failed_jobs` int(11) NOT NULL,
  `failed_job_ids` longtext NOT NULL,
  `options` mediumtext DEFAULT NULL,
  `cancelled_at` int(11) DEFAULT NULL,
  `created_at` int(11) NOT NULL,
  `finished_at` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '0001_01_01_000000_create_users_table', 1),
(2, '0001_01_01_000001_create_cache_table', 1),
(3, '0001_01_01_000002_create_jobs_table', 1),
(4, '2026_10_07_113255_create_ppdbs_table', 1),
(5, '2026_10_07_113458_create_profils_table', 1),
(6, '2026_10_07_113504_create_pengumumen_table', 1),
(7, '2026_10_07_120335_create_siswas_table', 1),
(8, '2026_10_07_120342_create_absensis_table', 1),
(9, '2026_10_07_120349_create_nilais_table', 1),
(10, '2026_11_12_064500_add_qr_features_to_siswas_and_absensis', 2);

-- --------------------------------------------------------

--
-- Table structure for table `nilais`
--

CREATE TABLE `nilais` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `siswa_id` bigint(20) UNSIGNED NOT NULL,
  `mata_pelajaran` varchar(255) NOT NULL,
  `jenis_ujian` varchar(255) NOT NULL,
  `nilai` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `nilais`
--

INSERT INTO `nilais` (`id`, `siswa_id`, `mata_pelajaran`, `jenis_ujian`, `nilai`, `created_at`, `updated_at`) VALUES
(1, 4, 'Matematika', 'UTS', 75, '2026-10-07 07:02:49', '2026-10-07 07:02:49'),
(2, 4, 'Matematika', 'UAS', 78, '2026-10-07 07:03:13', '2026-10-07 07:03:13'),
(3, 4, 'Matematika', 'Tugas', 60, '2026-10-07 07:16:26', '2026-10-07 07:16:26'),
(4, 3, 'Matematika', 'Tugas', 75, '2026-10-07 07:16:36', '2026-10-07 07:16:36'),
(5, 16, 'Matematika', 'Tugas', 75, '2026-10-07 07:17:04', '2026-10-07 07:17:04'),
(6, 35, 'Matematika', 'UTS', 0, '2026-10-07 07:32:27', '2026-10-07 07:32:27'),
(7, 11, 'Informatika', 'Tugas', 33, '2026-10-07 09:25:53', '2026-10-07 09:25:53');

-- --------------------------------------------------------

--
-- Table structure for table `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `pengumumans`
--

CREATE TABLE `pengumumans` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `judul` varchar(255) NOT NULL,
  `kategori` varchar(255) NOT NULL,
  `isi` text NOT NULL,
  `tanggal` date NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `pengumumans`
--

INSERT INTO `pengumumans` (`id`, `judul`, `kategori`, `isi`, `tanggal`, `created_at`, `updated_at`) VALUES
(1, 'Pembukaan Penerimaan Santri/Siswa Baru (SPMB) 2026/2027', 'SPMB', 'Pendaftaran santri/siswa baru SMA Ziyadatul Ilmi resmi dibuka untuk gelombang pertama. Silakan mengisi formulir pendaftaran online.', '2026-10-07', '2026-10-07 06:50:24', '2026-10-07 06:50:24'),
(2, 'Kegiatan Kajian Kitab Kuning & Pelatihan Tahfidz', 'Kegiatan', 'Rangkaian ujian tahfidz hafalan Juz 30 dan kajian rutin mingguan akan dilaksanakan di komplek madrasah.', '2026-10-01', '2026-10-07 06:50:24', '2026-10-07 06:50:24');

-- --------------------------------------------------------

--
-- Table structure for table `ppdbs`
--

CREATE TABLE `ppdbs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `nama_lengkap` varchar(255) NOT NULL,
  `nisn` varchar(255) DEFAULT NULL,
  `jenis_kelamin` enum('Laki-laki','Perempuan') NOT NULL,
  `no_wa` varchar(255) NOT NULL,
  `status` varchar(255) NOT NULL DEFAULT 'Menunggu',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `ppdbs`
--

INSERT INTO `ppdbs` (`id`, `nama_lengkap`, `nisn`, `jenis_kelamin`, `no_wa`, `status`, `created_at`, `updated_at`) VALUES
(1, 'MUSYAFAK', '2222222', 'Laki-laki', '086736332233', 'Menunggu', '2026-10-07 07:18:18', '2026-10-07 07:18:18'),
(2, 'Eha Soleha', '3333333', 'Perempuan', '086547773322', 'Menunggu', '2026-10-07 09:24:31', '2026-10-07 09:24:31');

-- --------------------------------------------------------

--
-- Table structure for table `profils`
--

CREATE TABLE `profils` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `nama_yayasan` varchar(255) NOT NULL,
  `pimpinan` varchar(255) NOT NULL,
  `nsp` varchar(255) DEFAULT NULL,
  `alamat` text NOT NULL,
  `no_wa` varchar(255) NOT NULL,
  `visi` text NOT NULL,
  `misi` text NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `profils`
--

INSERT INTO `profils` (`id`, `nama_yayasan`, `pimpinan`, `nsp`, `alamat`, `no_wa`, `visi`, `misi`, `created_at`, `updated_at`) VALUES
(1, 'SMA ZIYADATUL ILMI', 'KH. Zainuri Yasmin, S.Ag. M.Pd.', '510036730333', 'Link. Nancang Wetan RT.004 RW.004, Kel. Karundang, Kec. Cipocok Jaya, Kota Serang, Banten', '081389554994', 'Menjadi lembaga pendidikan Islam unggulan yang melahirkan generasi beriman, bertakwa, berprestasi, dan berwawasan global.', '1. Menyelenggarakan pendidikan berbasis Al-Qur\'an dan Sunnah. 2. Mengembangkan potensi akademik dan non-akademik siswa. 3. Membina karakter kepemimpinan dan kemandirian.', '2026-10-07 06:50:24', '2026-10-07 06:50:24');

-- --------------------------------------------------------

--
-- Table structure for table `sessions`
--

CREATE TABLE `sessions` (
  `id` varchar(255) NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `payload` longtext NOT NULL,
  `last_activity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sessions`
--

INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES
('5H6g4A79MVnNMzSleL2YAbzw0zaRMauNm8PmHaSC', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/157.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiUk5QcG9mb1B2Y2xnVVFPTmFxUndVaDRlckxBeXBDTWxOUkVxN1NHZCI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6NDA6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9hZG1pbi9hYnNlbnNpL3NjYW4iO3M6NToicm91dGUiO3M6MTA6ImFic2VuLnNjYW4iO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1794526973),
('BfdthqDevvNRw9ZB1FlZrRq9T8igLQQP4wwO3kEz', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Code/1.144.0 Chrome/150.0.7871.250 Electron/43.8.3 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiYm1KOWRXR3REdFdqQ3oza2RLQVB6OUE3MlpFTTlxTFJxdURHRE5lRyI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjE6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMCI7czo1OiJyb3V0ZSI7czo0OiJob21lIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1794465234),
('kOWsVjp5NoihAPdNI31JMAaeZpuhFLzztCB8ferz', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/157.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoid25UTGh2bmE1M1FldzBGWHdFYWxUMUVwcHpGbXU1aFJMbExhTElSMSI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6NDA6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9hZG1pbi9hYnNlbnNpL3NjYW4iO3M6NToicm91dGUiO3M6MTA6ImFic2VuLnNjYW4iO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1794471556),
('Tpoh3akAQfwENCNMGsjv4W875HECnLImju2xRGAM', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/157.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiUUZ0eFRHTXd5WE9oWTJyalNvVlZGeUw4NXJOMjZiZ3lFQUZGU1RzWSI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6NDA6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9hZG1pbi9hYnNlbnNpL3NjYW4iO3M6NToicm91dGUiO3M6MTA6ImFic2VuLnNjYW4iO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1794480448);

-- --------------------------------------------------------

--
-- Table structure for table `siswas`
--

CREATE TABLE `siswas` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `nisn` varchar(255) NOT NULL,
  `qr_token` varchar(64) DEFAULT NULL,
  `nama` varchar(255) NOT NULL,
  `kelas` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `siswas`
--

INSERT INTO `siswas` (`id`, `nisn`, `qr_token`, `nama`, `kelas`, `created_at`, `updated_at`) VALUES
(1, '0108546386', 'ZI-9HFN0UTJJV', 'AMALIATUS SOLIHAH', 'SMA - Kelas 10', '2026-10-07 06:50:24', '2026-11-12 00:55:18'),
(2, '0113808571', 'ZI-QI7G84V3HO', 'ANISA AZQIYATUL AFIYAH', 'SMA - Kelas 10', '2026-10-07 06:50:24', '2026-11-12 00:55:18'),
(3, '0104156189', 'ZI-PK2LQZFV63', 'ARDY TATA WIDJAYA', 'SMA - Kelas 10', '2026-10-07 06:50:24', '2026-11-12 00:55:18'),
(4, '0104440891', 'ZI-ULSIFI0XSW', 'Agha Afkar Khumaeni', 'SMA - Kelas 10', '2026-10-07 06:50:24', '2026-11-12 00:55:18'),
(5, '0101794032', 'ZI-MXBF3G0OKE', 'BATRISYIA SHAZFA KOSEPA', 'SMA - Kelas 10', '2026-10-07 06:50:24', '2026-11-12 00:55:18'),
(6, '0114229939', 'ZI-LUEBOKKAJF', 'FIVRIANSIH', 'SMA - Kelas 10', '2026-10-07 06:50:24', '2026-11-12 00:55:18'),
(7, '0116867469', 'ZI-WJNJISNYDD', 'IBNU MAHDI', 'SMA - Kelas 10', '2026-10-07 06:50:24', '2026-11-12 00:55:18'),
(8, '0119531953', 'ZI-GIEGRLMKTT', 'KHOIRUL\'AZAM', 'SMA - Kelas 10', '2026-10-07 06:50:24', '2026-11-12 00:55:18'),
(9, '3118412144', 'ZI-8WOX5IBZ3F', 'MAULANA HASAN', 'SMA - Kelas 10', '2026-10-07 06:50:24', '2026-11-12 00:55:18'),
(10, '0117805188', 'ZI-BXMYAUCZHP', 'MUHAMAD DIAVI NURIL QO\'IIS', 'SMA - Kelas 10', '2026-10-07 06:50:24', '2026-11-12 00:55:18'),
(11, '3118203189', 'ZI-A261LU67BA', 'MUHAMAD RAFFA FACHRUZI', 'SMA - Kelas 10', '2026-10-07 06:50:24', '2026-11-12 00:55:18'),
(12, '0117015555', 'ZI-KD26HRDZKY', 'MUHAMAD ZAKIYATUL MUSTOPA ALFIKRI', 'SMA - Kelas 10', '2026-10-07 06:50:24', '2026-11-12 00:55:18'),
(13, '3103730577', 'ZI-QJ4SQ7RGK1', 'MUHAMMAD FADHIL MAKARIM', 'SMA - Kelas 10', '2026-10-07 06:50:24', '2026-11-12 00:55:18'),
(14, '0118206442', 'ZI-SH9TEWBJ0N', 'MUHAMMAD HAFIIDH', 'SMA - Kelas 10', '2026-10-07 06:50:24', '2026-11-12 00:55:18'),
(15, '3114352068', 'ZI-UGNKH7IX6W', 'MUHAMMAD KHAIRUL AZZAM', 'SMA - Kelas 10', '2026-10-07 06:50:24', '2026-11-12 00:55:18'),
(16, '0103986127', 'ZI-A8VTT45XKE', 'Muhammad Alif', 'SMA - Kelas 10', '2026-10-07 06:50:24', '2026-11-12 00:55:18'),
(17, '0117910009', 'ZI-JVSICOGYA9', 'Muhammad Subhan Maulidi', 'SMA - Kelas 10', '2026-10-07 06:50:24', '2026-11-12 00:55:18'),
(18, '3114948663', 'ZI-VNTJM7TX04', 'RAFFASYA ATHARRAYHAN KIANO', 'SMA - Kelas 10', '2026-10-07 06:50:24', '2026-11-12 00:55:18'),
(19, '0104417619', 'ZI-9OKHR6MJA3', 'RAHMA DZAKIYYAH', 'SMA - Kelas 10', '2026-10-07 06:50:24', '2026-11-12 00:55:18'),
(20, '0112976063', 'ZI-FPD9NLOXKM', 'SITI MIFTAHUL JANNAH', 'SMA - Kelas 10', '2026-10-07 06:50:24', '2026-11-12 00:55:18'),
(21, '0104446718', 'ZI-OZR0G9CFC1', 'WISNU', 'SMA - Kelas 10', '2026-10-07 06:50:24', '2026-11-12 00:55:18'),
(22, '0106479520', 'ZI-VDDYNAY3NN', 'ZASKIA ASYA SYAKHIRA', 'SMA - Kelas 10', '2026-10-07 06:50:24', '2026-11-12 00:55:18'),
(23, '3113441899', 'ZI-8Z8CWCUREU', 'ZIDNI ALFA RIZKI', 'SMA - Kelas 10', '2026-10-07 06:50:24', '2026-11-12 00:55:18'),
(24, '0105840794', 'ZI-ORENLXSAXL', 'ANAM ABDILLAH AL AMIEN', 'SMA - Kelas 11', '2026-10-07 06:50:24', '2026-11-12 00:55:18'),
(25, '0102503974', 'ZI-HOYFPZK2ER', 'ANDREAN SETIAWAN', 'SMA - Kelas 11', '2026-10-07 06:50:24', '2026-11-12 00:55:18'),
(26, '0105754544', 'ZI-YVL2UBMKOI', 'ANJANI KHOIRUNISA', 'SMA - Kelas 11', '2026-10-07 06:50:24', '2026-11-12 00:55:18'),
(27, '0101822488', 'ZI-L7BXHLZDSP', 'Aura Octavlaniya', 'SMA - Kelas 11', '2026-10-07 06:50:24', '2026-11-12 00:55:18'),
(28, '0095071054', 'ZI-2XH9LND2SK', 'DEBER GALUH ADRIAN', 'SMA - Kelas 11', '2026-10-07 06:50:24', '2026-11-12 00:55:18'),
(29, '0101844658', 'ZI-IAV4LVGXFE', 'DINAH LATIFAH AINI', 'SMA - Kelas 11', '2026-10-07 06:50:24', '2026-11-12 00:55:18'),
(30, '0106347431', 'ZI-MT6E17LS57', 'HANDOYO NDARU PRASETYO', 'SMA - Kelas 11', '2026-10-07 06:50:24', '2026-11-12 00:55:18'),
(31, '0104170109', 'ZI-TOOW1RLPG7', 'MUHAMMAD AZZAM', 'SMA - Kelas 11', '2026-10-07 06:50:24', '2026-11-12 00:55:18'),
(32, '0109926539', 'ZI-V1W0JPTZPC', 'SYIFFA FEBYANI AZZAHRA', 'SMA - Kelas 11', '2026-10-07 06:50:24', '2026-11-12 00:55:18'),
(33, '0105313431', 'ZI-WY39LEPQUB', 'Tsabitah Putri Nailah', 'SMA - Kelas 11', '2026-10-07 06:50:24', '2026-11-12 00:55:18'),
(34, '0093312825', 'ZI-CQKHHEOKJ7', 'DICKY PERMANA', 'SMA - Kelas 12', '2026-10-07 06:50:24', '2026-11-12 00:55:18'),
(35, '0091914090', 'ZI-CXCHTGNOT7', 'Dzussabili Azizi Kosepa', 'SMA - Kelas 12', '2026-10-07 06:50:24', '2026-11-12 00:55:18'),
(36, '0094615788', 'ZI-SS9YB6HLNX', 'Habib El Mustofa', 'SMA - Kelas 12', '2026-10-07 06:50:24', '2026-11-12 00:55:18'),
(37, '0089978762', 'ZI-DTRABDSPTI', 'M. ANDREW ALFARIZI', 'SMA - Kelas 12', '2026-10-07 06:50:24', '2026-11-12 00:55:18'),
(38, '3097204913', 'ZI-KTNYYUVMQJ', 'MUHAMMAD AFDAL GUNAWAN', 'SMA - Kelas 12', '2026-10-07 06:50:24', '2026-11-12 00:55:18'),
(39, '0097112811', 'ZI-3W5QIU8MQS', 'MUHAMMAD FADILLAH AL-QUDHSY', 'SMA - Kelas 12', '2026-10-07 06:50:24', '2026-11-12 00:55:18'),
(40, '0093170449', 'ZI-10HEHJCFZS', 'MUHAMMAD GAZA MUBARAK', 'SMA - Kelas 12', '2026-10-07 06:50:24', '2026-11-12 00:55:18'),
(41, '0082449127', 'ZI-URQQANLWBW', 'MUTHIA ANNISA', 'SMA - Kelas 12', '2026-10-07 06:50:24', '2026-11-12 00:55:18'),
(42, '0086486821', 'ZI-4WXERRDIYP', 'NAZLA GIYAS RAMADHAN', 'SMA - Kelas 12', '2026-10-07 06:50:24', '2026-11-12 00:55:18'),
(43, '0097156652', 'ZI-KKPJ2O3EU4', 'SYARIF HIDAYAT', 'SMA - Kelas 12', '2026-10-07 06:50:24', '2026-11-12 00:55:18'),
(44, '0083609934', 'ZI-06U1GZS838', 'VEBY TESYE VALENTIN', 'SMA - Kelas 12', '2026-10-07 06:50:24', '2026-11-12 00:55:18'),
(45, '3132611866', 'ZI-TGY5Y99MZD', 'ABRAR ATHALLA RIAZ', 'SMP - Kelas 7', '2026-10-07 06:50:24', '2026-11-12 00:55:18'),
(46, '0132803975', 'ZI-BB40RVSUBA', 'Ahmad Alfian Rizqie', 'SMP - Kelas 7', '2026-10-07 06:50:25', '2026-11-12 00:55:18'),
(47, '3143387563', 'ZI-JXMTS1ZTXJ', 'ALYA JAZILAH SETIAWAN', 'SMP - Kelas 7', '2026-10-07 06:50:25', '2026-11-12 00:55:18'),
(48, '0139561916', 'ZI-VC0SBM4NWJ', 'ASYAM HADI FAUZAN', 'SMP - Kelas 7', '2026-10-07 06:50:25', '2026-11-12 00:55:18'),
(49, '0131337548', 'ZI-J4QKJZ9MO9', 'AYESHA RAYA RABBANI', 'SMP - Kelas 7', '2026-10-07 06:50:25', '2026-11-12 00:55:18'),
(50, '0136362143', 'ZI-2QEPDOR2BV', 'AYU MULYANA SARI', 'SMP - Kelas 7', '2026-10-07 06:50:25', '2026-11-12 00:55:18'),
(51, '3134078797', 'ZI-ITGTLIFMDX', 'DAFFA ARDIYANTO', 'SMP - Kelas 7', '2026-10-07 06:50:25', '2026-11-12 00:55:18'),
(52, '3136270575', 'ZI-4VJZP9ODFV', 'DEREN ARDIAN', 'SMP - Kelas 7', '2026-10-07 06:50:25', '2026-11-12 00:55:18'),
(53, '3147771721', 'ZI-YMCEVUATOQ', 'EVA AS-SYIFA', 'SMP - Kelas 7', '2026-10-07 06:50:25', '2026-11-12 00:55:18'),
(54, '0131534974', 'ZI-SMMWECMM4N', 'FAIZ FAADIHILAH', 'SMP - Kelas 7', '2026-10-07 06:50:25', '2026-11-12 00:55:18'),
(55, '0131007270', 'ZI-KVUB7RA9LX', 'FIKRI FIRJATULLAH RAMADHAN', 'SMP - Kelas 7', '2026-10-07 06:50:25', '2026-11-12 00:55:18'),
(56, '3138039203', 'ZI-RZYQIGVJRE', 'GEA OKTAVIA FADLI', 'SMP - Kelas 7', '2026-10-07 06:50:25', '2026-11-12 00:55:18'),
(57, '3149717046', 'ZI-AY7SHHPA0X', 'KHASIFAHTUS SAJA', 'SMP - Kelas 7', '2026-10-07 06:50:25', '2026-11-12 00:55:18'),
(58, '3148738286', 'ZI-AHYKIIO4II', 'MUHAMAD ADNAN FAISHAL ALGHIFARI', 'SMP - Kelas 7', '2026-10-07 06:50:25', '2026-11-12 00:55:18'),
(59, '0149988063', 'ZI-HLATFOM6IY', 'MUHAMAD AL-FATIH', 'SMP - Kelas 7', '2026-10-07 06:50:25', '2026-11-12 00:55:18'),
(60, '3146547514', 'ZI-TI4YNARQGZ', 'MUHAMAD BUSTANUL ARIFIN', 'SMP - Kelas 7', '2026-10-07 06:50:25', '2026-11-12 00:55:18'),
(61, '3141787485', 'ZI-XEYUGBTOXW', 'MUHAMMAD AR RASID', 'SMP - Kelas 7', '2026-10-07 06:50:25', '2026-11-12 00:55:18'),
(62, '0143824896', 'ZI-V7CZGAS73A', 'MUHAMMAD FADLIANSYAH', 'SMP - Kelas 7', '2026-10-07 06:50:25', '2026-11-12 00:55:18'),
(63, '0141732927', 'ZI-BWGZAMRISB', 'MUHAMMAD UWAIS RUZAINSYAH', 'SMP - Kelas 7', '2026-10-07 06:50:25', '2026-11-12 00:55:18'),
(64, '3142470957', 'ZI-FRQVSUFOTU', 'Muhammad Naufal Afkar', 'SMP - Kelas 7', '2026-10-07 06:50:25', '2026-11-12 00:55:18'),
(65, '3148330159', 'ZI-FJQSLYD8QR', 'NAHDIYAH', 'SMP - Kelas 7', '2026-10-07 06:50:25', '2026-11-12 00:55:18'),
(66, '0132306582', 'ZI-KNIHFNABSY', 'Nur Azzahra Hafidzah El Muharom', 'SMP - Kelas 7', '2026-10-07 06:50:25', '2026-11-12 00:55:18'),
(67, '0146909417', 'ZI-6TUYHNGB9F', 'Nurul Yuliazahra', 'SMP - Kelas 7', '2026-10-07 06:50:25', '2026-11-12 00:55:18'),
(68, '3134434135', 'ZI-OTJOIHVJ9V', 'Qurratu\'aini Pawoko Putri', 'SMP - Kelas 7', '2026-10-07 06:50:25', '2026-11-12 00:55:18'),
(69, '0128749397', 'ZI-YOFGAAGQDQ', 'Siti Halimatu ssya\'diyah', 'SMP - Kelas 7', '2026-10-07 06:50:25', '2026-11-12 00:55:18'),
(70, '0139972841', 'ZI-JZYAZNHVZL', 'Siti Mariyatu Qibtiyah', 'SMP - Kelas 7', '2026-10-07 06:50:25', '2026-11-12 00:55:18'),
(71, '3145362780', 'ZI-ZMHLN3GEDF', 'SUKAINAH ZAKIYYAH', 'SMP - Kelas 7', '2026-10-07 06:50:25', '2026-11-12 00:55:18'),
(72, '3130427901', 'ZI-2NTCEKOGF5', 'SULTHAN RAZHAN GUNADI', 'SMP - Kelas 7', '2026-10-07 06:50:25', '2026-11-12 00:55:18'),
(73, '3121087941', 'ZI-Q5V2QLMWGR', 'AINAYYA JIHAN SYAFIRA', 'SMP - Kelas 8', '2026-10-07 06:50:25', '2026-11-12 00:55:18'),
(74, '3135917858', 'ZI-EBTJMRGMWY', 'AIRIN PUTRI ZATULINI', 'SMP - Kelas 8', '2026-10-07 06:50:25', '2026-11-12 00:55:18'),
(75, '3139179220', 'ZI-FL2B1EB1JU', 'Alya Nasywa', 'SMP - Kelas 8', '2026-10-07 06:50:25', '2026-11-12 00:55:18'),
(76, '0135422070', 'ZI-TSI4YAPGD0', 'Azkia Salsabila Maheswari', 'SMP - Kelas 8', '2026-10-07 06:50:25', '2026-11-12 00:55:18'),
(77, '3128055373', 'ZI-BPXCLMWIVL', 'DAFFA SYAWALUDIN', 'SMP - Kelas 8', '2026-10-07 06:50:25', '2026-11-12 00:55:18'),
(78, '0135407382', 'ZI-6JIJX1F7AB', 'FAIDA ANNAILA', 'SMP - Kelas 8', '2026-10-07 06:50:25', '2026-11-12 00:55:18'),
(79, '3124265373', 'ZI-J7ISBIEBBB', 'FATHIR ALISAPUTRA', 'SMP - Kelas 8', '2026-10-07 06:50:25', '2026-11-12 00:55:18'),
(80, '0102547002', 'ZI-VKNJXPKN20', 'Fira Aulia', 'SMP - Kelas 8', '2026-10-07 06:50:25', '2026-11-12 00:55:18'),
(81, '3133917981', 'ZI-JHEWPQOYLS', 'FITRI HUMAIROH', 'SMP - Kelas 8', '2026-10-07 06:50:25', '2026-11-12 00:55:18'),
(82, '3123132602', 'ZI-XCSDESNZJC', 'HAFIZ ZULPI', 'SMP - Kelas 8', '2026-10-07 06:50:25', '2026-11-12 00:55:18'),
(83, '3121580188', 'ZI-MXTHI7IW7U', 'HILMA ADSYILA', 'SMP - Kelas 8', '2026-10-07 06:50:25', '2026-11-12 00:55:18'),
(84, '3133086836', 'ZI-FJTPS37DZS', 'MAHIRA HASNA MAULIDA', 'SMP - Kelas 8', '2026-10-07 06:50:25', '2026-11-12 00:55:18'),
(85, '3121376666', 'ZI-Q7UORSJJU6', 'Muhamad Farand', 'SMP - Kelas 8', '2026-10-07 06:50:25', '2026-11-12 00:55:18'),
(86, '3123759816', 'ZI-HLVLBENYO2', 'Muhammad Al Fatih Saputra', 'SMP - Kelas 8', '2026-10-07 06:50:25', '2026-11-12 00:55:18'),
(87, '3128221602', 'ZI-WHLY1TGZHA', 'Muhammad Azizan Arif Afari', 'SMP - Kelas 8', '2026-10-07 06:50:25', '2026-11-12 00:55:18'),
(88, '3137292645', 'ZI-VGB7SURV1I', 'MUHAMMAD ILHAM ALIYUDIN', 'SMP - Kelas 8', '2026-10-07 06:50:25', '2026-11-12 00:55:18'),
(89, '3120958951', 'ZI-XPC2BCYG1N', 'MUHAMMAD RAYQI SUBHAN', 'SMP - Kelas 8', '2026-10-07 06:50:25', '2026-11-12 00:55:18'),
(90, '0127768152', 'ZI-8ESSGRJVL6', 'MUHAMMAD RESTU', 'SMP - Kelas 8', '2026-10-07 06:50:25', '2026-11-12 00:55:18'),
(91, '3139057385', 'ZI-S2VBSGECTK', 'MUHAMMAD SEM EL MUIZ', 'SMP - Kelas 8', '2026-10-07 06:50:25', '2026-11-12 00:55:18'),
(92, '0139070503', 'ZI-QSR0GCBIJI', 'NABIL SYAFIQ MUYASSAR', 'SMP - Kelas 8', '2026-10-07 06:50:25', '2026-11-12 00:55:18'),
(93, '0122054619', 'ZI-AYFY98JSW6', 'OLINDA TRI KUMALA', 'SMP - Kelas 8', '2026-10-07 06:50:25', '2026-11-12 00:55:18'),
(94, '3132223405', 'ZI-WP6QIBTHYS', 'Popy Windy Astuty', 'SMP - Kelas 8', '2026-10-07 06:50:25', '2026-11-12 00:55:18'),
(95, '3129973807', 'ZI-FSID7EEGAD', 'PRISYILA NABILATUL MUFTIAH', 'SMP - Kelas 8', '2026-10-07 06:50:25', '2026-11-12 00:55:18'),
(96, '3123115357', 'ZI-BTYKTRPNJX', 'RAFA NURUN IBENG', 'SMP - Kelas 8', '2026-10-07 06:50:25', '2026-11-12 00:55:18'),
(97, '3138041699', 'ZI-9RZQZY1TGM', 'RAFFA SAPUTRA', 'SMP - Kelas 8', '2026-10-07 06:50:25', '2026-11-12 00:55:18'),
(98, '0129961826', 'ZI-1GLOQJWHAO', 'SITI AYU RAHMA YANTI', 'SMP - Kelas 8', '2026-10-07 06:50:25', '2026-11-12 00:55:18'),
(99, '0122470704', 'ZI-YKXRJBPZFE', 'SITI NURANNISA', 'SMP - Kelas 8', '2026-10-07 06:50:25', '2026-11-12 00:55:18'),
(100, '0126770078', 'ZI-EQRFWT3JTG', 'Siti Robiah Chantika', 'SMP - Kelas 8', '2026-10-07 06:50:25', '2026-11-12 00:55:18'),
(101, '3139386923', 'ZI-EXW6XCZ23Q', 'ZAHRA APRILIA', 'SMP - Kelas 8', '2026-10-07 06:50:25', '2026-11-12 00:55:18'),
(102, '0113034124', 'ZI-JZOKVIHETR', 'AHMAD ABNI AL - AHLAMI', 'SMP - Kelas 9', '2026-10-07 06:50:25', '2026-11-12 00:55:18'),
(103, '3118211178', 'ZI-9JERGQLACJ', 'AUREL HANA TASYA', 'SMP - Kelas 9', '2026-10-07 06:50:25', '2026-11-12 00:55:18'),
(104, '3127593426', 'ZI-JWXRCCVOTN', 'BALQIS ALLYA FEBRIANI GRIAPON', 'SMP - Kelas 9', '2026-10-07 06:50:25', '2026-11-12 00:55:18'),
(105, '0111198672', 'ZI-VZ245TFLNH', 'Dafa Ramadhan', 'SMP - Kelas 9', '2026-10-07 06:50:25', '2026-11-12 00:55:18'),
(106, '0128774877', 'ZI-LMUXEVIS8U', 'Daffa Bayin Mahdi', 'SMP - Kelas 9', '2026-10-07 06:50:25', '2026-11-12 00:55:18'),
(107, '0127921833', 'ZI-U5Z9DIOIJL', 'KHALIF HAKIM ATHARIZZ', 'SMP - Kelas 9', '2026-10-07 06:50:25', '2026-11-12 00:55:18'),
(108, '0124098643', 'ZI-BOGLHUAAOI', 'Kirana Cahya Anggraeni', 'SMP - Kelas 9', '2026-10-07 06:50:25', '2026-11-12 00:55:18'),
(109, '3128769379', 'ZI-M0Z74KYTEY', 'LUVITA NADIRA PUTRI', 'SMP - Kelas 9', '2026-10-07 06:50:25', '2026-11-12 00:55:18'),
(110, '0121771272', 'ZI-OIP9GJZZPX', 'Muhamad Khoirul Hakim', 'SMP - Kelas 9', '2026-10-07 06:50:25', '2026-11-12 00:55:18'),
(111, '0128451834', 'ZI-ZJTZ3LFCMP', 'MUHAMAD YUSUP', 'SMP - Kelas 9', '2026-10-07 06:50:25', '2026-11-12 00:55:18'),
(112, '3114180929', 'ZI-B7FGFUIYEM', 'MUHAMMAD KAISAR RIZKI', 'SMP - Kelas 9', '2026-10-07 06:50:25', '2026-11-12 00:55:18'),
(113, '3110718108', 'ZI-YRHHJZYHJM', 'NOPI RISMAWATI', 'SMP - Kelas 9', '2026-10-07 06:50:25', '2026-11-12 00:55:18'),
(114, '0124976334', 'ZI-ZQETJNNVKD', 'Nur Az - Zukhruf Hilal Ramadhania', 'SMP - Kelas 9', '2026-10-07 06:50:25', '2026-11-12 00:55:18'),
(115, '3127268573', 'ZI-WRHRGXJQD4', 'PUTRA SAI`AN PRATAMA', 'SMP - Kelas 9', '2026-10-07 06:50:25', '2026-11-12 00:55:18'),
(116, '3126045718', 'ZI-L0YAUZJT7Z', 'RAIHAN NAFIS', 'SMP - Kelas 9', '2026-10-07 06:50:25', '2026-11-12 00:55:18'),
(117, '0112888562', 'ZI-SBVUQTDFSR', 'Rendra Dwi Kurniawan', 'SMP - Kelas 9', '2026-10-07 06:50:25', '2026-11-12 00:55:18'),
(118, '0129347645', 'ZI-ZVGE374VG2', 'Rizqi Rhamadan', 'SMP - Kelas 9', '2026-10-07 06:50:25', '2026-11-12 00:55:18'),
(119, '0125429331', 'ZI-JZYDVFBPSC', 'SAPTIAN', 'SMP - Kelas 9', '2026-10-07 06:50:25', '2026-11-12 00:55:18'),
(120, '3121507675', 'ZI-TVJIB83HU7', 'Silvia Putri', 'SMP - Kelas 9', '2026-10-07 06:50:25', '2026-11-12 00:55:18'),
(121, '3122389243', 'ZI-HCU1D8DOVQ', 'STEPHANIE GONDHODISASTRO', 'SMP - Kelas 9', '2026-10-07 06:50:25', '2026-11-12 00:55:18'),
(122, '0114548845', 'ZI-PEUZSHLBCU', 'SULKI', 'SMP - Kelas 9', '2026-10-07 06:50:25', '2026-11-12 00:55:18'),
(123, '3112096036', 'ZI-7DWLWACIJP', 'SYIFA KHOIRUNNISA', 'SMP - Kelas 9', '2026-10-07 06:50:25', '2026-11-12 00:55:18'),
(124, '3122000284', 'ZI-ABHWANKVL4', 'VINO SANDIKA', 'SMP - Kelas 9', '2026-10-07 06:50:25', '2026-11-12 00:55:18'),
(125, '0121133181', 'ZI-TDBOMNNVOO', 'Yuga Solehudin', 'SMP - Kelas 9', '2026-10-07 06:50:25', '2026-11-12 00:55:18');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `absensis`
--
ALTER TABLE `absensis`
  ADD PRIMARY KEY (`id`),
  ADD KEY `absensis_siswa_id_foreign` (`siswa_id`);

--
-- Indexes for table `cache`
--
ALTER TABLE `cache`
  ADD PRIMARY KEY (`key`),
  ADD KEY `cache_expiration_index` (`expiration`);

--
-- Indexes for table `cache_locks`
--
ALTER TABLE `cache_locks`
  ADD PRIMARY KEY (`key`),
  ADD KEY `cache_locks_expiration_index` (`expiration`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `jobs_queue_index` (`queue`);

--
-- Indexes for table `job_batches`
--
ALTER TABLE `job_batches`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `nilais`
--
ALTER TABLE `nilais`
  ADD PRIMARY KEY (`id`),
  ADD KEY `nilais_siswa_id_foreign` (`siswa_id`);

--
-- Indexes for table `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- Indexes for table `pengumumans`
--
ALTER TABLE `pengumumans`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ppdbs`
--
ALTER TABLE `ppdbs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `profils`
--
ALTER TABLE `profils`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sessions_user_id_index` (`user_id`),
  ADD KEY `sessions_last_activity_index` (`last_activity`);

--
-- Indexes for table `siswas`
--
ALTER TABLE `siswas`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `siswas_nisn_unique` (`nisn`),
  ADD UNIQUE KEY `siswas_qr_token_unique` (`qr_token`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `absensis`
--
ALTER TABLE `absensis`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `nilais`
--
ALTER TABLE `nilais`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `pengumumans`
--
ALTER TABLE `pengumumans`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `ppdbs`
--
ALTER TABLE `ppdbs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `profils`
--
ALTER TABLE `profils`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `siswas`
--
ALTER TABLE `siswas`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=126;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `absensis`
--
ALTER TABLE `absensis`
  ADD CONSTRAINT `absensis_siswa_id_foreign` FOREIGN KEY (`siswa_id`) REFERENCES `siswas` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `nilais`
--
ALTER TABLE `nilais`
  ADD CONSTRAINT `nilais_siswa_id_foreign` FOREIGN KEY (`siswa_id`) REFERENCES `siswas` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
