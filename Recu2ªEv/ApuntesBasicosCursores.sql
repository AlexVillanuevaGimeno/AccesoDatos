--RECORRER Y MOSTRAR RESULTADOS
DECLARE
    -- Declaración del cursor explícito
    CURSOR cursor_name IS
        SELECT column1, column2 FROM table_name;
    -- Declaración de variables para almacenar los valores recuperados
    var_column1 table_name.column1%TYPE;
    var_column2 table_name.column2%TYPE;
BEGIN
    -- Abrir el cursor
    OPEN cursor_name;
    -- Recorrer y mostrar resultados
    LOOP
        FETCH cursor_name INTO var_column1, var_column2;
        EXIT WHEN cursor_name%NOTFOUND;
        -- Procesamiento de la fila
        DBMS_OUTPUT.PUT_LINE('Column1: ' || var_column1 || ', Column2: ' || var_column2);
    END LOOP;
    -- Cerrar el cursor
    CLOSE cursor_name;
END;

--ACTUALIZACION DE VALORES EN BASE A LOS RESULTADOS DEL CURSOR
DECLARE
    CURSOR cursor_name IS
        SELECT column1, column2 FROM table_name FOR UPDATE;
    var_column1 table_name.column1%TYPE;
    var_column2 table_name.column2%TYPE;
BEGIN
    OPEN cursor_name;
    LOOP
        FETCH cursor_name INTO var_column1, var_column2;
        EXIT WHEN cursor_name%NOTFOUND;
        -- Procesamiento de la fila
        UPDATE table_name
        SET column3 = var_column1 + var_column2
        WHERE CURRENT OF cursor_name;
    END LOOP;
    CLOSE cursor_name;
END;

--UTILIZANDO UN PARAMETRO DE ENTRADA
CREATE OR REPLACE PROCEDURE process_employee(p_department_id IN NUMBER) AS
    CURSOR cursor_name IS
        SELECT employee_id, employee_name
        FROM employees
        WHERE department_id = p_department_id;
    var_employee_id employees.employee_id%TYPE;
    var_employee_name employees.employee_name%TYPE;
BEGIN
    OPEN cursor_name;
    LOOP
        FETCH cursor_name INTO var_employee_id, var_employee_name;
        EXIT WHEN cursor_name%NOTFOUND;
        -- Procesamiento de la fila
        DBMS_OUTPUT.PUT_LINE('Employee ID: ' || var_employee_id || ', Name: ' || var_employee_name);
    END LOOP;
    CLOSE cursor_name;
END process_employee;
