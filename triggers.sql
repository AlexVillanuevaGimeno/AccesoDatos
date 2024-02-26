-- Trigger que controla la modificación de salarios de empleados a la baja
-- cada vez que a un empleado se le baje el sueldo se registrará en 
-- una tabla dde auditoría los datos del empleado y la fecha de la modificación

ALTER USER HR ACCOUNT UNLOCK;
ALTER USER HR IDENTIFIED BY HR;

-- A partir de aquí trabajamos con el usuario HR

CREATE TABLE emple_auditado (emp_no NUMBER(4), apellido VARCHAR2(10), 
      salario_viejo NUMBER(7), salario_nuevo NUMBER(7), fecha DATE);

CREATE OR REPLACE TRIGGER mod_emple BEFORE UPDATE ON emple FOR EACH ROW 
BEGIN
  IF (:new.salario <:old.salario) THEN
     INSERT INTO emple_auditado VALUES (:old.emp_no, :old.apellido, :old.salario, 
                    :new.salario, SYSDATE);
     COMMIT;
  END IF;
END;
/



