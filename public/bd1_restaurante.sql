-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 07-05-2025 a las 04:25:57
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
-- Base de datos: `bd1_restaurante`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categorias_prod`
--

CREATE TABLE `categorias_prod` (
  `ID_CATEGORIA` varchar(10) NOT NULL,
  `NOMBRE_CATEGORIA` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `categorias_prod`
--

INSERT INTO `categorias_prod` (`ID_CATEGORIA`, `NOMBRE_CATEGORIA`) VALUES
('cat-01', 'Entradas'),
('cat-02', 'Platos fuertes'),
('cat-04', 'Postres');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_pedido`
--

CREATE TABLE `detalle_pedido` (
  `ID_DETALLE_PEDIDO` varchar(20) NOT NULL,
  `FK_ID_PRODUCTO` varchar(10) NOT NULL,
  `CANTIDAD` int(11) NOT NULL,
  `SUBTOTAL` decimal(8,0) NOT NULL,
  `FK_ID_PEDIDO` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `detalle_pedido`
--

INSERT INTO `detalle_pedido` (`ID_DETALLE_PEDIDO`, `FK_ID_PRODUCTO`, `CANTIDAD`, `SUBTOTAL`, `FK_ID_PEDIDO`) VALUES
('grupo-1746291103-0', 'prod-001', 3, 90000, 'ped-1746291103'),
('grupo-1746291552-0', 'prod-21', 3, 135000, 'ped-1746291552'),
('grupo-1746291884-0', 'prod-001', 1, 30000, 'ped-1746291884'),
('grupo-1746291884-1', 'prod-21', 1, 45000, 'ped-1746291884'),
('grupo-1746291973-0', 'prod-001', 1, 30000, 'ped-1746291973'),
('grupo-1746291973-1', 'prod-21', 1, 45000, 'ped-1746291973'),
('grupo-1746292615-0', 'prod-21', 3, 135000, 'ped-1746292615'),
('grupo-1746292646-0', 'prod-009', 3, 44700, 'ped-1746292646'),
('grupo-1746292646-1', 'prod-001', 1, 30000, 'ped-1746292646'),
('grupo-1746301635-0', 'prod-21', 2, 90000, 'ped-1746301635'),
('grupo-1746301635-1', 'prod-009', 3, 44700, 'ped-1746301635'),
('grupo-1746301830-0', 'prod-009', 1, 14900, 'ped-1746301830'),
('grupo-1746301889-0', 'prod-21', 1, 45000, 'ped-1746301889'),
('grupo-1746306702-0', 'prod-001', 3, 90000, 'ped-1746306702'),
('grupo-1746307033-0', 'prod-001', 3, 90000, 'ped-1746307033'),
('grupo-1746335123-0', 'prod-001', 3, 60000, 'ped-1746335123'),
('grupo-1746335918-0', 'prod-008', 3, 25500, 'ped-1746335918'),
('grupo-1746335918-1', 'prod-007', 3, 44700, 'ped-1746335918'),
('grupo-1746336025-0', 'prod-003', 2, 65000, 'ped-1746336024'),
('grupo-1746336025-1', 'prod-008', 2, 17000, 'ped-1746336024'),
('grupo-1746336025-2', 'prod-005', 2, 70600, 'ped-1746336024'),
('grupo-1746399637-0', 'prod-002', 3, 30000, 'ped-1746399637'),
('grupo-1746399637-1', 'prod-003', 1, 32500, 'ped-1746399637'),
('grupo-1746401723-0', 'prod-002', 3, 30000, 'ped-1746401723'),
('grupo-1746408628-0', 'prod-004', 3, 104400, 'ped-1746408628'),
('grupo-1746408628-1', 'prod-007', 1, 14900, 'ped-1746408628'),
('grupo-1746410665-0', 'prod-002', 1, 10000, 'ped-1746410665'),
('grupo-1746549765-0', 'prod-003', 6, 195000, 'ped-1746549765'),
('grupo-1746563234-0', 'prod-004', 3, 104400, 'ped-1746563234'),
('grupo-1746581962-0', 'prod-002', 3, 30000, 'ped-1746581962');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pedido`
--

CREATE TABLE `pedido` (
  `ID_PEDIDO` varchar(20) NOT NULL,
  `FECHA_PEDIDO` datetime NOT NULL,
  `TOTAL_PEDIDO` int(11) NOT NULL,
  `PREFERENCIAS_PEDIDO` text DEFAULT NULL,
  `METODO_PAGO` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `pedido`
--

INSERT INTO `pedido` (`ID_PEDIDO`, `FECHA_PEDIDO`, `TOTAL_PEDIDO`, `PREFERENCIAS_PEDIDO`, `METODO_PAGO`) VALUES
('ped-1746291103', '2025-05-03 11:51:43', 90000, '', 'Tarjeta'),
('ped-1746291552', '2025-05-03 11:59:12', 135000, '', 'Nu'),
('ped-1746291884', '2025-05-03 12:04:44', 75000, '', 'Nu'),
('ped-1746291973', '2025-05-03 12:06:13', 75000, '', 'Nu'),
('ped-1746292615', '2025-05-03 12:16:55', 135000, 'hhhhhhh', 'Tarjeta'),
('ped-1746292646', '2025-05-03 12:17:26', 74700, '', 'Nu'),
('ped-1746301635', '2025-05-03 14:47:15', 134700, '', 'Tarjeta'),
('ped-1746301830', '2025-05-03 14:50:30', 14900, '', 'Nu'),
('ped-1746301889', '2025-05-03 14:51:29', 45000, '', 'Efectivo'),
('ped-1746306702', '2025-05-03 16:11:42', 90000, 'Bbbbbb', 'Efectivo'),
('ped-1746307033', '2025-05-03 16:17:13', 90000, 'Aaaaaaaaa', 'Nu'),
('ped-1746335123', '2025-05-04 00:05:23', 60000, '', 'Nu'),
('ped-1746335918', '2025-05-04 00:18:38', 70200, '', 'Efectivo'),
('ped-1746336024', '2025-05-04 00:20:24', 152600, '', 'Tarjeta'),
('ped-1746399637', '2025-05-04 18:00:37', 62500, '', 'Tarjeta'),
('ped-1746401723', '2025-05-04 18:35:23', 30000, 'sin vegetales', 'Tarjeta'),
('ped-1746408628', '2025-05-04 20:30:28', 119300, '', 'Efectivo'),
('ped-1746410665', '2025-05-04 21:04:25', 10000, '', 'Efectivo'),
('ped-1746549765', '2025-05-06 11:42:45', 195000, '', 'Tarjeta'),
('ped-1746563234', '2025-05-06 15:27:14', 104400, 'aaaaaaaa', 'Efectivo'),
('ped-1746581962', '2025-05-06 20:39:22', 30000, '', 'Efectivo');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `productos`
--

CREATE TABLE `productos` (
  `ID_PRODUCTO` varchar(10) NOT NULL,
  `NOMBRE_PRODUCTO` varchar(50) NOT NULL,
  `DESCRIPCION_PRODUCTO` text NOT NULL,
  `PRECIO` decimal(8,0) NOT NULL,
  `FK_ID_CATEGORIA` varchar(10) DEFAULT NULL,
  `DESCUENTO_PRODUCTO` decimal(8,0) NOT NULL DEFAULT 0,
  `URL_IMG_PRODUCTO` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `productos`
--

INSERT INTO `productos` (`ID_PRODUCTO`, `NOMBRE_PRODUCTO`, `DESCRIPCION_PRODUCTO`, `PRECIO`, `FK_ID_CATEGORIA`, `DESCUENTO_PRODUCTO`, `URL_IMG_PRODUCTO`) VALUES
('prod-001', 'Momos al vapor', 'Seis jugosos momos rellenos, cocidos al vapor y servidos con una cama crujiente de repollo y vegetales frescos, acompañados de un toque de salsa especial. Una opción ligera pero llena de sabor, cada bocado es una explosión de especias suaves y texturas deliciosas. Son la entrada perfecta para abrir el apetito con un toque exótico y reconfortante.\r\n', 20000, 'cat-01', 0, 'uploads/momo.png'),
('prod-002', 'Gyozas de Cerdo y Vegetales', 'Empanadillas japonesas doradas en sartén con relleno jugoso de cerdo, repollo y cebollín, acompañadas de salsa de soya. Crujientes por fuera, suaves por dentro. Estas gyozas están cocinadas con la técnica tradicional que combina vapor y sellado en sartén. Servidas con una salsa de soya ligera para resaltar su sabor.', 10000, 'cat-01', 0, 'uploads/gyozas.png'),
('prod-003', 'Filete Campo Gourmet', 'Jugoso medallón de res a la parrilla, acompañado de coles de Bruselas asadas, puré rústico de zanahoria y almendras tostadas. Nuestra carne de res es sellada al punto justo para conservar todo su sabor, servida junto a coles de Bruselas crocantes, puré de zanahoria con mantequilla especiada, y un toque crujiente de almendras laminadas. Terminado con perejil fresco picado.', 32500, 'cat-02', 0, 'uploads/carne2.png'),
('prod-004', 'Enchiladas Norteñas de Res', 'Tortillas doradas rellenas de carne sazonada, cubiertas con salsa cremosa, cebolla larga y un toque de chile verde, finalizadas con cebolla fresca para un contraste perfecto. Brindando una explosión de sabor en cada bocado. ¡Una fiesta de sabor al estilo norteño!\r\n', 34800, 'cat-02', 0, 'uploads/enchiladas2.png'),
('prod-005', 'Pollo gratinado', 'Pechuga de pollo empanizada y gratinada con mozzarella, servida con pasta penne en salsa pomodoro.\r\n\r\nUna explosión de sabor italiano en cada bocado. El pollo es empanizado con un dorado crujiente irresistible, cubierto con salsa marinara casera, queso derretido y albahaca fresca. Acompañado de penne al dente bañado en nuestra salsa de tomate artesanal y coronado con queso parmesano rallado.', 35300, 'cat-02', 0, 'uploads/pollo2_parmesano.png'),
('prod-006', 'Spaghetti en Salsa de Tomate', 'Clásicos spaghetti al dente bañados en una suave y cremosa salsa de tomate natural, con un toque de ajo y albahaca. Este plato reconfortante combina la textura perfecta de la pasta con una salsa cremosa. Una opción sabrosa y satisfactoria para los amantes de la comida italiana.', 32900, 'cat-02', 0, 'uploads/pastas2.png'),
('prod-007', 'Naan ChocoLovers', 'Naan artesanal bañado en una generosa capa de chocolate fundido. Fusiona la tradición de la panadería india con la dulzura irresistible del chocolate. Ideal para compartir… o no. Sírvelo caliente y déjate llevar por la mezcla de texturas y sabores que derriten el paladar', 14900, 'cat-04', 0, 'uploads/naan.png'),
('prod-008', 'Rollo de Canela', 'Masa suave en espiral con relleno de canela y azúcar morena, glaseado con cobertura de vainilla. Dulce, tibio y reconfortante. Nuestro rollo de canela está hecho con masa artesanal horneada lentamente hasta quedar dorada y suave. Cada capa está impregnada con canela aromática y azúcar morena, rematada con un glaseado de vainilla que se derrite al primer contacto. Perfecto para acompañar tu café o disfrutar como postre.', 8500, 'cat-04', 0, 'uploads/rollo_canela.png');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `categorias_prod`
--
ALTER TABLE `categorias_prod`
  ADD PRIMARY KEY (`ID_CATEGORIA`);

--
-- Indices de la tabla `detalle_pedido`
--
ALTER TABLE `detalle_pedido`
  ADD PRIMARY KEY (`ID_DETALLE_PEDIDO`);

--
-- Indices de la tabla `pedido`
--
ALTER TABLE `pedido`
  ADD PRIMARY KEY (`ID_PEDIDO`);

--
-- Indices de la tabla `productos`
--
ALTER TABLE `productos`
  ADD PRIMARY KEY (`ID_PRODUCTO`),
  ADD KEY `fk_productos_categoria` (`FK_ID_CATEGORIA`);

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `productos`
--
ALTER TABLE `productos`
  ADD CONSTRAINT `fk_productos_categoria` FOREIGN KEY (`FK_ID_CATEGORIA`) REFERENCES `categorias_prod` (`ID_CATEGORIA`) ON DELETE SET NULL ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
