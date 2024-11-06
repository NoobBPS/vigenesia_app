-- -------------------------------------------------------------
-- TablePlus 6.1.8(574)
--
-- https://tableplus.com/
--
-- Database: portal
-- Generation Time: 2024-10-16 10:35:27.8270
-- -------------------------------------------------------------


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


DROP TABLE IF EXISTS `berita`;
CREATE TABLE `berita` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `judul` varchar(200) DEFAULT NULL,
  `isi` text,
  `kategori_id` int(11) DEFAULT NULL,
  `created_at` date DEFAULT NULL,
  `updated_at` date DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `kategori`;
CREATE TABLE `kategori` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nama_kategori` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nama` varchar(3100) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `username` varchar(255) NOT NULL,
  `email` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `password` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `role_id` int(11) DEFAULT NULL,
  `is_active` int(1) NOT NULL DEFAULT '0',
  `created_at` date NOT NULL,
  `updated_at` date NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

INSERT INTO `kategori` (`id`, `nama_kategori`) VALUES
(1, 'Teknologi'),
(2, 'Ekonomi'),
(3, 'Olahraga'),
(4, 'Kriminal');

INSERT INTO `user` (`id`, `nama`, `username`, `email`, `password`, `role_id`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 'Indra Chaidir, M.Kom', 'indra', 'indra@bsi.ac.id', '$2y$12$hzpMklpme8.Ay3evZCtxMebghX3.Ec3aCoS/e9j50sdqvRDin74GW', 1, 1, '2024-10-09', '2024-10-09');



/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;