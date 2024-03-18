CREATE OR REPLACE TRIGGER trg_delete_and_insert
AFTER DELETE ON tabla_origen
FOR EACH ROW
DECLARE
  v_count NUMBER;
BEGIN
  -- Verificar si hay datos a eliminar antes de insertar en la otra tabla
  SELECT COUNT(*) INTO v_count FROM tabla_origen WHERE primary_key_column = :OLD.primary_key_value;
  IF v_count = 0 THEN
    -- Manejar la excepción NO_DATA_FOUND
    RAISE_APPLICATION_ERROR(-20001, 'No se encontraron datos para eliminar en la tabla origen.');
  ELSE
    -- Insertar en la tabla destino
    INSERT INTO tabla_destino (column1, column2, ...)
    VALUES (:OLD.column1, :OLD.column2, ...);
  END IF;
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    -- Manejar la excepción NO_DATA_FOUND
    DBMS_OUTPUT.PUT_LINE('No se encontraron datos para eliminar en la tabla origen.');
  WHEN TOO_MANY_ROWS THEN
    -- Manejar la excepción TOO_MANY_ROWS
    DBMS_OUTPUT.PUT_LINE('Demasiadas filas encontradas al realizar la inserción en la tabla destino.');
  WHEN OTHERS THEN
    -- Manejar cualquier otra excepción no manejada explícitamente
    DBMS_OUTPUT.PUT_LINE('Ocurrió un error inesperado: ' || SQLERRM);
    -- Registrar el error en una tabla de registro de errores si es necesario
END;
/
