-- phpMyAdmin SQL Dump
-- version 5.0.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 14, 2021 at 08:37 PM
-- Server version: 10.4.17-MariaDB
-- PHP Version: 8.0.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `wholesale`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `getCustByName` (IN `uname` VARCHAR(255))  SELECT * FROM customer where cust_name = uname$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `cart`
--

CREATE TABLE `cart` (
  `product_id` int(11) NOT NULL,
  `product_name` varchar(20) NOT NULL,
  `quantity` int(11) NOT NULL,
  `price` int(11) NOT NULL,
  `customer_id` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `category_id` int(11) NOT NULL,
  `category_name` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`category_id`, `category_name`) VALUES
(1, 'Beverages & Cakes'),
(2, 'Biscuits & Snacks'),
(3, 'Chips & Chocolates');

-- --------------------------------------------------------

--
-- Table structure for table `customer`
--

CREATE TABLE `customer` (
  `cust_id` varchar(20) NOT NULL,
  `cust_name` varchar(25) NOT NULL,
  `email_id` varchar(25) NOT NULL,
  `password` varchar(25) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `customer`
--

INSERT INTO `customer` (`cust_id`, `cust_name`, `email_id`, `password`) VALUES
('akshay', 'Akshay Bhat', 'akshayavbhat@gmail.com', 'akshay'),
('mugalkhod', 'shridhar mugalkhod', 'shree', 'shree'),
('nikhil', 'nikhil', 'nikkamath@gmail.com', 'nikhil'),
('Pratheek', 'Pratheek', 'pratheek@gmail.com', '1234'),
('praveen', 'Praveen YT', 'praveenyt@gmail.com', 'praveen'),
('saket', 'Saket Kumar', 'saketk@gmail.com', 'saket'),
('shivu', 'shivaprasad', 'shiva@gmail.com', 'shivu'),
('shrinidhi', 'Shrinidhi MK', 'shrinidhimk@gmail.com', 'shrinidhi'),
('swamy', 'swamy', 'swamydm@gmail.com', 'swamy');

-- --------------------------------------------------------

--
-- Table structure for table `depleted_products`
--

CREATE TABLE `depleted_products` (
  `product_id` int(11) DEFAULT NULL,
  `product_name` varchar(20) DEFAULT NULL,
  `quantity_left` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `depleted_products`
--

INSERT INTO `depleted_products` (`product_id`, `product_name`, `quantity_left`) VALUES
(19, 'Chocolate Cake ', 0),
(7, 'Oreo', -2);

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `product_id` int(11) NOT NULL,
  `product_name` varchar(20) DEFAULT NULL,
  `category_id` int(11) DEFAULT NULL,
  `price` int(11) NOT NULL,
  `quantity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`product_id`, `product_name`, `category_id`, `price`, `quantity`) VALUES
(1, 'Coke', 1, 40, 22),
(2, 'Sprite', 1, 35, 70),
(3, 'Cappuccino ', 1, 35, 49),
(4, 'Red Velvet Cupcake', 1, 50, 30),
(5, 'Pineapple Cake', 1, 350, 15),
(6, 'Hide N\' Seek', 2, 30, 62),
(7, 'Oreo', 2, 20, 97),
(8, 'Veg Puff', 2, 40, 22),
(9, 'Paneer Puff', 2, 40, 22),
(10, 'Bread ', 2, 40, 35),
(11, 'Kurkure', 3, 20, 94),
(12, 'Lays', 3, 20, 51),
(13, 'Mad Angles', 3, 10, 50),
(14, '5-Star', 3, 20, 40),
(15, 'Dairy Milk Silk', 3, 100, 50),
(24, 'Milkybar', 3, 10, 29),
(25, 'Eclairs', 3, 2, 20);

--
-- Triggers `products`
--
DELIMITER $$
CREATE TRIGGER `depleted` AFTER UPDATE ON `products` FOR EACH ROW BEGIN
IF(new.quantity<=old.quantity) THEN
if (new.product_id not in (select product_id from   depleted_products)) THEN
INSERT INTO depleted_products 				  VALUES(new.product_id,new.product_name,new.quantity-old.quantity);
ELSE
update depleted_products set quantity_left=new.quantity-old.quantity where product_id=new.product_id;
end if;
ELSE
delete from depleted_products where product_id=new.product_id;
END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `transaction`
--

CREATE TABLE `transaction` (
  `transaction_id` int(11) NOT NULL,
  `customer_id` varchar(20) DEFAULT NULL,
  `transaction_amount` int(11) DEFAULT NULL,
  `payment` varchar(20) DEFAULT NULL,
  `phone` varchar(10) DEFAULT NULL,
  `address` varchar(100) DEFAULT NULL,
  `date` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `transaction`
--

INSERT INTO `transaction` (`transaction_id`, `customer_id`, `transaction_amount`, `payment`, `phone`, `address`, `date`) VALUES
(2, 'Pratheek', 60, 'COD', '1', 'qwerty', '2021-01-07'),
(3, 'Pratheek', 350, 'online', '1', 'qwerty', '2021-01-08'),
(4, 'Pratheek', 140, 'Online', '1', 'qwerty', '2021-01-09'),
(5, 'Pratheek', 35, 'COD', '1', 'qwerty', '2021-01-09'),
(6, 'swamy', 50, 'COD', '1', 'qwerty', '2021-01-09'),
(7, 'Pratheek', 50, 'Online', '1', 'qwerty', '2021-01-09'),
(8, 'Pratheek', 40, 'Online', '1', 'qwerty', '2021-01-09'),
(9, 'Pratheek', 60, 'Online', '1', 'qwert', '2021-01-13'),
(10, 'Pratheek', 40, 'online', '1', 'qwerty', '2021-01-15');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `cart`
--
ALTER TABLE `cart`
  ADD KEY `customer_id` (`customer_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`category_id`);

--
-- Indexes for table `customer`
--
ALTER TABLE `customer`
  ADD PRIMARY KEY (`cust_id`),
  ADD UNIQUE KEY `email_id` (`email_id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`product_id`),
  ADD KEY `category_id` (`category_id`);

--
-- Indexes for table `transaction`
--
ALTER TABLE `transaction`
  ADD PRIMARY KEY (`transaction_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `product_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT for table `transaction`
--
ALTER TABLE `transaction`
  MODIFY `transaction_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `cart`
--
ALTER TABLE `cart`
  ADD CONSTRAINT `cart_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`cust_id`),
  ADD CONSTRAINT `cart_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`);

--
-- Constraints for table `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `products_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `categories` (`category_id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
