-- Crear base de datos
CREATE DATABASE examen;

-- Cambiar a la base de datos examen
USE examen;

-- Estructura de tabla para la tabla cliente
CREATE TABLE cliente (
  id_cliente NUMBER(3) NOT NULL,
  dni VARCHAR2(9),
  nombre VARCHAR2(50),
  direccion VARCHAR2(100),
  telefono NUMBER(9),
  CONSTRAINT cliente_pk PRIMARY KEY (id_cliente),
  CONSTRAINT cliente_uk UNIQUE (dni)
);

-- Volcado de datos para la tabla cliente
INSERT INTO cliente (id_cliente, dni, nombre, direccion, telefono) VALUES
(1, '78596656L', 'Isra', 'Calle 1', 602548596),
(2, '12345678X', 'María', 'Avenida 2', 604123456),
(3, '98765432Y', 'Juan', 'Calle 3', 606789012);

-- Estructura de tabla para la tabla compra
CREATE TABLE compra (
  id_compra NUMBER(3) NOT NULL,
  fecha_compra DATE,
  agrupada NUMBER(1),
  id_cliente NUMBER(3),
  CONSTRAINT compra_pk PRIMARY KEY (id_compra),
  CONSTRAINT compra_fk_cliente FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente)
);

-- Volcado de datos para la tabla compra
INSERT INTO compra (id_compra, fecha_compra, agrupada, id_cliente) VALUES
(1, TO_DATE('2024-03-16', 'YYYY-MM-DD'), 1, 1),
(2, TO_DATE('2024-03-16', 'YYYY-MM-DD'), 1, 2),
(3, TO_DATE('2024-03-16', 'YYYY-MM-DD'), 0, 3),
(4, TO_DATE('2024-03-16', 'YYYY-MM-DD'), 1, 1),
(5, TO_DATE('2024-03-16', 'YYYY-MM-DD'), 0, 2),
(6, TO_DATE('2024-03-16', 'YYYY-MM-DD'), 1, 3);

-- Estructura de tabla para la tabla detalles_compra
CREATE TABLE detalles_compra (
  id_detalles_compra NUMBER(3) NOT NULL,
  id_compra NUMBER(3),
  id_producto NUMBER(3),
  cantidad NUMBER(5),
  CONSTRAINT detalles_compra_pk PRIMARY KEY (id_detalles_compra),
  CONSTRAINT detalles_compra_fk_compra FOREIGN KEY (id_compra) REFERENCES compra(id_compra),
  CONSTRAINT detalles_compra_fk_producto FOREIGN KEY (id_producto) REFERENCES producto(id_producto)
);

-- Volcado de datos para la tabla detalles_compra
INSERT INTO detalles_compra (id_detalles_compra, id_compra, id_producto, cantidad) VALUES
(1, 1, 1, 3),
(2, 1, 2, 2),
(3, 2, 3, 1),
(4, 3, 1, 4);

-- Estructura de tabla para la tabla detalles_envio
CREATE TABLE detalles_envio (
  id_detalles_envio NUMBER(3) NOT NULL,
  id_producto NUMBER(3) NOT NULL,
  id_envio NUMBER(3),
  CONSTRAINT detalles_envio_pk PRIMARY KEY (id_detalles_envio),
  CONSTRAINT detalles_envio_fk_envio FOREIGN KEY (id_envio) REFERENCES envio(id_envio),
  CONSTRAINT detalles_envio_fk_producto FOREIGN KEY (id_producto) REFERENCES producto(id_producto)
);

-- Volcado de datos para la tabla detalles_envio
INSERT INTO detalles_envio (id_detalles_envio, id_producto, id_envio) VALUES
(1, 1, 1),
(2, 2, 2),
(3, 3, 3);

-- Estructura de tabla para la tabla envio
CREATE TABLE envio (
  id_envio NUMBER(3) NOT NULL,
  fecha_envio DATE,
  direccion VARCHAR2(100),
  id_cliente NUMBER(3),
  CONSTRAINT envio_pk PRIMARY KEY (id_envio),
  CONSTRAINT envio_fk_cliente FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente)
);

-- Volcado de datos para la tabla envio
INSERT INTO envio (id_envio, fecha_envio, direccion, id_cliente) VALUES
(1, TO_DATE('2024-03-16', 'YYYY-MM-DD'), 'Calle del cliente 1', 1),
(2, TO_DATE('2024-03-16', 'YYYY-MM-DD'), 'Avenida del cliente 2', 2),
(3, TO_DATE('2024-03-16', 'YYYY-MM-DD'), 'Calle del cliente 3', 3),
(4, TO_DATE('2024-03-16', 'YYYY-MM-DD'), 'Calle del cliente 1', 1),
(5, TO_DATE('2024-03-16', 'YYYY-MM-DD'), 'Avenida del cliente 2', 2),
(6, TO_DATE('2024-03-16', 'YYYY-MM-DD'), 'Calle del cliente 3', 3);

-- Estructura de tabla para la tabla producto
CREATE TABLE producto (
  id_producto NUMBER(3) NOT NULL,
  nombre VARCHAR2(50),
  descripcion VARCHAR2(100),
  precio FLOAT,
  CONSTRAINT producto_pk PRIMARY KEY (id_producto)
);

-- Volcado de datos para la tabla producto
INSERT INTO producto (id_producto, nombre, descripcion, precio) VALUES
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
