-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost
-- Tiempo de generación: 05-02-2024 a las 13:49:32
-- Versión del servidor: 10.4.28-MariaDB
-- Versión de PHP: 8.0.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `Optica`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cliente`
--

CREATE TABLE `cliente` (
  `id_cliente` smallint(5) NOT NULL,
  `id_cliente_reco` smallint(5) NOT NULL,
  `nombre` varchar(45) DEFAULT NULL,
  `telefono` varchar(45) DEFAULT NULL,
  `direccion` varchar(45) DEFAULT NULL,
  `email` varchar(45) DEFAULT NULL,
  `fecha_registro` timestamp(6) NOT NULL DEFAULT current_timestamp(6)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `direccion`
--

CREATE TABLE `direccion` (
  `id_direccion` smallint(5) NOT NULL,
  `calle` varchar(45) NOT NULL,
  `numero` smallint(4) NOT NULL,
  `piso` tinyint(3) NOT NULL,
  `puerta` varchar(10) DEFAULT NULL,
  `ciudad` varchar(45) DEFAULT NULL,
  `CP` varchar(10) NOT NULL,
  `pais` varchar(45) DEFAULT NULL,
  `id_proveedor` smallint(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `gafas`
--

CREATE TABLE `gafas` (
  `id_producto` int(11) NOT NULL,
  `id_marca` smallint(5) NOT NULL,
  `graduacion_dcha` float NOT NULL,
  `graduacion_izq` float NOT NULL,
  `tipo_montura` enum('flotante','pasta','metalica') NOT NULL DEFAULT 'flotante',
  `color_montura` varchar(45) NOT NULL,
  `color_vidrio_d` varchar(45) NOT NULL,
  `color_vidrio_i` varchar(45) NOT NULL,
  `precio` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `marca`
--

CREATE TABLE `marca` (
  `id_marca` smallint(5) NOT NULL,
  `nombre` varchar(45) NOT NULL,
  `proveedor_Id` smallint(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Proveedor`
--

CREATE TABLE `Proveedor` (
  `id_Proveedor` smallint(5) NOT NULL,
  `id_direccion` smallint(5) NOT NULL,
  `nombre` varchar(45) NOT NULL,
  `teléfono` int(12) DEFAULT NULL,
  `fax` int(12) DEFAULT NULL,
  `NIF` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ticket_venta`
--

CREATE TABLE `ticket_venta` (
  `id_ticket` smallint(5) NOT NULL,
  `id_producto` int(11) NOT NULL,
  `id_empleado` smallint(5) NOT NULL,
  `id_cliente` smallint(5) NOT NULL,
  `fecha_ticket` timestamp NULL DEFAULT current_timestamp(),
  `importe` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `vendedor`
--

CREATE TABLE `vendedor` (
  `id_vendedor` smallint(5) NOT NULL,
  `nombre` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `cliente`
--
ALTER TABLE `cliente`
  ADD PRIMARY KEY (`id_cliente`),
  ADD KEY `id_cliente_reco` (`id_cliente_reco`);

--
-- Indices de la tabla `direccion`
--
ALTER TABLE `direccion`
  ADD PRIMARY KEY (`id_direccion`),
  ADD KEY `id_proveedor_idx` (`id_proveedor`);

--
-- Indices de la tabla `gafas`
--
ALTER TABLE `gafas`
  ADD PRIMARY KEY (`id_producto`),
  ADD UNIQUE KEY `id_marca_UNIQUE` (`id_marca`),
  ADD KEY `id_marca_idx` (`id_marca`);

--
-- Indices de la tabla `marca`
--
ALTER TABLE `marca`
  ADD PRIMARY KEY (`id_marca`),
  ADD KEY `id_proveedor_idx` (`proveedor_Id`);

--
-- Indices de la tabla `Proveedor`
--
ALTER TABLE `Proveedor`
  ADD PRIMARY KEY (`id_Proveedor`),
  ADD KEY `id_direccion_idx` (`id_direccion`);

--
-- Indices de la tabla `ticket_venta`
--
ALTER TABLE `ticket_venta`
  ADD PRIMARY KEY (`id_ticket`),
  ADD KEY `id_producto_idx` (`id_producto`),
  ADD KEY `id_empleado_idx` (`id_empleado`),
  ADD KEY `id_cliente_idx` (`id_cliente`);

--
-- Indices de la tabla `vendedor`
--
ALTER TABLE `vendedor`
  ADD PRIMARY KEY (`id_vendedor`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `marca`
--
ALTER TABLE `marca`
  MODIFY `id_marca` smallint(5) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `Proveedor`
--
ALTER TABLE `Proveedor`
  MODIFY `id_Proveedor` smallint(5) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `ticket_venta`
--
ALTER TABLE `ticket_venta`
  MODIFY `id_ticket` smallint(5) NOT NULL AUTO_INCREMENT;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `cliente`
--
ALTER TABLE `cliente`
  ADD CONSTRAINT `id_cliente_reco` FOREIGN KEY (`id_cliente_reco`) REFERENCES `cliente` (`id_cliente`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `gafas`
--
ALTER TABLE `gafas`
  ADD CONSTRAINT `id_marca` FOREIGN KEY (`id_marca`) REFERENCES `marca` (`id_marca`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `marca`
--
ALTER TABLE `marca`
  ADD CONSTRAINT `id_proveedor` FOREIGN KEY (`proveedor_Id`) REFERENCES `Proveedor` (`id_Proveedor`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `Proveedor`
--
ALTER TABLE `Proveedor`
  ADD CONSTRAINT `id_dir` FOREIGN KEY (`id_direccion`) REFERENCES `direccion` (`id_direccion`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `ticket_venta`
--
ALTER TABLE `ticket_venta`
  ADD CONSTRAINT `id_cliente` FOREIGN KEY (`id_cliente`) REFERENCES `cliente` (`id_cliente`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `id_empleado` FOREIGN KEY (`id_empleado`) REFERENCES `vendedor` (`id_vendedor`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `id_producto` FOREIGN KEY (`id_producto`) REFERENCES `gafas` (`id_producto`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
