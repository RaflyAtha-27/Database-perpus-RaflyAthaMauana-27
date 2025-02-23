-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 22 Feb 2025 pada 16.21
-- Versi server: 10.4.32-MariaDB
-- Versi PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db_perpus`
--

DELIMITER $$
--
-- Prosedur
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_buku` (`pIdBuku` INT)   BEGIN
    DELETE FROM buku WHERE id = pIdBuku;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_peminjaman` (`pIdPeminjaman` INT)   BEGIN
    DELETE FROM peminjaman WHERE id = pIDPeminjaman;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_siswa` (`pIDSiswa` INT)   BEGIN
	DELETE FROM siswa WHERE id = pIDSiswa;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_buku` (`pJudul` VARCHAR(50), `pPenulis` VARCHAR(50), `pKategori` VARCHAR(50), `pStok` INT)   BEGIN 
INSERT INTO buku(JudulBuku, Penulis, Kategori, stok) VALUES(pJudul, pPenulis, pKategori, pStok);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_peminjaman` (`pIDSiswa` INT, `pIDBuku` INT, `pTanggalPinjam` VARCHAR(50), `pTanggalKembali` VARCHAR(50), `pStatus` VARCHAR(50))   BEGIN
INSERT INTO peminjaman(IDSiswa, IDBuku, TangggallPinjam, TanggalKembali, Status) VALUES(pIDSiswa, pIDBuku, pTanggalPinjam, pTanggalKembali, pStatus);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_siswa` (`pNama` VARCHAR(50), `pKelas` VARCHAR(50))   BEGIN
    INSERT INTO siswa (Nama, Kelas) VALUES(pNama, pKelas);
    END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `kembalikanbuku` (`IDPeminjaman` INT)   BEGIN
    UPDATE peminjaman
    SET Status = 'Dikembalikan', Tanggal_Kembali = CURRENT_DATE
    WHERE ID_Peminjaman = IDPeminjaman;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SemuaBuku` ()   BEGIN
SELECT b.ID_Buku, b.Judul_Buku, b.Penulis, b.Kategori, b.Stok,
CASE
WHEN p.IDBuku IS NULL THEN 'Belum Pernah Dipinjam'
ELSE 'Pernah Dipinjam'
END AS Status
FROM buku b
LEFT JOIN peminjaman p ON b.ID_Buku = p.IDBuku
GROUP BY b.ID_Buku;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SemuaSiswa` ()   BEGIN
    SELECT s.ID_Siswa, s.Nama, s.Kelas,
    CASE
        WHEN p.ID_Siswa IS NULL THEN 'Belum Pernah Meminjam'
        ELSE 'Pernah Meminjam'
    END AS Status
    FROM siswa s
    LEFT JOIN peminjaman p ON s.ID_Siswa = p.ID_Siswa
    GROUP BY s.ID_Siswa;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SiswaPernahMinjam` ()   BEGIN
    SELECT DISTINCT s.ID_Siswa, s.Nama, s.Kelas
    FROM siswa s
    INNER JOIN peminjaman p ON s.ID_Siswa = p.ID_Siswa;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `tampilkan_buku` ()   BEGIN
    SELECT * FROM buku;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `tampilkan_peminjaman` ()   BEGIN
    SELECT * FROM peminjaman;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `tampilkan_siswa` ()   BEGIN
    SELECT * FROM siswa;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `update_buku` (`pIDBuku` INT, `pJudulBuku` VARCHAR(50), `pPengarangBuku` VARCHAR(50), `pKategoriBuku` VARCHAR(50), `pStok` INT)   BEGIN
    UPDATE buku
    SET judul = pJudulBuku, pengarang = pPengarangBuku, kategori = pKategoriBuku, stok = pStokBuku
    WHERE id = pIdBuku;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `update_peminjaman` (`pIdBuku` INT, `pIdSiswa` INT, `pTanggalPinjam` DATE, `pTanggalKembali` DATE, `pStatusPinjam` VARCHAR(50))   BEGIN
    UPDATE peminjaman
    SET IDBuku = pIDBuku, IDSiswa = pIDSiswa, TanggalPinjam = pTanggalPinjam, TanggalKembali = pTanggalKembali, status = pStatus
    WHERE id = IDPeminjaman;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `update_siswa` (`pIdSiswa` INT, `pNamaSiswa` VARCHAR(50), `pKelasSiswa` VARCHAR(50))   BEGIN
    UPDATE siswa
    SET nama = pNamaSiswa, kelas = pKelasSiswa
    WHERE id = pIdSiswa;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Struktur dari tabel `buku`
--

CREATE TABLE `buku` (
  `IDBuku` int(11) NOT NULL,
  `JudulBuku` varchar(50) DEFAULT NULL,
  `Penulis` varchar(50) DEFAULT NULL,
  `Kategori` varchar(50) DEFAULT NULL,
  `Stok` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `buku`
--

INSERT INTO `buku` (`IDBuku`, `JudulBuku`, `Penulis`, `Kategori`, `Stok`) VALUES
(1, 'Algoritma dan Pemrograman', 'Andi Wijaya', 'Teknologi', 5),
(2, 'Dasar-dasar Database', 'Budi Santoso', 'Teknologi', 7),
(3, 'Matematika Diskrit', 'Rina Sari', 'Matematika', 4),
(4, 'Sejarah Dunia', 'John Smith', 'John Smith', 3),
(5, 'Pemrograman Web dengan PHP', 'Eko Prasetyo', 'Eko Prasetyo', 8),
(6, 'Sistem Operasi', 'Dian Kurniawan', 'Teknologi', 6),
(7, 'Jaringan Komputer', 'Ahmad Fauzi', 'Teknologi', 5),
(8, 'Cerita Rakyat Nusantara', 'Lestari Dewi', 'Sastra', 9),
(9, 'Bahasa Inggris untuk Pemula', 'Jane Doe', 'Bahasa', 10),
(10, 'Biologi Dasar', 'Budi Rahman', 'Sains', 7),
(11, 'Kimia Organik', 'Siti Aminah', 'Sains', 5),
(12, 'Teknik Elektro', 'Ridwan Hakim', 'Teknik', 6),
(13, 'Fisika Modern', 'Albert Einstein', 'Sains', 4),
(14, 'Manajemen Waktu', 'Steven Covey', 'Pengembangan', 8),
(15, 'Strategi Belajar Efektif', 'Tony Buzan', 'Pendidikan', 6);

-- --------------------------------------------------------

--
-- Struktur dari tabel `peminjaman`
--

CREATE TABLE `peminjaman` (
  `IDPeminjaman` int(11) NOT NULL,
  `IDSiswa` int(11) DEFAULT NULL,
  `IDBuku` int(11) DEFAULT NULL,
  `TanggalPinjam` date DEFAULT NULL,
  `TanggalKembali` date DEFAULT NULL,
  `Status` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `peminjaman`
--

INSERT INTO `peminjaman` (`IDPeminjaman`, `IDSiswa`, `IDBuku`, `TanggalPinjam`, `TanggalKembali`, `Status`) VALUES
(1, 11, 2, '2025-02-01', '2025-02-08', 'Dipinjam'),
(2, 2, 5, '2025-01-28', '2025-02-04', 'Dikembalikan'),
(3, 3, 8, '2025-02-02', '2025-02-09', 'Dipinjam'),
(4, 4, 10, '2025-01-30', '2025-02-06', 'Dikembaliikan'),
(5, 5, 3, '2025-01-25', '2025-02-01', 'Dikembalikan');

--
-- Trigger `peminjaman`
--
DELIMITER $$
CREATE TRIGGER `after_insert_peminjaman` AFTER INSERT ON `peminjaman` FOR EACH ROW BEGIN
    UPDATE buku
    SET Stok = Stok - 1
    WHERE IDBuku = NEW.IDBuku;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `after_update_peminjaman` AFTER UPDATE ON `peminjaman` FOR EACH ROW BEGIN
    IF NEW.Status = 'Dikembalikan'
    THEN UPDATE buku SET Stok = Stok + 1
    WHERE IDBuku = NEW.IDBuku;
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struktur dari tabel `siswa`
--

CREATE TABLE `siswa` (
  `IDSiswa` int(11) NOT NULL,
  `Nama` varchar(50) DEFAULT NULL,
  `Kelas` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `siswa`
--

INSERT INTO `siswa` (`IDSiswa`, `Nama`, `Kelas`) VALUES
(1, 'Andi Saputra', 'X-RPL'),
(2, 'Budi Wijaya', 'X-TKJ'),
(3, 'Citra Lestari', 'XI-RPL'),
(4, 'Dewi Kurniawan', 'XI-TKJ'),
(5, 'Eko Prasetyo', 'XII-RPL'),
(6, 'Farhan Maulana', 'XII-TKJ'),
(7, 'Gita Permata', 'X-RPL'),
(8, 'Hadi Sucipto', 'X-TKJ'),
(9, 'Intan Permadi', 'XI-RPL'),
(10, 'Joko Santoso', 'XI-TKJ'),
(11, 'Kartika Sari', 'XII-RPL'),
(12, 'Lintang Putri', 'XII-TKJ'),
(13, 'Muhammad Rizky', 'X-RPL'),
(14, 'Novi Andriana', 'X-TKJ'),
(15, 'Olivia Hernanda', 'XI-RPL');

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `buku`
--
ALTER TABLE `buku`
  ADD PRIMARY KEY (`IDBuku`);

--
-- Indeks untuk tabel `peminjaman`
--
ALTER TABLE `peminjaman`
  ADD PRIMARY KEY (`IDPeminjaman`);

--
-- Indeks untuk tabel `siswa`
--
ALTER TABLE `siswa`
  ADD PRIMARY KEY (`IDSiswa`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `buku`
--
ALTER TABLE `buku`
  MODIFY `IDBuku` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT untuk tabel `peminjaman`
--
ALTER TABLE `peminjaman`
  MODIFY `IDPeminjaman` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT untuk tabel `siswa`
--
ALTER TABLE `siswa`
  MODIFY `IDSiswa` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
