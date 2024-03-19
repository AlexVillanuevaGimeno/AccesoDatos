--al insertar si una ccoluimna no puede ser nula
CREATE OR REPLACE TRIGGER before_insert_trigger
BEFORE INSERT ON your_table
FOR EACH ROW
DECLARE
    -- Declaración de excepción personalizada
    custom_exception EXCEPTION;
BEGIN
    -- Verificar si la condición de inserción se cumple
    IF :NEW.column1 IS NULL THEN
        -- Lanzar la excepción personalizada si la condición no se cumple
        RAISE custom_exception;
    END IF;
EXCEPTION
    -- Capturar la excepción personalizada y manejarla
    WHEN custom_exception THEN
        -- Manejo de la excepción: aquí puedes registrar, manejar o lanzar otra excepción
        DBMS_OUTPUT.PUT_LINE('No se puede realizar la inserción: valor nulo en column1');
        -- Puedes optar por permitir o evitar la inserción dependiendo del caso
        RAISE; -- Esto evitará la inserción
END;
/

--VALORES DUPLICADOS
CREATE OR REPLACE TRIGGER before_insert_trigger
BEFORE INSERT ON your_table
FOR EACH ROW
BEGIN
    -- Verificar si el valor a insertar ya existe en la tabla
    IF EXISTS (
        SELECT 1 FROM your_table WHERE column1 = :NEW.column1
    ) THEN
        -- Lanzar una excepción personalizada
        RAISE_APPLICATION_ERROR(-20001, 'No se puede realizar la inserción: valor duplicado en column1');
    END IF;
EXCEPTION
    -- Capturar la excepción de violación de clave primaria
    WHEN DUP_VAL_ON_INDEX THEN
        -- Manejo de la excepción: puedes proporcionar un mensaje personalizado o realizar acciones adicionales
        RAISE_APPLICATION_ERROR(-20002, 'No se puede realizar la inserción: valor duplicado en la clave primaria');
END;
/
