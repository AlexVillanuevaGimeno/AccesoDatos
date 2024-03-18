-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 18-03-2024 a las 18:06:05
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `examen`
--
CREATE DATABASE IF NOT EXISTS `examen` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `examen`;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cliente`
--

CREATE TABLE `cliente` (
  `id_cliente` int(3) NOT NULL,
  `dni` varchar(9) DEFAULT NULL,
  `nombre` varchar(50) DEFAULT NULL,
  `direccion` varchar(100) DEFAULT NULL,
  `telefono` int(9) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `cliente`
--

INSERT INTO `cliente` (`id_cliente`, `dni`, `nombre`, `direccion`, `telefono`) VALUES
(1, '78596656L', 'Isra', 'Calle 1', 602548596),
(2, '12345678X', 'María', 'Avenida 2', 604123456),
(3, '98765432Y', 'Juan', 'Calle 3', 606789012);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `compra`
--

CREATE TABLE `compra` (
  `id_compra` int(3) NOT NULL,
  `fecha_compra` date DEFAULT NULL,
  `agrupada` tinyint(1) DEFAULT NULL,
  `id_cliente` int(3) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `compra`
--

INSERT INTO `compra` (`id_compra`, `fecha_compra`, `agrupada`, `id_cliente`) VALUES
(1, '2024-03-16', 1, 1),
(2, '2024-03-16', 1, 2),
(3, '2024-03-16', 0, 3),
(4, '2024-03-16', 1, 1),
(5, '2024-03-16', 0, 2),
(6, '2024-03-16', 1, 3);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalles_compra`
--

CREATE TABLE `detalles_compra` (
  `id_detalles_compra` int(3) NOT NULL,
  `id_compra` int(3) DEFAULT NULL,
  `id_producto` int(3) DEFAULT NULL,
  `cantidad` int(5) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `detalles_compra`
--

INSERT INTO `detalles_compra` (`id_detalles_compra`, `id_compra`, `id_producto`, `cantidad`) VALUES
(1, 1, 1, 3),
(2, 1, 2, 2),
(3, 2, 3, 1),
(4, 3, 1, 4);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalles_envio`
--

CREATE TABLE `detalles_envio` (
  `id_detalles_envio` int(3) NOT NULL,
  `id_producto` int(3) DEFAULT NULL,
  `id_envio` int(3) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `detalles_envio`
--

INSERT INTO `detalles_envio` (`id_detalles_envio`, `id_producto`, `id_envio`) VALUES
(1, NULL, 1),
(2, NULL, 2),
(3, NULL, 3);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `envío`
--

CREATE TABLE `envío` (
  `id_envio` int(3) NOT NULL,
  `fecha_envio` date DEFAULT NULL,
  `direccion` varchar(100) DEFAULT NULL,
  `id_cliente` int(3) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `envío`
--

INSERT INTO `envío` (`id_envio`, `fecha_envio`, `direccion`, `id_cliente`) VALUES
(1, '2024-03-16', 'Calle del cliente 1', 1),
(2, '2024-03-16', 'Avenida del cliente 2', 2),
(3, '2024-03-16', 'Calle del cliente 3', 3),
(4, '2024-03-16', 'Calle del cliente 1', 1),
(5, '2024-03-16', 'Avenida del cliente 2', 2),
(6, '2024-03-16', 'Calle del cliente 3', 3);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `producto`
--

CREATE TABLE `producto` (
  `id_producto` int(3) NOT NULL,
  `nombre` varchar(50) DEFAULT NULL,
  `descripcion` varchar(100) DEFAULT NULL,
  `precio` float DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `producto`
--

INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`) VALUES
(1, 'Coche', 'Coche de juguete', 10.4),
(2, 'Muñeca', 'Muñeca de porcelana', 15.99),
(3, 'Pelota', 'Pelota de fútbol', 5.75),
(4, 'Rompecabezas', 'Rompecabezas de 1000 piezas', 20.5),
(5, 'Libro', 'Novela de ciencia ficción', 12.25),
(6, 'Bloques', 'Set de bloques de construcción', 8.99),
(7, 'Tren de juguete', 'Tren eléctrico con vías', 29.99),
(8, 'Peluche', 'Peluche de oso de color marrón', 9.5),
(9, 'Ajedrez', 'Tablero de ajedrez de madera', 18.75),
(10, 'Bicicleta', 'Bicicleta para niños', 79.99),
(11, 'Globo terráqueo', 'Globo terráqueo con base giratoria', 24.99);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `cliente`
--
ALTER TABLE `cliente`
  ADD PRIMARY KEY (`id_cliente`),
  ADD UNIQUE KEY `dni` (`dni`);

--
-- Indices de la tabla `compra`
--
ALTER TABLE `compra`
  ADD PRIMARY KEY (`id_compra`),
  ADD KEY `id_cliente` (`id_cliente`);

--
-- Indices de la tabla `detalles_compra`
--
ALTER TABLE `detalles_compra`
  ADD PRIMARY KEY (`id_detalles_compra`),
  ADD KEY `id_producto` (`id_producto`),
  ADD KEY `id_compra` (`id_compra`);

--
-- Indices de la tabla `detalles_envio`
--
ALTER TABLE `detalles_envio`
  ADD PRIMARY KEY (`id_detalles_envio`),
  ADD KEY `id_envio` (`id_envio`),
  ADD KEY `fk_detalles_envio_producto` (`id_producto`);

--
-- Indices de la tabla `envío`
--
ALTER TABLE `envío`
  ADD PRIMARY KEY (`id_envio`),
  ADD KEY `fk_envio_cliente` (`id_cliente`);

--
-- Indices de la tabla `producto`
--
ALTER TABLE `producto`
  ADD PRIMARY KEY (`id_producto`);

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `compra`
--
ALTER TABLE `compra`
  ADD CONSTRAINT `compra_ibfk_1` FOREIGN KEY (`id_cliente`) REFERENCES `cliente` (`id_cliente`);

--
-- Filtros para la tabla `detalles_compra`
--
ALTER TABLE `detalles_compra`
  ADD CONSTRAINT `detalles_compra_ibfk_1` FOREIGN KEY (`id_producto`) REFERENCES `producto` (`id_producto`),
  ADD CONSTRAINT `detalles_compra_ibfk_2` FOREIGN KEY (`id_compra`) REFERENCES `compra` (`id_compra`);

--
-- Filtros para la tabla `detalles_envio`
--
ALTER TABLE `detalles_envio`
  ADD CONSTRAINT `detalles_envio_ibfk_1` FOREIGN KEY (`id_envio`) REFERENCES `envío` (`id_envio`),
  ADD CONSTRAINT `fk_detalles_envio_producto` FOREIGN KEY (`id_producto`) REFERENCES `producto` (`id_producto`);

--
-- Filtros para la tabla `envío`
--
ALTER TABLE `envío`
  ADD CONSTRAINT `fk_envio_cliente` FOREIGN KEY (`id_cliente`) REFERENCES `cliente` (`id_cliente`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
