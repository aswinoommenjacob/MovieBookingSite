-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: May 17, 2025 at 05:55 AM
-- Server version: 8.0.41
-- PHP Version: 8.2.13

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `project`
--

-- --------------------------------------------------------

--
-- Table structure for table `admins`
--

DROP TABLE IF EXISTS `admins`;
CREATE TABLE IF NOT EXISTS `admins` (
  `id` int NOT NULL AUTO_INCREMENT,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `admins`
--

INSERT INTO `admins` (`id`, `email`, `password`) VALUES
(1, 'aswinorolickal10@gmail.com', 'Aswin'),
(2, 'admin2@gmail.com', 'admin2');

-- --------------------------------------------------------

--
-- Table structure for table `bookings`
--

DROP TABLE IF EXISTS `bookings`;
CREATE TABLE IF NOT EXISTS `bookings` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `movie_id` int DEFAULT NULL,
  `seat_no` varchar(100) DEFAULT NULL,
  `booking_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `theater_id` int DEFAULT NULL,
  `showtime_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `movie_id` (`movie_id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `bookings`
--

INSERT INTO `bookings` (`id`, `user_id`, `movie_id`, `seat_no`, `booking_date`, `theater_id`, `showtime_id`) VALUES
(7, 1, 1, '1', '2025-02-23 18:27:08', NULL, NULL),
(8, 1, 1, '6', '2025-02-23 18:27:20', NULL, NULL),
(9, 1, 1, '5', '2025-02-23 18:58:59', NULL, NULL),
(10, 1, 1, '3', '2025-02-25 08:22:01', NULL, NULL),
(11, 1, 1, '6', '2025-02-25 09:12:45', NULL, NULL),
(12, 1, 1, '3', '2025-02-25 09:54:05', NULL, NULL),
(13, 1, 1, '9', '2025-03-04 10:25:16', NULL, NULL),
(15, 1, 6, '20', '2025-03-06 18:31:54', NULL, NULL),
(16, 1, 6, '4', '2025-03-06 18:35:18', NULL, NULL),
(17, 1, 6, '3', '2025-03-06 18:35:39', NULL, NULL),
(18, 1, 6, '6', '2025-03-06 18:48:02', NULL, NULL),
(19, 3, 1, 'A6', '2025-04-05 15:45:23', NULL, NULL),
(20, 3, 1, 'J10', '2025-04-05 15:49:13', NULL, NULL),
(21, 3, 1, 'G7', '2025-04-07 16:59:13', NULL, NULL),
(22, 3, 1, 'H5', '2025-04-08 04:00:30', NULL, NULL),
(23, 1, 1, 'D4,D5,D6', '2025-04-08 07:36:22', NULL, NULL),
(24, 1, 12, 'B6', '2025-05-02 15:18:29', 5, 82),
(25, 1, 1, 'B5', '2025-05-02 15:26:23', 1, 1),
(26, 1, 1, 'B6', '2025-05-02 15:27:22', 1, 1),
(27, 1, 1, 'J6', '2025-05-02 16:16:27', 1, 1),
(28, 1, 1, 'B8,B9,B10', '2025-05-02 16:20:30', 1, 1),
(29, 1, 1, 'C10', '2025-05-06 16:29:03', 1, 2),
(30, 1, 1, 'J2,J3', '2025-05-07 04:52:56', 5, 76);

-- --------------------------------------------------------

--
-- Table structure for table `movies`
--

DROP TABLE IF EXISTS `movies`;
CREATE TABLE IF NOT EXISTS `movies` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `genre` varchar(50) DEFAULT NULL,
  `duration` int DEFAULT NULL,
  `rating` float DEFAULT NULL,
  `image_url` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `movies`
--

INSERT INTO `movies` (`id`, `title`, `genre`, `duration`, `rating`, `image_url`) VALUES
(1, 'Inception', 'Sci-Fi', 148, 8.8, 'https://static.toiimg.com/photo/msid-6177430/6177430.jpg?57181'),
(6, 'The Gorge', 'Action', 230, 4.9, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTUV1kAF3lWDgwbP6mdLoCCLrkIacQIh6EsEg&s'),
(12, 'empuran', 'action', 180, 0, 'https://encrypted-tbn1.gstatic.com/images?q=tbn:ANd9GcSnthauVBF5goStd0cP3IsBK3-BPKEIA1PvzhDMBOhxB_PeswIR_5i31VgvGsgdWllyzCj_Ti-UBySZbIjeyCE2Uhb4Txu9DgxmeEG1iNaS');

-- --------------------------------------------------------

--
-- Table structure for table `movie_theater`
--

DROP TABLE IF EXISTS `movie_theater`;
CREATE TABLE IF NOT EXISTS `movie_theater` (
  `id` int NOT NULL AUTO_INCREMENT,
  `movie_id` int DEFAULT NULL,
  `theater_id` int DEFAULT NULL,
  `show_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_theater_showtime` (`theater_id`,`show_time`),
  KEY `movie_id` (`movie_id`),
  KEY `theater_id` (`theater_id`)
) ENGINE=InnoDB AUTO_INCREMENT=86 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `movie_theater`
--

INSERT INTO `movie_theater` (`id`, `movie_id`, `theater_id`, `show_time`) VALUES
(1, 1, 1, '2025-02-23 10:00:00'),
(2, 1, 1, '2025-02-23 14:00:00'),
(3, 1, 1, '2025-02-23 20:00:00'),
(8, 6, 1, '2025-02-23 16:00:00'),
(9, 6, 1, '2025-02-23 22:00:00'),
(10, 12, 1, '2025-02-24 10:00:00'),
(11, 12, 1, '2025-02-24 14:00:00'),
(12, 12, 1, '2025-02-24 18:00:00'),
(49, 1, 2, '2025-02-23 10:00:00'),
(50, 1, 2, '2025-02-23 14:00:00'),
(51, 1, 2, '2025-02-23 20:00:00'),
(52, 6, 2, '2025-02-23 16:00:00'),
(54, 6, 2, '2025-02-23 22:00:00'),
(55, 12, 2, '2025-02-24 10:00:00'),
(56, 12, 2, '2025-02-24 14:00:00'),
(57, 12, 2, '2025-02-24 18:00:00'),
(58, 1, 3, '2025-02-23 10:00:00'),
(59, 1, 3, '2025-02-23 14:00:00'),
(60, 1, 3, '2025-02-23 20:00:00'),
(61, 6, 3, '2025-02-23 16:00:00'),
(63, 6, 3, '2025-02-23 22:00:00'),
(64, 12, 3, '2025-02-24 10:00:00'),
(65, 12, 3, '2025-02-24 14:00:00'),
(66, 12, 3, '2025-02-24 18:00:00'),
(67, 1, 4, '2025-02-23 10:00:00'),
(68, 1, 4, '2025-02-23 14:00:00'),
(69, 1, 4, '2025-02-23 20:00:00'),
(70, 6, 4, '2025-02-23 16:00:00'),
(72, 6, 4, '2025-02-23 22:00:00'),
(73, 12, 4, '2025-02-24 10:00:00'),
(74, 12, 4, '2025-02-24 14:00:00'),
(75, 12, 4, '2025-02-24 18:00:00'),
(76, 1, 5, '2025-02-23 10:00:00'),
(77, 1, 5, '2025-02-23 14:00:00'),
(78, 1, 5, '2025-02-23 20:00:00'),
(79, 6, 5, '2025-02-23 16:00:00'),
(81, 6, 5, '2025-02-23 22:00:00'),
(82, 12, 5, '2025-02-24 10:00:00'),
(83, 12, 5, '2025-02-24 14:00:00'),
(84, 12, 5, '2025-02-24 18:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `theaters`
--

DROP TABLE IF EXISTS `theaters`;
CREATE TABLE IF NOT EXISTS `theaters` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `location` varchar(255) NOT NULL,
  `location_url` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `theaters`
--

INSERT INTO `theaters` (`id`, `name`, `location`, `location_url`) VALUES
(1, 'PVR Cinemas', 'Delhi', 'https://maps.app.goo.gl/uNpD6jVrQXhjTs4y9'),
(2, 'INOX', 'Mumbai', 'https://maps.app.goo.gl/dummyUrlForINOX'),
(3, 'Cinepolis', 'Bangalore', 'https://maps.app.goo.gl/5Fujg6BWivZua4Qi6'),
(4, 'Carnival Cinemas', 'Kolkata', 'https://maps.app.goo.gl/3FEu3NTS1VfP5bb49'),
(5, 'abilash', 'kerala', 'https://maps.app.goo.gl/tQHFbUQe2Y9PNxoq7');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `password`) VALUES
(1, 'Aswin Oommen Jacob', 'aswinorolickal28@gmail.com', 'hello'),
(2, 'Annie David', 'annied.mca2426@saintgits.org', '5354365465'),
(3, 'belvin', 'belvin@gmail.com', '123');

--
-- Constraints for dumped tables
--

--
-- Constraints for table `bookings`
--
ALTER TABLE `bookings`
  ADD CONSTRAINT `bookings_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `bookings_ibfk_2` FOREIGN KEY (`movie_id`) REFERENCES `movies` (`id`);

--
-- Constraints for table `movie_theater`
--
ALTER TABLE `movie_theater`
  ADD CONSTRAINT `fk_movie` FOREIGN KEY (`movie_id`) REFERENCES `movies` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_theater` FOREIGN KEY (`theater_id`) REFERENCES `theaters` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
