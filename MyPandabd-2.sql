-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Jun 23, 2025 at 04:20 AM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `MyPandabd`
--

-- --------------------------------------------------------

--
-- Table structure for table `MedioPago`
--

CREATE TABLE `MedioPago` (
  `id_MedioPago` int(11) NOT NULL,
  `tipoMedioPago` varchar(15) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `MedioPago`
--

INSERT INTO `MedioPago` (`id_MedioPago`, `tipoMedioPago`) VALUES
(1, 'Efectivo'),
(2, 'Transferencia'),
(3, 'TarjetaDebito'),
(4, 'TarjetaCredito');

-- --------------------------------------------------------

--
-- Table structure for table `Productos`
--

CREATE TABLE `Productos` (
  `id_producto` int(11) NOT NULL,
  `nombre_producto` varchar(20) DEFAULT NULL,
  `costo` int(11) DEFAULT NULL,
  `precio_venta` int(11) DEFAULT NULL,
  `stock` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `Productos`
--

INSERT INTO `Productos` (`id_producto`, `nombre_producto`, `costo`, `precio_venta`, `stock`) VALUES
(1, 'Cerveza Aguila', 2000, 4000, 58),
(2, 'Cerveza poker', 1800, 3800, 18),
(3, 'Aguardiente 1/2', 17500, 28000, 12),
(4, 'Ron 1/2', 19500, 32000, 11),
(6, 'Red bull', 5000, 8500, 26),
(7, 'Galletas', 1800, 2500, 13),
(8, 'speed max', 1600, 2500, 9);

-- --------------------------------------------------------

--
-- Table structure for table `Proveedores`
--

CREATE TABLE `Proveedores` (
  `id_proveedor` int(11) NOT NULL,
  `nombre` varchar(50) DEFAULT NULL,
  `contacto` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `Proveedores`
--

INSERT INTO `Proveedores` (`id_proveedor`, `nombre`, `contacto`) VALUES
(1, 'Distribuidora buenos aires', '3051234563'),
(2, 'FLA', '3097892345'),
(3, 'Cocacola', '3456783456'),
(4, 'Fritolay', '3325671234');

-- --------------------------------------------------------

--
-- Table structure for table `Usuarios`
--

CREATE TABLE `Usuarios` (
  `id_usuario` int(11) NOT NULL,
  `nombre` varchar(50) DEFAULT NULL,
  `usuario` varchar(10) DEFAULT NULL,
  `correo` varchar(60) DEFAULT NULL,
  `contrasena` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `Usuarios`
--

INSERT INTO `Usuarios` (`id_usuario`, `nombre`, `usuario`, `correo`, `contrasena`) VALUES
(15, 'Edinson', 'edinson', 'edinson@email.com', '$2a$10$DKGyQTpk3jyguUVF.UdGCOCUe3I1GAD3tb49ba0N.6FmzEzhm4Mpu'),
(16, 'Jhon Snow', 'user1', 'jhon@gmial.com', '$2a$10$iQBMU9CY3vw637QhjD0epOsUSiPPadMQUNVIvY7YYeWIFz6.YpG.a');

-- --------------------------------------------------------

--
-- Table structure for table `ventas`
--

CREATE TABLE `ventas` (
  `id_venta` int(11) NOT NULL,
  `id_producto` int(11) DEFAULT NULL,
  `cantidad` int(11) DEFAULT NULL,
  `precio_unitario` decimal(10,2) DEFAULT NULL,
  `id_mediopago` int(11) DEFAULT NULL,
  `fecha` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `ventas`
--

INSERT INTO `ventas` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`, `id_mediopago`, `fecha`) VALUES
(1, 2, 2, 7600.00, 1, '2025-06-03 05:00:00'),
(2, 2, 3, 3800.00, 1, '2025-06-10 07:45:01'),
(3, NULL, 2, 0.00, NULL, '2025-06-20 05:00:00'),
(4, 1, 2, 4000.00, 2, '2025-06-20 05:00:00'),
(5, 2, 2, 7600.00, 2, '2025-06-20 05:00:00'),
(6, 7, 2, 5000.00, 1, '2025-06-19 05:00:00'),
(7, 2, 2, 3800.00, 2, '2025-06-20 05:00:00'),
(8, 7, 2, 1800.00, 1, '2025-06-20 05:00:00'),
(9, 6, 4, 8500.00, 1, '2025-06-21 05:00:00'),
(10, 1, 2, 4000.00, 1, '2025-06-21 05:00:00'),
(11, 8, 3, 2500.00, 2, '2025-06-22 05:00:00'),
(12, 2, 3, 3800.00, 1, '2025-06-22 05:00:00'),
(13, 4, 1, 32000.00, 2, '2025-06-22 05:00:00'),
(14, 7, 3, 2500.00, 2, '2025-06-22 05:00:00');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `MedioPago`
--
ALTER TABLE `MedioPago`
  ADD PRIMARY KEY (`id_MedioPago`);

--
-- Indexes for table `Productos`
--
ALTER TABLE `Productos`
  ADD PRIMARY KEY (`id_producto`);

--
-- Indexes for table `Proveedores`
--
ALTER TABLE `Proveedores`
  ADD PRIMARY KEY (`id_proveedor`);

--
-- Indexes for table `Usuarios`
--
ALTER TABLE `Usuarios`
  ADD PRIMARY KEY (`id_usuario`);

--
-- Indexes for table `ventas`
--
ALTER TABLE `ventas`
  ADD PRIMARY KEY (`id_venta`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `MedioPago`
--
ALTER TABLE `MedioPago`
  MODIFY `id_MedioPago` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `Productos`
--
ALTER TABLE `Productos`
  MODIFY `id_producto` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `Proveedores`
--
ALTER TABLE `Proveedores`
  MODIFY `id_proveedor` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `Usuarios`
--
ALTER TABLE `Usuarios`
  MODIFY `id_usuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `ventas`
--
ALTER TABLE `ventas`
  MODIFY `id_venta` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
