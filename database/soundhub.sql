-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Máy chủ: 127.0.0.1
-- Thời gian đã tạo: Th8 18, 2025 lúc 01:36 AM
-- Phiên bản máy phục vụ: 10.4.27-MariaDB
-- Phiên bản PHP: 7.4.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Cơ sở dữ liệu: `soundhub`
--

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `cart_items`
--

CREATE TABLE `cart_items` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL DEFAULT 1,
  `added_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `categories`
--

CREATE TABLE `categories` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `categories`
--

INSERT INTO `categories` (`id`, `name`) VALUES
(1, 'Tai nghe Bluetooth'),
(2, 'Tai nghe có dây'),
(3, 'Loa Bluetooth');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `orders`
--

CREATE TABLE `orders` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `total_amount` decimal(10,2) DEFAULT NULL,
  `shipping_fee` decimal(10,2) DEFAULT NULL,
  `payment_method` varchar(50) DEFAULT NULL,
  `status` varchar(20) DEFAULT 'pending',
  `shipping_address` text DEFAULT NULL,
  `phone` varchar(15) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `order_items`
--

CREATE TABLE `order_items` (
  `id` int(11) NOT NULL,
  `order_id` int(11) DEFAULT NULL,
  `product_id` int(11) DEFAULT NULL,
  `quantity` int(11) DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `products`
--

CREATE TABLE `products` (
  `id` int(11) NOT NULL,
  `name` varchar(200) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `image` varchar(255) DEFAULT NULL,
  `category_id` int(11) DEFAULT NULL,
  `status` tinyint(4) DEFAULT 1,
  `quantity` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `products`
--

INSERT INTO `products` (`id`, `name`, `price`, `image`, `category_id`, `status`, `quantity`) VALUES
(1, 'JBL Charge 6', '3990000.00', 'loa-bluetooth-jbl-charge-6.jpg', 1, 0, 20),
(2, 'JBL Flip 7', '2490000.00', 'loa-bluetooth-jbl-flip-7.jpg', 3, 1, 30),
(3, 'JBL PartyBox Encore 2Mic', '8990000.00', 'loa-bluetooth-jbl-partybox-encore-2mic.jpg', 3, 1, 10),
(4, 'Marshall Middleton II', '12990000.00', 'loa-bluetooth-marshall-middleton-ii.jpg', 3, 1, 8),
(5, 'Alpha Works Sonik 120', '1990000.00', 'loa-bluetooth-party-alpha-works-sonik-120.jpg', 3, 1, 15),
(6, 'Rezo MagSound', '890000.00', 'loa-bluetooth-rezo-magsound.jpg', 3, 1, 25),
(7, 'Xiaomi Sound Party', '1490000.00', 'loa-bluetooth-xiaomi-sound-party.jpg', 3, 1, 18),
(8, 'Xiaomi Sound Pocket', '590000.00', 'loa-bluetooth-xiaomi-sound-pocket.jpg', 3, 1, 35),
(9, 'Samsung IA500', '450000.00', 'nhet-tai-samsung-ia500-den.jpg', 2, 1, 50),
(10, 'Apple MTjy3', '1290000.00', 'tai-nghe-co-day-apple-mtjy3.jpg', 2, 1, 25),
(11, 'AVA PC-25', '150000.00', 'tai-nghe-co-day-ava-pc-25.jpg', 2, 1, 120),
(12, 'Baseus Encok HZ20', '250000.00', 'tai-nghe-co-day-ep-baseus-encok-hz20.jpg', 2, 1, 75),
(13, 'JBL C200SI', '290000.00', 'tai-nghe-co-day-jbl-c200-siu.jpg', 2, 1, 60),
(14, 'AVA LiveBass E4', '190000.00', 'tai-nghe-day-ep-type-c-ava-livebass-e4.jpg', 2, 1, 90),
(15, 'Apple EarPods Lightning', '690000.00', 'tai-nghe-earpods-cong-lightning-apple-mmtn2.jpg', 2, 1, 40),
(16, 'OPPO MH135', '190000.00', 'tai-nghe-ep-oppo-mh135.jpg', 2, 1, 100),
(17, 'Sony MDR-EX15AP', '350000.00', 'tai-nghe-ep-sony-mdr-ex15aplize.jpg', 2, 1, 80),
(18, 'AVA LiveBass E2', '150000.00', 'tai-nghe-ep-type-c-ava-livebass-e2.jpg', 2, 1, 110),
(19, 'AVA Buds Life Air 2 Pro', '790000.00', 'tai-nghe-bluetooth-true-wireless-ava-buds-life-air-2-pro.jpg', 1, 1, 35),
(20, 'AVA FreeGo PT52', '390000.00', 'tai-nghe-bluetooth-true-wireless-ava-freego-pt52.jpg', 1, 1, 70),
(21, 'AVA FreeGo W28', '290000.00', 'tai-nghe-bluetooth-true-wireless-ava-freego-w28.jpg', 1, 1, 90),
(22, 'Baseus Bass BP1 Pro', '690000.00', 'tai-nghe-bluetooth-true-wireless-baseus-bass-bp1-pro-pm132.jpg', 1, 1, 55),
(23, 'Havit TW943 Pro', '590000.00', 'tai-nghe-bluetooth-true-wireless-havit-tw943-pro.jpg', 1, 1, 40),
(24, 'Marshall Minor IV', '3290000.00', 'tai-nghe-bluetooth-true-wireless-marshall-minor-iv.jpg', 1, 1, 30),
(25, 'OPPO Enco Buds 3 Pro', '1990000.00', 'tai-nghe-bluetooth-true-wireless-oppo-enco-buds-3-pro-etek1.jpg', 1, 1, 75),
(26, 'Realme Buds T200 Lite', '390000.00', 'tai-nghe-bluetooth-true-wireless-realme-buds-t200-lite.jpg', 1, 1, 85),
(27, 'Rezo K50', '490000.00', 'tai-nghe-bluetooth-true-wireless-rezo-k50.jpg', 1, 1, 65),
(28, 'Samsung Galaxy Buds 3 Pro', '4990000.00', 'tai-nghe-bluetooth-true-wireless-samsung-galaxy-buds-3-pro-r630n.jpg', 1, 1, 50),
(29, 'Xiaomi Redmi Buds 6 Play', '590000.00', 'tai-nghe-bluetooth-true-wireless-xiaomi-redmi-buds-6-play.jpg', 1, 1, 100),
(30, 'Xiaomi Redmi Buds 6 Active', '490000.00', 'tai-nghe-bluetooth-tws-xiaomi-redmi-buds-6-active.jpg', 1, 1, 80),
(31, 'JBL Wave Beam 2', '1290000.00', 'tai-nghe-tws-jbl-wave-beam-2.jpg', 1, 1, 45),
(32, 'Xiaomi Redmi Buds 6', '890000.00', 'tai-nghe-tws-xiaomi-redmi-buds-6.jpg', 1, 1, 60),
(34, 'Loa Audioengine A5+', '15500000.00', '1755472864198.jpg', 3, 1, 3);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `phone` varchar(15) DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `role` varchar(20) DEFAULT 'user'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `phone`, `password`, `role`) VALUES
(1, 'Administrator', 'admin@gmail.com', '0909123456', 'Admin123', 'admin'),
(2, 'Nguyễn Văn Minh Nhật', 'mnhat@gmail.com', '0352975249', 'Mnhat123', 'user'),
(3, 'Hồ Nguyễn Huyền Trang', 'htrang@gmail.com', '0376615441', 'Htrang123', 'user');

--
-- Chỉ mục cho các bảng đã đổ
--

--
-- Chỉ mục cho bảng `cart_items`
--
ALTER TABLE `cart_items`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_cart` (`user_id`,`product_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Chỉ mục cho bảng `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `order_items`
--
ALTER TABLE `order_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `order_id` (`order_id`);

--
-- Chỉ mục cho bảng `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`),
  ADD KEY `category_id` (`category_id`);

--
-- Chỉ mục cho bảng `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT cho các bảng đã đổ
--

--
-- AUTO_INCREMENT cho bảng `cart_items`
--
ALTER TABLE `cart_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT cho bảng `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT cho bảng `orders`
--
ALTER TABLE `orders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `order_items`
--
ALTER TABLE `order_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `products`
--
ALTER TABLE `products`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;

--
-- AUTO_INCREMENT cho bảng `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Các ràng buộc cho các bảng đã đổ
--

--
-- Các ràng buộc cho bảng `cart_items`
--
ALTER TABLE `cart_items`
  ADD CONSTRAINT `cart_items_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `cart_items_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE;

--
-- Các ràng buộc cho bảng `order_items`
--
ALTER TABLE `order_items`
  ADD CONSTRAINT `order_items_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`);

--
-- Các ràng buộc cho bảng `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `products_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
