-- phpMyAdmin SQL Dump
-- version 4.9.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 15, 2022 at 08:22 AM
-- Server version: 10.4.11-MariaDB
-- PHP Version: 7.2.26

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `dairy`
--

-- --------------------------------------------------------

--
-- Table structure for table `delivery`
--

CREATE TABLE `delivery` (
  `id` int(11) NOT NULL,
  `r_f_no` varchar(50) NOT NULL,
  `r_kg` float NOT NULL,
  `r_dt` timestamp NOT NULL DEFAULT current_timestamp(),
  `r_received_by` varchar(50) NOT NULL,
  `r_deliverer` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `delivery`
--

INSERT INTO `delivery` (`id`, `r_f_no`, `r_kg`, `r_dt`, `r_received_by`, `r_deliverer`) VALUES
(1, '1', 4, '2021-11-16 20:56:52', '', 'Moni'),
(3, '1', 10, '2021-11-16 22:42:27', '', 'Moni2'),
(4, '1', 3, '2022-01-15 06:43:16', '', 'Moni');

-- --------------------------------------------------------

--
-- Table structure for table `employees`
--

CREATE TABLE `employees` (
  `id` int(11) NOT NULL,
  `e_name` varchar(50) NOT NULL,
  `e_mail` varchar(50) DEFAULT NULL,
  `username` varchar(50) NOT NULL,
  `e_pass` varchar(50) NOT NULL,
  `e_role` varchar(50) DEFAULT NULL,
  `e_payroll_no` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `employees`
--

INSERT INTO `employees` (`id`, `e_name`, `e_mail`, `username`, `e_pass`, `e_role`, `e_payroll_no`) VALUES
(1, 'admin', 'admin@gmail.com', 'admin', '21232f297a57a5a743894a0e4a801fc3', 'Manager', '1'),
(2, 'Peter Langat', 'Peterlangat@gmail.com', '', 'a5ce850ce12866b397023a2ef3641699', 'Clerk', '2');

-- --------------------------------------------------------

--
-- Table structure for table `farmers`
--

CREATE TABLE `farmers` (
  `f_no` varchar(50) NOT NULL,
  `f_id` text NOT NULL,
  `f_name` varchar(50) NOT NULL,
  `f_locallity` varchar(50) DEFAULT NULL,
  `f_ac` varchar(50) DEFAULT NULL,
  `last_paid` date DEFAULT NULL,
  `f_phone` varchar(20) DEFAULT NULL,
  `f_photo` blob DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `farmers`
--

INSERT INTO `farmers` (`f_no`, `f_id`, `f_name`, `f_locallity`, `f_ac`, `last_paid`, `f_phone`, `f_photo`) VALUES
('1', '37230559', 'KIPRONO DAVIES', 'Kapkisiara', '12373635273', '2022-01-15', '+254745682815', NULL),
('2', '37236646', 'FIDEL MUENI', 'Chesamisiet', '1236478474', '2022-01-15', '+254745682819', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `payment`
--

CREATE TABLE `payment` (
  `id` int(11) NOT NULL,
  `p_to` varchar(50) NOT NULL,
  `p_date` date NOT NULL,
  `p_ac` bigint(20) NOT NULL,
  `p_method` varchar(30) DEFAULT NULL,
  `p_transaction_code` int(11) DEFAULT NULL COMMENT 'Bank or Mpesa confirmation or receipt no',
  `p_transacted_by` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `settings_rates`
--

CREATE TABLE `settings_rates` (
  `id` int(11) NOT NULL,
  `from` date NOT NULL,
  `to` date NOT NULL,
  `rate` float NOT NULL COMMENT 'sh per kg'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `settings_rates`
--

INSERT INTO `settings_rates` (`id`, `from`, `to`, `rate`) VALUES
(4, '2022-01-01', '2022-02-28', 20);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `delivery`
--
ALTER TABLE `delivery`
  ADD PRIMARY KEY (`id`),
  ADD KEY `r_f_no` (`r_f_no`),
  ADD KEY `r_received_by` (`r_received_by`);

--
-- Indexes for table `employees`
--
ALTER TABLE `employees`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `e_name` (`e_name`),
  ADD UNIQUE KEY `e_payroll_no_2` (`e_payroll_no`),
  ADD KEY `e_payroll_no` (`e_payroll_no`);

--
-- Indexes for table `farmers`
--
ALTER TABLE `farmers`
  ADD PRIMARY KEY (`f_no`),
  ADD KEY `f_no` (`f_no`);

--
-- Indexes for table `payment`
--
ALTER TABLE `payment`
  ADD PRIMARY KEY (`id`),
  ADD KEY `p_to` (`p_to`),
  ADD KEY `p_transacted_by` (`p_transacted_by`);

--
-- Indexes for table `settings_rates`
--
ALTER TABLE `settings_rates`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `delivery`
--
ALTER TABLE `delivery`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `employees`
--
ALTER TABLE `employees`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `payment`
--
ALTER TABLE `payment`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `settings_rates`
--
ALTER TABLE `settings_rates`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `delivery`
--
ALTER TABLE `delivery`
  ADD CONSTRAINT `delivery_ibfk_2` FOREIGN KEY (`r_f_no`) REFERENCES `farmers` (`f_no`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `payment`
--
ALTER TABLE `payment`
  ADD CONSTRAINT `payment_ibfk_1` FOREIGN KEY (`p_transacted_by`) REFERENCES `employees` (`e_payroll_no`) ON UPDATE CASCADE,
  ADD CONSTRAINT `payment_ibfk_2` FOREIGN KEY (`p_to`) REFERENCES `farmers` (`f_no`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
