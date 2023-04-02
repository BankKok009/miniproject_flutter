-- phpMyAdmin SQL Dump
-- version 5.0.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 02, 2023 at 10:35 AM
-- Server version: 10.4.17-MariaDB
-- PHP Version: 7.3.27

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db_miniproject_moblie`
--

-- --------------------------------------------------------

--
-- Table structure for table `product`
--

CREATE TABLE `product` (
  `id` int(11) NOT NULL,
  `idSeller` text COLLATE utf8_unicode_ci NOT NULL,
  `nameSeller` text COLLATE utf8_unicode_ci NOT NULL,
  `name` text COLLATE utf8_unicode_ci NOT NULL,
  `price` text COLLATE utf8_unicode_ci NOT NULL,
  `detail` text COLLATE utf8_unicode_ci NOT NULL,
  `images` text COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `product`
--

INSERT INTO `product` (`id`, `idSeller`, `nameSeller`, `name`, `price`, `detail`, `images`) VALUES
(2, '1', 'Shop A', 'Core i7', '12000', 'Core i7 The Best of years.', '[/product/product586239.jpg, /product/product709063.jpg, /product/product142186.jpg, /product/product559707.jpg]'),
(3, '1', 'Shop A', 'GTX 1650', '8900', 'GTX 1650 The Best for gamer for now\n', '[/product/product874000.jpg, /product/product297932.jpg, /product/product5979.jpg, /product/product917329.jpg]'),
(4, '4', 'Shop C', 'GTX2060', '14000', 'New GPU in Years so hot', '[/product/product326398.jpg, /product/product47185.jpg, /product/product912989.jpg, /product/product191112.jpg]');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `name` text COLLATE utf32_unicode_ci NOT NULL,
  `type` text COLLATE utf32_unicode_ci NOT NULL,
  `address` text COLLATE utf32_unicode_ci NOT NULL,
  `phone` text COLLATE utf32_unicode_ci NOT NULL,
  `user` text COLLATE utf32_unicode_ci NOT NULL,
  `password` text COLLATE utf32_unicode_ci NOT NULL,
  `avatar` text COLLATE utf32_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf32 COLLATE=utf32_unicode_ci;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id`, `name`, `type`, `address`, `phone`, `user`, `password`, `avatar`) VALUES
(1, 'Shop A', 'seller', 'AAAHome', '1111111111', 'A', '1234', '/miniprojectmoblie/avatar/edit32avatar61125.jpg'),
(3, 'BuyID', 'buyer', 'BuyHome', '2222222222', 'B', '1234', '/miniprojectmoblie/avatar/avatar2618.jpg'),
(4, 'Shop C', 'seller', 'Shop address', '3333333333', 'C', '1234', '/miniprojectmoblie/avatar/avatar30980.jpg'),
(5, 'shop D', 'seller', 'shop address', '3333333333', 'D', '1234', '/miniprojectmoblie/avatar/avatar5427.jpg');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `product`
--
ALTER TABLE `product`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `product`
--
ALTER TABLE `product`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
