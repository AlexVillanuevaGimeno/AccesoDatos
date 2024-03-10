CREATE
OR REPLACE PACKAGE BODY BiblioTK AS CREATE
OR REPLACE FUNCTION alta_obra (p_titulo VARCHAR2, p_anyo INTEGER DEFAULT NULL) RETURN VARCHAR2 IS p_id VARCHAR2(5);

p_count INTEGER;

BEGIN LOOP p_id := DBMS_RANDOM.STRING('X', 5);

-- GENERAR ID ALEATORIA PARA OBRA
BEGIN
SELECT
    COUNT(*) INTO p_count
FROM
    OBRA
WHERE
    id = p_id;

EXIT
WHEN p_count = 0;

-- Salir del bucle si se encuentra un ID único
EXCEPTION
WHEN NO_DATA_FOUND THEN EXIT;

-- Salir del bucle si no se encuentra ningún dato (ID único)
END;

END LOOP;

-- INSERTAR OBRA CON ID ÚNICO
INSERT INTO
    OBRA (id, titulo, anyo)
VALUES
    (p_id, p_titulo, p_anyo);

RETURN p_id;

EXCEPTION
WHEN OTHERS THEN RETURN '-1';

-- Manejar cualquier excepción devolviendo '-1'
END;

/ CREATE
OR REPLACE FUNCTION borrado_obra (p_id VARCHAR2) RETURN INTEGER IS p_count INTEGER;

BEGIN
SELECT
    COUNT(*) INTO p_count
FROM
    OBRA
WHERE
    id = p_id;

IF p_count = 0 THEN RETURN 0;

-- No se encontró ninguna obra con el ID dado
ELSE
DELETE FROM
    OBRA
WHERE
    id = p_id;

RETURN 1;

-- La obra fue borrada exitosamente
END IF;

EXCEPTION
WHEN OTHERS THEN RETURN -1;

-- Manejar cualquier excepción devolviendo -1
END;

/ CREATE
OR REPLACE FUNCTION alta_autor (
    p_nombre VARCHAR2,
    p_apellidos VARCHAR2,
    p_nacimiento DATE DEFAULT NULL
) RETURN VARCHAR2 IS p_id VARCHAR2(4);

p_maxLengthNombre NUMBER(3);

p_maxLengthApellidos NUMBER(3);

BEGIN -- Obtener la longitud máxima permitida para los campos de nombre y apellidos
SELECT
    MAX(char_length) INTO p_maxLengthNombre
FROM
    USER_TAB_COLUMNS
WHERE
    TABLE_NAME = 'AUTOR'
    AND COLUMN_NAME = 'NOMBRE';

SELECT
    MAX(char_length) INTO p_maxLengthApellidos
FROM
    USER_TAB_COLUMNS
WHERE
    TABLE_NAME = 'AUTOR'
    AND COLUMN_NAME = 'APELLIDOS';

-- Obtener el conteo de autores existentes
SELECT
    COUNT(*) INTO p_id
FROM
    AUTOR;

-- Generar el ID del autor
IF p_id IS NULL THEN p_id := '1';

ELSE p_id := TO_CHAR(TO_NUMBER(p_id) + 1);

END IF;

-- Verificar restricciones de longitud para nombre y apellidos
IF LENGTH(p_apellidos) > p_maxLengthApellidos
OR LENGTH(p_nombre) > p_maxLengthNombre THEN RAISE VALUE_ERROR;

END IF;

-- Verificar restricciones de fecha de nacimiento
IF p_nacimiento IS NOT NULL THEN IF p_nacimiento > SYSDATE
OR p_nacimiento < TO_DATE('01/01/0001', 'DD/MM/YYYY') THEN RAISE NUMERIC_OR_VALUE_ERROR;

END IF;

END IF;

-- Insertar el nuevo autor en la tabla
INSERT INTO
    AUTOR (id, nombre, apellidos, nacimiento)
VALUES
    (p_id, p_nombre, p_apellidos, p_nacimiento);

RETURN p_id;

EXCEPTION
WHEN VALUE_ERROR THEN RETURN '-2';

-- Error de longitud de cadena
WHEN NUMERIC_OR_VALUE_ERROR THEN RETURN '-1';

-- Error en la fecha de nacimiento
WHEN OTHERS THEN RETURN '-3';

-- Otro tipo de error
END;

/ CREATE
OR REPLACE FUNCTION borrado_autor (p_id VARCHAR2) RETURN INTEGER IS p_countAux NUMBER(3);

p_maxLengthID NUMBER(6);

p_idAux AUTOR.id % TYPE;

BEGIN -- Obtener la longitud máxima permitida para el campo de ID
SELECT
    MAX(char_length) INTO p_maxLengthID
FROM
    USER_TAB_COLUMNS
WHERE
    TABLE_NAME = 'AUTOR'
    AND COLUMN_NAME = 'ID';

-- Eliminar espacios en blanco alrededor del ID proporcionado
p_idAux := TRIM(p_id);

-- Verificar la longitud del ID proporcionado
IF LENGTH(p_idAux) > p_maxLengthID THEN RAISE VALUE_ERROR;

END IF;

-- Contar la cantidad de registros con el ID proporcionado
SELECT
    COUNT(*) INTO p_countAux
FROM
    AUTOR
WHERE
    id = p_idAux;

-- Si no se encuentra ningún registro con el ID proporcionado, lanzar una excepción
IF p_countAux = 0 THEN RAISE NO_DATA_FOUND;

END IF;

-- Si se encuentra al menos un registro, eliminar el autor
DELETE FROM
    AUTOR
WHERE
    id = p_idAux;

RETURN 1;

-- Devolver 1 indicando que se borró exitosamente
EXCEPTION
WHEN NO_DATA_FOUND THEN RETURN 0;

-- Devolver 0 indicando que no se encontró ningún autor con el ID proporcionado
WHEN VALUE_ERROR THEN RETURN -2;

-- Error de longitud de ID
WHEN OTHERS THEN RETURN -1;

-- Otro tipo de error
END;

/ CREATE
OR REPLACE FUNCTION vincular (
    p_id_autor VARCHAR2,
    p_id_obra VARCHAR2
) RETURN INTEGER IS p_id_autorAux AUTOR.id % TYPE;

p_id_obraAux OBRA.id % TYPE;

p_maxLength_idAutor NUMBER(6);

p_maxLength_idObra NUMBER(6);

p_countAux NUMBER(3);

BEGIN -- Eliminar espacios en blanco alrededor de los IDs proporcionados
p_id_autorAux := TRIM(p_id_autor);

p_id_obraAux := TRIM(p_id_obra);

-- Obtener la longitud máxima permitida para los campos de ID de AUTOR y OBRA
SELECT
    MAX(char_length) INTO p_maxLength_idAutor
FROM
    USER_TAB_COLUMNS
WHERE
    TABLE_NAME = 'AUTOR'
    AND COLUMN_NAME = 'ID';

SELECT
    MAX(char_length) INTO p_maxLength_idObra
FROM
    USER_TAB_COLUMNS
WHERE
    TABLE_NAME = 'OBRA'
    AND COLUMN_NAME = 'ID';

-- Verificar la longitud de los IDs proporcionados
IF LENGTH(p_id_obraAux) > p_maxLength_idObra
OR LENGTH(p_id_autorAux) > p_maxLength_idAutor THEN RAISE VALUE_ERROR;

END IF;

-- Verificar si el ID del autor proporcionado existe en la tabla AUTOR
SELECT
    COUNT(*) INTO p_countAux
FROM
    AUTOR
WHERE
    id = p_id_autorAux;

IF p_countAux = 0 THEN RAISE NO_DATA_FOUND;

END IF;

-- Verificar si el ID de la obra proporcionado existe en la tabla OBRA
SELECT
    COUNT(*) INTO p_countAux
FROM
    OBRA
WHERE
    id = p_id_obraAux;

IF p_countAux = 0 THEN RAISE NO_DATA_FOUND;

END IF;

-- Insertar la relación autor-obra en la tabla AUTOR_OBRA
INSERT INTO
    AUTOR_OBRA (id_autor, id_obra)
VALUES
    (p_id_autorAux, p_id_obraAux);

RETURN 1;

-- Indicar que se vinculó correctamente
EXCEPTION
WHEN VALUE_ERROR THEN RETURN -2;

-- Error de longitud de ID
WHEN NO_DATA_FOUND THEN RETURN 0;

-- No se encontró el autor o la obra con el ID proporcionado
WHEN OTHERS THEN RETURN -1;

-- Otro tipo de error
END;

/ CREATE
OR REPLACE FUNCTION desvincular (
    p_id_autor VARCHAR2,
    p_id_obra VARCHAR2
) RETURN INTEGER IS p_id_autorAux AUTOR.id % TYPE;

p_id_obraAux OBRA.id % TYPE;

p_countAux NUMBER(3);

p_maxLength_idAutor NUMBER(6);

p_maxLength_idObra NUMBER(6);

BEGIN -- Eliminar espacios en blanco alrededor de los IDs proporcionados
p_id_autorAux := TRIM(p_id_autor);

p_id_obraAux := TRIM(p_id_obra);

-- Obtener la longitud máxima permitida para los campos de ID de AUTOR y OBRA
SELECT
    MAX(char_length) INTO p_maxLength_idAutor
FROM
    USER_TAB_COLUMNS
WHERE
    TABLE_NAME = 'AUTOR'
    AND COLUMN_NAME = 'ID';

SELECT
    MAX(char_length) INTO p_maxLength_idObra
FROM
    USER_TAB_COLUMNS
WHERE
    TABLE_NAME = 'OBRA'
    AND COLUMN_NAME = 'ID';

-- Verificar si existe la relación autor-obra en la tabla AUTOR_OBRA
SELECT
    COUNT(*) INTO p_countAux
FROM
    AUTOR_OBRA
WHERE
    id_autor = p_id_autorAux
    AND id_obra = p_id_obraAux;

-- Si no se encuentra la relación, lanzar una excepción
IF p_countAux = 0 THEN RAISE NO_DATA_FOUND;

END IF;

-- Eliminar la relación autor-obra de la tabla AUTOR_OBRA
DELETE FROM
    AUTOR_OBRA
WHERE
    id_autor = p_id_autorAux
    AND id_obra = p_id_obraAux;

RETURN 1;

-- Indicar que se desvinculó correctamente
EXCEPTION
WHEN NO_DATA_FOUND THEN RETURN 0;

-- Indicar que la relación no existe
WHEN OTHERS THEN RETURN -1;

-- Indicar que ocurrió un error
END;

/ CREATE
OR REPLACE FUNCTION alta_edicion (
    p_id_obra VARCHAR2,
    p_isbn VARCHAR2,
    p_anyo INTEGER DEFAULT NULL
) RETURN VARCHAR2 IS p_id_obraAux OBRA.id % TYPE;

p_id_edicion EDICION.ID % TYPE;

p_anyoAux OBRA.anyo % TYPE;

p_countAux NUMBER(3);

p_maxLength_idObra NUMBER(6);

p_maxLength_ISBN NUMBER(6);

BEGIN -- Eliminar espacios en blanco alrededor de los IDs proporcionados
p_id_obraAux := TRIM(p_id_obra);

-- Obtener la longitud máxima permitida para los campos de ID de OBRA y ISBN de EDICION
SELECT
    MAX(char_length) INTO p_maxLength_idObra
FROM
    USER_TAB_COLUMNS
WHERE
    TABLE_NAME = 'OBRA'
    AND COLUMN_NAME = 'ID';

SELECT
    MAX(char_length) INTO p_maxLength_ISBN
FROM
    USER_TAB_COLUMNS
WHERE
    TABLE_NAME = 'EDICION'
    AND COLUMN_NAME = 'ISBN';

-- Obtener el año de la obra con el ID proporcionado
SELECT
    anyo INTO p_anyoAux
FROM
    OBRA
WHERE
    id = p_id_obraAux;

-- Verificar el año proporcionado para la edición
IF p_anyo < p_anyoAux
OR p_anyo > EXTRACT(
    YEAR
    FROM
        SYSDATE
) + 3 THEN RAISE VALUE_ERROR;

END IF;

-- Verificar las restricciones de longitud para p_id_obra y p_isbn
IF LENGTH(p_id_obraAux) > p_maxLength_idObra
OR LENGTH(p_isbn) > p_maxLength_ISBN THEN RAISE VALUE_ERROR;

END IF;

-- Verificar que el año esté dentro del rango permitido
IF p_anyo < 0
OR p_anyo > 9999 THEN RAISE VALUE_ERROR;

END IF;

-- Verificar si la obra con el ID proporcionado existe
SELECT
    COUNT(*) INTO p_countAux
FROM
    OBRA
WHERE
    id = p_id_obraAux;

IF p_countAux = 0 THEN RAISE NO_DATA_FOUND;

END IF;

-- Verificar si ya existe una edición con el ISBN proporcionado
SELECT
    COUNT(*) INTO p_countAux
FROM
    EDICION
WHERE
    ISBN = p_isbn;

IF p_countAux <> 0 THEN RAISE DATA_EXISTS;

END IF;

-- Generar el ID de la nueva edición
SELECT
    COUNT(*) INTO p_countAux
FROM
    EDICION;

IF p_countAux = 0 THEN p_id_edicion := '0';

ELSE
SELECT
    id INTO p_id_edicion
FROM
    EDICION
ORDER BY
    id DESC
FETCH FIRST
    1 ROWS ONLY;

p_id_edicion := TO_CHAR(TO_NUMBER(p_id_edicion) + 1);

END IF;

-- Insertar la nueva edición en la tabla EDICION
INSERT INTO
    EDICION (ID, ID_OBRA, ISBN, anyo)
VALUES
    (p_id_edicion, p_id_obraAux, p_isbn, p_anyo);

RETURN '1';

-- Indicar que se ha realizado la inserción correctamente
EXCEPTION
WHEN VALUE_ERROR THEN RETURN '-2';

-- Error debido a los valores proporcionados
WHEN NO_DATA_FOUND THEN RETURN '0';

-- No se encontró la obra con el ID proporcionado
WHEN DATA_EXISTS THEN RETURN '-3';

-- Ya existe una edición con el ISBN proporcionado
WHEN OTHERS THEN RETURN '-1';

-- Otro tipo de error
END;

/ CREATE
OR REPLACE FUNCTION borrado_edicion(p_id VARCHAR2) RETURN INTEGER IS p_idAux EDICION.ID % TYPE;

p_countAux NUMBER(3);

BEGIN -- Eliminar espacios en blanco alrededor del ID proporcionado
p_idAux := TRIM(p_id);

-- Verificar si existe una edición con el ID proporcionado
SELECT
    COUNT(*) INTO p_countAux
FROM
    EDICION
WHERE
    id = p_idAux;

-- Si no se encuentra la edición, lanzar una excepción
IF p_countAux = 0 THEN RAISE NO_DATA_FOUND;

END IF;

-- Eliminar la edición con el ID proporcionado
DELETE FROM
    EDICION
WHERE
    id = p_idAux;

RETURN 1;

-- Indicar que se borró exitosamente
EXCEPTION
WHEN NO_DATA_FOUND THEN RETURN 0;

-- Indicar que no se encontró la edición con el ID proporcionado
WHEN OTHERS THEN RETURN -1;

-- Indicar que ocurrió un error
END;

/ CREATE
OR REPLACE FUNCTION alta_ejemplar(p_id_edicion VARCHAR2) RETURN INTEGER IS p_id_edicionAux EDICION.ID % TYPE;

p_countAux NUMBER(3);

p_maxLength_idEdicion NUMBER(6);

p_Numero EJEMPLAR.NUMERO % TYPE;

BEGIN -- Eliminar espacios en blanco alrededor del ID de edición proporcionado
p_id_edicionAux := TRIM(p_id_edicion);

-- Obtener la longitud máxima permitida para el ID de edición
SELECT
    MAX(char_length) INTO p_maxLength_idEdicion
FROM
    USER_TAB_COLUMNS
WHERE
    TABLE_NAME = 'EDICION'
    AND COLUMN_NAME = 'ID';

-- Verificar si la longitud del ID de edición supera el máximo permitido
IF LENGTH(p_id_edicionAux) > p_maxLength_idEdicion THEN RAISE VALUE_ERROR;

END IF;

-- Verificar si existe una edición con el ID proporcionado
SELECT
    COUNT(*) INTO p_countAux
FROM
    EDICION
WHERE
    ID = p_id_edicionAux;

IF p_countAux = 0 THEN RAISE NO_DATA_FOUND;

END IF;

-- Verificar si ya existe un ejemplar para esta edición
SELECT
    COUNT(*) INTO p_countAux
FROM
    EJEMPLAR
WHERE
    ID_EDICION = p_id_edicionAux
    AND ALTA IS NOT NULL
    AND (
        BAJA IS NULL
        OR BAJA > SYSDATE
    );

IF p_countAux = 1 THEN RAISE DATA_EXISTS;

END IF;

-- Obtener el número de ejemplares de la misma edición
SELECT
    COUNT(*) INTO p_countAux
FROM
    EJEMPLAR
WHERE
    ID_EDICION = p_id_edicionAux;

IF p_countAux = 0 THEN p_Numero := 1;

ELSE p_Numero := p_countAux + 1;

END IF;

-- Insertar el nuevo ejemplar en la tabla EJEMPLAR
INSERT INTO
    EJEMPLAR (ID_EDICION, NUMERO, ALTA, BAJA)
VALUES
    (p_id_edicionAux, p_Numero, SYSDATE, NULL);

RETURN 1;

-- Indicar que se ha insertado correctamente
EXCEPTION
WHEN VALUE_ERROR THEN RETURN -2;

-- Error debido a la longitud del ID de edición
WHEN NO_DATA_FOUND THEN RETURN 0;

-- No se encontró la edición con el ID proporcionado
WHEN DATA_EXISTS THEN RETURN -3;

-- Ya existe un ejemplar para esta edición
WHEN OTHERS THEN RETURN -1;

-- Otro tipo de error
END;

/ FUNCTION borrado_ejemplar (p_id_edicion VARCHAR, p_numero INTEGER) RETURN INTEGER IS p_countAux NUMBER(3);

p_maxLength_idEdicion NUMBER(6);

p_id_edicionAux EDICION.ID % TYPE;

p_numeroAux EJEMPLAR.NUMERO % TYPE;

p_numeroMaximo EJEMPLAR.NUMERO % TYPE;

BEGIN p_id_edicionAux := TRIM(p_id_edicion);

p_numeroAux := TRIM(p_numero);

SELECT
    MAX(char_length) INTO p_maxLength_idEdicion
FROM
    USER_TAB_COLUMNS
WHERE
    TABLE_NAME = 'EDICION'
    AND COLUMN_NAME = 'ID';

IF LENGTH(p_id_edicionAux) > p_maxLength_idEdicion THEN RAISE VALUE_OUT_OF_RANGE;

END IF;

SELECT
    COUNT(*) INTO p_countAux
FROM
    EJEMPLAR
WHERE
    ID_EDICION = p_id_edicionAux
    AND NUMERO = p_numeroAux;

IF p_countAux = 0 THEN RAISE NO_DATA_FOUND;

END IF;

SELECT
    NUMERO INTO p_numeroMaximo
FROM
    EJEMPLAR
WHERE
    ID_EDICION = p_id_edicionAux
    AND BAJA IS NULL
    AND ABS(SYSDATE - ALTA) < 30
ORDER BY
    NUMERO DESC
FETCH FIRST
    1 ROWS ONLY;

IF SQL % ROWCOUNT = 0 THEN RAISE NO_DATA_FOUND;

END IF;

IF p_numero = p_numeroMaximo THEN
DELETE FROM
    EJEMPLAR
WHERE
    ID_EDICION = p_id_edicionAux
    AND NUMERO = p_numero;

RETURN 1;

ELSE RAISE FAILURE_TO_MEET_REQUIREMENTS;

END IF;

EXCEPTION
WHEN NO_DATA_FOUND THEN RETURN 0;

WHEN FAILURE_TO_MEET_REQUIREMENTS THEN RETURN -1;

WHEN OTHERS THEN RETURN -2;

END;

FUNCTION baja_ejemplar (p_id_edicion VARCHAR, p_numero INTEGER) RETURN INTEGER IS p_countAux NUMBER(3);

p_maxLength_idEdicion NUMBER(6);

p_id_edicionAux EDICION.ID % TYPE;

BEGIN
SELECT
    MAX(char_length) INTO p_maxLength_idEdicion
FROM
    USER_TAB_COLUMNS
WHERE
    TABLE_NAME = 'EDICION'
    AND COLUMN_NAME = 'ID';

IF LENGTH(TRIM(p_id_edicion)) > p_maxLength_idEdicion THEN RAISE VALUE_OUT_OF_RANGE;

END IF;

p_id_edicionAux := TRIM(p_id_edicion);

SELECT
    COUNT(*) INTO p_countAux
FROM
    EJEMPLAR
WHERE
    ID_EDICION = p_id_edicionAux
    AND NUMERO = p_numero;

IF p_countAux = 0 THEN RAISE NO_DATA_FOUND;

END IF;

SELECT
    COUNT(*) INTO p_countAux
FROM
    EJEMPLAR
WHERE
    ID_EDICION = p_id_edicionAux
    AND NUMERO = p_numero
    AND BAJA IS NULL;

IF p_countAux = 1 THEN
UPDATE
    EJEMPLAR
SET
    BAJA = SYSDATE
WHERE
    ID_EDICION = p_id_edicionAux
    AND NUMERO = p_numero;

RETURN 1;

ELSE RAISE FAILURE_TO_MEET_REQUIREMENTS;

END IF;

EXCEPTION
WHEN NO_DATA_FOUND THEN RETURN 0;

WHEN FAILURE_TO_MEET_REQUIREMENTS THEN RETURN -1;

WHEN VALUE_OUT_OF_RANGE THEN RETURN -3;

WHEN OTHERS THEN RETURN -2;

END;

END BiblioTK;

/