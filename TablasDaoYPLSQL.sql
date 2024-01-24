CREATE TABLE Clientes (
    id_cliente INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(50),
    direccion VARCHAR(100)
)
-- Tabla para almacenar las compras
CREATE TABLE compras (
    id_compra INT PRIMARY KEY AUTO_INCREMENT,
    id_cliente INT,
    fecha_compra DATE,
    es_agrupada BOOLEAN DEFAULT false,
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente)
);
-- Creación de la tabla Productos
CREATE TABLE Productos (
    id_producto INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100),
    precio_unitario DECIMAL(10, 2)
);
-- Tabla para almacenar los detalles de las compras (productos comprados)
CREATE TABLE detalles_compra (
    id_detalle INT PRIMARY KEY AUTO_INCREMENT,
    id_compra INT,
    id_producto INT,
    cantidad INT,
    precio_unitario DECIMAL(10, 2),
    FOREIGN KEY (id_compra) REFERENCES compra(id_compra),
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto)
);
-- Tabla para gestionar los envíos agrupados
CREATE TABLE envios_agrupados (
    id_envio_agrupado INT PRIMARY KEY AUTO_INCREMENT,
    id_cliente INT,
    fecha_envio DATE,
    costo_envio DECIMAL(10, 2),
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente)
);
-- Tabla para vincular detalles de compras con envíos agrupados
CREATE TABLE detalles_envio_agrupado (
    id_detalle_envio INT PRIMARY KEY AUTO_INCREMENT,
    id_envio_agrupado INT,
    id_detalle_compra INT,
    FOREIGN KEY (id_envio_agrupado) REFERENCES envios_agrupados(id_envio_agrupado),
    FOREIGN KEY (id_detalle_compra) REFERENCES detalles_compra(id_detalle)
);

-- Inserts para la tabla Clientes
INSERT INTO Clientes (nombre, direccion) VALUES ('Cliente1', 'Direccion1');
INSERT INTO Clientes (nombre, direccion) VALUES ('Cliente2', 'Direccion2');
INSERT INTO Clientes (nombre, direccion) VALUES ('Cliente3', 'Direccion3');
INSERT INTO Clientes (nombre, direccion) VALUES ('Cliente4', 'Direccion4');
INSERT INTO Clientes (nombre, direccion) VALUES ('Cliente5', 'Direccion5');

-- Inserts para la tabla Productos
INSERT INTO Productos (nombre, precio_unitario) VALUES ('Producto1', 20.99);
INSERT INTO Productos (nombre, precio_unitario) VALUES ('Producto2', 15.50);
INSERT INTO Productos (nombre, precio_unitario) VALUES ('Producto3', 30.75);
INSERT INTO Productos (nombre, precio_unitario) VALUES ('Producto4', 10.25);
INSERT INTO Productos (nombre, precio_unitario) VALUES ('Producto5', 5.99);

-- Inserts para la tabla compras
INSERT INTO compras (id_cliente, fecha_compra, es_agrupada) VALUES (1, '2024-01-24', true);
INSERT INTO compras (id_cliente, fecha_compra, es_agrupada) VALUES (2, '2024-01-23', false);
INSERT INTO compras (id_cliente, fecha_compra, es_agrupada) VALUES (3, '2024-01-22', true);
INSERT INTO compras (id_cliente, fecha_compra, es_agrupada) VALUES (4, '2024-01-21', false);
INSERT INTO compras (id_cliente, fecha_compra, es_agrupada) VALUES (5, '2024-01-20', true);

-- Inserts para la tabla detalles_compra
INSERT INTO detalles_compra (id_compra, id_producto, cantidad, precio_unitario) VALUES (1, 1, 2, 20.99);
INSERT INTO detalles_compra (id_compra, id_producto, cantidad, precio_unitario) VALUES (2, 3, 1, 30.75);
INSERT INTO detalles_compra (id_compra, id_producto, cantidad, precio_unitario) VALUES (3, 2, 3, 15.50);
INSERT INTO detalles_compra (id_compra, id_producto, cantidad, precio_unitario) VALUES (4, 4, 5, 10.25);
INSERT INTO detalles_compra (id_compra, id_producto, cantidad, precio_unitario) VALUES (5, 5, 2, 5.99);

-- Inserts para la tabla envios_agrupados
INSERT INTO envios_agrupados (id_cliente, fecha_envio, costo_envio) VALUES (1, '2024-01-31', 10.50);
INSERT INTO envios_agrupados (id_cliente, fecha_envio, costo_envio) VALUES (2, '2024-01-30', 8.75);
INSERT INTO envios_agrupados (id_cliente, fecha_envio, costo_envio) VALUES (3, '2024-02-29', 15.25);


-- Inserts para la tabla detalles_envio_agrupado
INSERT INTO detalles_envio_agrupado (id_envio_agrupado, id_detalle_compra) VALUES (1, 1);
INSERT INTO detalles_envio_agrupado (id_envio_agrupado, id_detalle_compra) VALUES (2, 3);
INSERT INTO detalles_envio_agrupado (id_envio_agrupado, id_detalle_compra) VALUES (3, 5);



-- tabla ej 3 a
CREATE TABLE Articulos_a_potenciar (
    id_articulo NUMBER PRIMARY KEY,
    precio NUMBER,
    fecha_registro DATE
);


CREATE OR REPLACE FUNCTION obtenerNumeroVentasYRegistrarArticulo(articulo IN NUMBER)
RETURN NUMBER
IS
    ventas NUMBER;
BEGIN
    -- Verificar el número de ventas agrupadas del artículo
    SELECT COUNT(DISTINCT id_compra)
    INTO ventas
    FROM detalles_compra
    WHERE id_producto = articulo;

    -- Si el artículo no está en ninguna venta, registrar en la tabla auxiliar
    IF ventas = 0 THEN
        INSERT INTO Articulos_a_potenciar (id_articulo, precio, fecha_registro)
        SELECT id_producto, precio_unitario, SYSDATE
        FROM Productos
        WHERE id_producto = articulo;
    END IF;

    RETURN ventas;
EXCEPTION
--NO DATA
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Artículo no encontrado.');
        RETURN 0;
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
        RETURN -1;
END obtenerNumeroVentasYRegistrarArticulo;
/


--EJ 3 B
CREATE OR REPLACE PROCEDURE AnalizarArticulo
IS
    articulo NUMBER;
    ventas NUMBER;
BEGIN
--entrada teclado
    DBMS_OUTPUT.PUT('Ingrese el código del artículo: ');
    DBMS_INPUT.GET_LINE(articulo);

    -- Llamar a la función para obtener el número de ventas y registrar el artículo si es necesario
    ventas := obtenerNumeroVentasYRegistrarArticulo(articulo);

    -- Mostrar los resultados por pantalla
    IF ventas > 0 THEN
        DBMS_OUTPUT.PUT_LINE('Número de ventas agrupadas en las que el artículo ha participado: ' || ventas);
    ELSE
        DBMS_OUTPUT.PUT_LINE('Se ha generado un registro en la tabla auxiliar para el artículo.');
    END IF;
END AnalizarArticulo;
/





