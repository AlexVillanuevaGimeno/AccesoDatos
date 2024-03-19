-- Crear base de datos
CREATE DATABASE examen;

-- Cambiar a la base de datos examen
USE examen;

DROP TABLE cliente;
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

DROP TABLE compra;
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

DROP TABLE producto;
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


DROP TABLE detalles_compra;
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

DROP TABLE envio;
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


DROP TABLE detalles_envio;
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



DROP TABLE punto_entrega;
CREATE TABLE punto_entrega(
  id_punto_entrega NUMBER(3) NOT NULL,
  id_envio NUMBER(3) NOT NULL UNIQUE,
  id_cliente NUMBER(3) NOT NULL,
  direccion VARCHAR2(100) NOT NULL,
  recogido VARCHAR2(2) NOT NULL
  CONSTRAINT punto_entrega_pk PRIMARY KEY (id_punto_entrega),
  CONSTRAINT punto_entrega_fk_envio FOREIGN KEY (id_envio) REFERENCES envio(id_envio),
  CONSTRAINT punto_entrega_fk_cliente FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente)
);

INSERT INTO punto_entrega(id_punto_entrega, id_envio, id_cliente, direccion) VALUES
(1, 1, 1, 'calle 1','si'),
(2, 2, 1, 'calle 2','no'),
(3, 3, 2, 'calle 3','si'),
(4, 4, 4, 'calle 4','no'),
(5, 2, 4, 'calle 5','si');


--ej1
CREATE OR REPLACE PROCEDURE alta_punto_entrega(
  v_id_punto_entrega punto_entrega.id_punto_entrega%TYPE,
  v_id_envio punto_entrega.id_envio%TYPE,
  v_id_cliente punto_entrega.id_cliente%TYPE,
  v_direccion punto_entrega.direccion%TYPE)
AS
punto_entrega_nulo EXCEPTION;
envio_nulo EXCEPTION;
cliente_nulo EXCEPTION;
direccion_nula EXCEPTION;
BEGIN
INSERT INTO punto_entrega(id_punto_entrega, id_envio, id_cliente, direccion, recogido) 
VALUES(v_id_punto_entrega, v_id_envio, v_id_cliente, v_direccion, 'no');
IF v_id_punto_entrega IS NULL THEN
RAISE punto_entrega_nulo;
END IF;
IF v_id_envio IS NULL THEN
RAISE envio_nulo;
END IF;
IF v_id_cliente IS NULL THEN 
RAISE cliente_nulo;
END IF;
IF v_direccion IS NULL THEN
RAISE direccion_nula;
EXCEPTION
WHEN DUP_VAL_ON_INDEX THEN
  RAISE_APPLICATION_ERROR(-20001, 'Err, Id del punto de entrega repetido')
  RAISE;
WHEN punto_entrega_nulo THEN
DBMS_OUTPUT.PUT_LINE('NO SE PUEDE REALIZAR LA INSERCION: EL ID DEL PUNTO DE ENTREGA NO PUEDE SER NULO')
RAISE;
WHEN envio_nulo THEN
DBMS_OUTPUT.PUT_LINE('No se puede realizar la insercion: El id del envio no puede ser nulo')
RAISE;
WHEN cliente_nulo THEN
DBMS_OUTPUT.PUT_LINE('No se puede realizar la insercion: El id del cliente no puede ser nulo')
RAISE;
WHEN direccion_nula THEN
DBMS_OUTPUT.PUT_LINE('No se puede realizar la insercion: La direccion o no puede ser nula')
RAISE;
END;
/

--ej 2
CREATE TABLE punto_audit(
  id NUMBER(3) GENERATED ALWAYS AS IDENTITY START WITH 1 INCREMENT BY 1,
  id_punto_entrega NUMBER(3) GENERATED ALWAYS AS IDENTITY START WITH 1 INCREMENT BY 1 NOT NULL,
  id_envio NUMBER(3) NOT NULL UNIQUE,
  id_cliente NUMBER(3) NOT NULL,
  direccion VARCHAR2(100) NOT NULL,
  recogido VARCHAR2(2) NOT NULL
);

CREATE OR REPLACE TRIGGER auditar_borrado_punto
BEFORE DELETE ON punto_recogida
FOR EACH ROW
BEGIN 
--COMPROBACION SI HAY PRODUCTOS POR RECOGER SE NOTIFICA Y SE CANCELA EL BORRADO
IF recogido = 'no' THEN
DBMS_OUTPUT.PUT_LINE('QUEDAN PROIDUCTOS POR RECOGER EN ESTE PUNTO DE ENTREGA');
ELSE
BEGIN
INSERT INTO c##root.punto_audit(id_punto_entrega, id_envio, id_cliente, direccion, recogido)
VALUES(:OLD.id_punto_entrega, :OLD.id_envio, :OLD.id_cliente, :OLD.direccion, :OLD.recogido);
EXCEPTION
  WHEN NO_DATA_FOUND THEN
  DBMS_OUTPUT.PUT_LINE('NO SE HAN ENCONTRADO DATOS PARA AUDITAR');
  WHEN DUP_VAL_ON_INDEX THEN
  DBMS_OUTPUT.PUT_LINE('SE INTENTO INSERTAR UN VALOR DUPLICADO EN LA COLUMNA ID PUNTO RECOGIDA EN LA TABLA PUNTO_AUDIT');
  WHEN TOO_MANY_ROWS THEN
  -- Manejar la excepción TOO_MANY_ROWS
  DBMS_OUTPUT.PUT_LINE('Demasiadas filas encontradas al realizar la inserción en la tabla punto_audit.');
  WHEN OTHERS THEN
  DBMS_OUTPUT.PUT_LINE('ERROR INESPERADO: ' || SQLERRM);
END;
END IF;
END;
/

--ej3
CREATE OR REPLACE FUNCTION comprobacion_dias(p_id_punto_entrega NUMBER(3))
RETURN INTEGER is p_count;
--CURSOR PARA RECORRER LOS PEDIDOS
CURSOR cur_recogidos IS
SELECT id_envio , recogido FROM punto_entrega
WHERE id_punto_entrega = p_id_punto_entrega;
v_id_envio punto_entrega.id_envio%TYPE;
v_recogido punto_entrega.recogido%TYPE;
BEGIN
OPEN cur_recogidos;
FETCH cur_recogidos INTO v_id_envio, v_recogido;
WHILE cur_recogidos%FOUND LOOP
  FETCH cur_recogidos INTO v_id_envio, v_recogido;
  IF v_recogido = 'no' THEN
    --NO TENGO TIEMPO PARA GESTIONAR LAS FECHAS
    --ASI QUE NOS PONDREMOS ENCONTACTO SIEMPRE Q NO ESTE RECOGIDO
    --cojo el nombrte y numero del cliente
    SELECT nombre, telefono FROM cliente WHERE id_cliente = 
    (SELECT id_cliente FROM punto_entrega WHERE id_envio = v_id_envio);
    DBMS_OUTPUT.PUT_LINE('hola sr/a ' || nombre || ' Tiene que recoger su pedido');

  END LOOP;
  DBMS_OUTPUT.PUT_LINE(cur_recogidos%ROWCOUNT || ' PEDIDOS SIN RECOGER' );
CLOSE cur_recogidos;
END;