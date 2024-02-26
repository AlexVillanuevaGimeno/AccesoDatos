--ej1
CREATE TABLE auditaremple (
    col1 VARCHAR2(200)
);

CREATE OR REPLACE TRIGGER auditar_act_emp
BEFORE INSERT OR DELETE
ON emple
FOR EACH ROW
BEGIN
    IF DELETING THEN
        INSERT INTO auditaremple
        VALUES(TO_CHAR(sysdate,'DD/MM/YY*HH24:MI*') || :OLD.EMP_NO || '*' || :OLD.APELLIDO || '* BORRADO ');
    ELSIF INSERTING THEN
        INSERT INTO auditaremple
        VALUES(TO_CHAR(sysdate,'DD/MM/YY*HH24:MI*') || :NEW.EMP_NO || '*' || :NEW.APELLIDO || '* INSERCION ');
    END IF;
END;
