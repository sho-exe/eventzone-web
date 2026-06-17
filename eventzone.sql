-- phpMyAdmin SQL Dump
-- version 5.2.3
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Jun 15, 2026 at 11:02 AM
-- Server version: 9.6.0
-- PHP Version: 8.5.7

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `eventzone`
--

-- --------------------------------------------------------

--
-- Table structure for table `attendances`
--

CREATE TABLE `attendances` (
  `attendance_id` int NOT NULL,
  `event_id` int NOT NULL,
  `user_id` int NOT NULL,
  `registration_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `status` varchar(50) COLLATE utf8mb4_general_ci DEFAULT 'REGISTERED',
  `verified_by` int DEFAULT NULL,
  `position` varchar(100) COLLATE utf8mb4_general_ci DEFAULT 'Ahli Kelab'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `clubs`
--

CREATE TABLE `clubs` (
  `club_id` int NOT NULL,
  `club_name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `description` text COLLATE utf8mb4_general_ci,
  `advisor_id` int DEFAULT NULL,
  `chairperson_id` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `events`
--

CREATE TABLE `events` (
  `event_id` int NOT NULL,
  `event_name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `description` text COLLATE utf8mb4_general_ci,
  `date` date DEFAULT NULL,
  `venue` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `quota` int DEFAULT NULL,
  `criteria` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `category` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `club_id` int DEFAULT NULL,
  `status` varchar(50) COLLATE utf8mb4_general_ci DEFAULT 'PENDING',
  `sdg_goals` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `merits`
--

CREATE TABLE `merits` (
  `merit_id` int NOT NULL,
  `user_id` int NOT NULL,
  `event_id` int NOT NULL,
  `points` int NOT NULL,
  `awarded_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` int NOT NULL,
  `username` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `email` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `full_name` varchar(150) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `role` varchar(50) COLLATE utf8mb4_general_ci DEFAULT 'STUDENT'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `username`, `password`, `email`, `full_name`, `role`) VALUES
(1, 'ahmad', 'ahmad123', 'admin@hepa.edu', 'Ahmad', 'HEPA'),
(2, 'ali', 'ali123', 'ali@advisor.edu', 'Ali', 'ADVISOR'),
(3, 'ibrahim', 'ibrahim123', 'ibrahim@advisor.edu', 'Ibrahim', 'ADVISOR'),
(4, 'abu', 'abu123', 'abu@chairperson.edu', 'Abu', 'CHAIRPERSON'),
(5, 'muhammad', 'muhammad123', 'muhammad@student.edu', 'Muhammad', 'STUDENT'),
(6, 'nuh', 'nuh123', 'nuh@student.edu', 'Nuh', 'STUDENT'),
(7, 'ismail', 'ismail123', 'ismail@student.edu', 'Ismail', 'STUDENT'),
(8, 'khalid', 'khalid123', 'khalid@chairperson.edu', 'Khalid', 'CHAIRPERSON'),
(9, 'aiman', 'aiman123', 'aiman@chairperson.edu', 'Aiman', 'CHAIRPERSON');

--
-- Dumping data for table `clubs`
--

INSERT INTO `clubs` (`club_id`, `club_name`, `description`, `advisor_id`, `chairperson_id`) VALUES
(1, 'Computer Science Club', 'All things computing, programming, and software engineering.', 2, 4),
(2, 'Robotics Club', 'Designing and programming automated robotic systems.', 2, 8),
(3, 'Music Club', 'Cultivating musical talent and organizing stage performances.', 3, 9);

--
-- Dumping data for table `events`
--

INSERT INTO `events` (`event_id`, `event_name`, `description`, `date`, `venue`, `quota`, `criteria`, `category`, `club_id`, `status`, `sdg_goals`) VALUES
(1, 'National Coding Hackathon', 'A 24-hour programming competition for students.', '2026-07-10', 'Main Hall B', 100, 'All IT Students', 'leadership', 1, 'APPROVED', 'SDG 4,SDG 8,SDG 9'),
(2, 'RoboTech Exhibition', 'Showcase of student-designed robotic creations.', '2026-08-15', 'Exhibition Center', 150, 'Open to Public', 'entrepreneurship', 2, 'APPROVED', 'SDG 9,SDG 11'),
(3, 'Acoustic Night', 'Live musical performances by student bands.', '2026-09-05', 'Auditorium 1', 200, 'General Admission', 'culture', 3, 'APPROVED', 'SDG 3,SDG 17');

--
-- Dumping data for table `attendances`
--

INSERT INTO `attendances` (`attendance_id`, `event_id`, `user_id`, `registration_date`, `status`, `verified_by`, `position`) VALUES
(1, 1, 5, '2026-06-16 10:00:00', 'ATTENDED', 1, 'AJK Kelab'),
(2, 1, 6, '2026-06-16 10:05:00', 'ATTENDED', 1, 'Ahli Kelab'),
(3, 2, 6, '2026-06-16 10:10:00', 'ATTENDED', 1, 'Presiden Kelab');

--
-- Dumping data for table `merits`
--

INSERT INTO `merits` (`merit_id`, `user_id`, `event_id`, `points`, `awarded_date`) VALUES
(1, 5, 1, 10, '2026-06-17 09:00:00'),
(2, 6, 1, 10, '2026-06-17 09:00:00'),
(3, 6, 2, 8, '2026-06-17 09:05:00');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `attendances`
--
ALTER TABLE `attendances`
  ADD PRIMARY KEY (`attendance_id`),
  ADD UNIQUE KEY `duplicate_registration` (`event_id`,`user_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `verified_by` (`verified_by`);

--
-- Indexes for table `clubs`
--
ALTER TABLE `clubs`
  ADD PRIMARY KEY (`club_id`),
  ADD KEY `advisor_id` (`advisor_id`),
  ADD KEY `chairperson_id` (`chairperson_id`);

--
-- Indexes for table `events`
--
ALTER TABLE `events`
  ADD PRIMARY KEY (`event_id`),
  ADD KEY `club_id` (`club_id`);

--
-- Indexes for table `merits`
--
ALTER TABLE `merits`
  ADD PRIMARY KEY (`merit_id`),
  ADD UNIQUE KEY `duplicate_merit` (`user_id`,`event_id`),
  ADD KEY `event_id` (`event_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `attendances`
--
ALTER TABLE `attendances`
  MODIFY `attendance_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `clubs`
--
ALTER TABLE `clubs`
  MODIFY `club_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `events`
--
ALTER TABLE `events`
  MODIFY `event_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `merits`
--
ALTER TABLE `merits`
  MODIFY `merit_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `attendances`
--
ALTER TABLE `attendances`
  ADD CONSTRAINT `attendances_ibfk_1` FOREIGN KEY (`event_id`) REFERENCES `events` (`event_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `attendances_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `attendances_ibfk_3` FOREIGN KEY (`verified_by`) REFERENCES `users` (`user_id`) ON DELETE SET NULL;

--
-- Constraints for table `clubs`
--
ALTER TABLE `clubs`
  ADD CONSTRAINT `clubs_ibfk_1` FOREIGN KEY (`advisor_id`) REFERENCES `users` (`user_id`) ON DELETE SET NULL,
  ADD CONSTRAINT `clubs_ibfk_2` FOREIGN KEY (`chairperson_id`) REFERENCES `users` (`user_id`) ON DELETE SET NULL;

--
-- Constraints for table `events`
--
ALTER TABLE `events`
  ADD CONSTRAINT `events_ibfk_1` FOREIGN KEY (`club_id`) REFERENCES `clubs` (`club_id`) ON DELETE CASCADE;

--
-- Constraints for table `merits`
--
ALTER TABLE `merits`
  ADD CONSTRAINT `merits_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `merits_ibfk_2` FOREIGN KEY (`event_id`) REFERENCES `events` (`event_id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
