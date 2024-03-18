SET SERVEROUTPUT ON
rem Procedimiento que recibe el número de dpto y el porcentaje a incrementar 
rem y sube el sueldo a TODOS los empleados de ese dpto dado.

DROP PROCEDURE actualiza_salario_emple_por_dpto;

CREATE OR REPLACE PROCEDURE actualiza_salario_emple_por_dpto(dept VARCHAR2, subida NUMBER) AS
  CURSOR v_cur1 IS 
    SELECT * FROM EMPLE
    WHERE dept_no = dept FOR UPDATE;

  v_emple EMPLE%ROWTYPE;
  v_inc EMPLE.SALARIO%TYPE;

BEGIN
  OPEN v_cur1;
  FETCH v_cur1 INTO v_emple;
  WHILE v_cur1%FOUND LOOP
    DBMS_OUTPUT.PUT_LINE('Empleado '||v_emple.emp_no||' '||v_emple.apellido);
    DBMS_OUTPUT.PUT_LINE('con salario '||v_emple.salario||' modificado a ');
    v_inc := v_emple.salario + ((v_emple.salario*subida)/100);
    DBMS_OUTPUT.PUT_LINE('nuevo salario '||v_inc);
    UPDATE EMPLE SET salario = v_inc WHERE CURRENT OF v_cur1;
    FETCH v_cur1 INTO v_emple;
  END LOOP;
  DBMS_OUTPUT.PUT_LINE('');
  DBMS_OUTPUT.PUT_LINE(v_cur1%ROWCOUNT||' EMPLEADOS LISTADOS');
  CLOSE v_cur1;
  COMMIT;
END;