--ej2
CREATE OR REPLACE TRIGGER audit_modif
BEFORE UPDATE ON EMPLE
FOR EACH ROW
DECLARE
    v_cad_inser VARCHAR2(4000);
BEGIN
    v_cad_inser := TO_CHAR(sysdate,'DD/MM/YY*HH24:MI*') || '*' || :OLD.EMP_NO || '* MODIFICACION *';

    IF UPDATING ('EMP_NO') THEN
        v_cad_inser := v_cad_inser || ': ' || :OLD.EMP_NO || ' -> ' || :NEW.EMP_NO || ', ';
    END IF;

    IF UPDATING ('APELLIDO') THEN
        v_cad_inser := v_cad_inser || ': ' || :OLD.APELLIDO || ' -> ' || :NEW.APELLIDO || ', ';
    END IF;

    IF UPDATING ('OFICIO') THEN
        v_cad_inser := v_cad_inser || ': ' || :OLD.OFICIO || ' -> ' || :NEW.OFICIO || ', ';
    END IF;

    IF UPDATING ('DIR') THEN
        v_cad_inser := v_cad_inser || ': ' || :OLD.DIR || ' -> ' || :NEW.DIR || ', ';
    END IF;

    IF UPDATING ('FECHA_ALT') THEN
        v_cad_inser := v_cad_inser || ': ' || TO_CHAR(:OLD.FECHA_ALT, 'DD/MM/YYYY') || ' -> ' || TO_CHAR(:NEW.FECHA_ALT, 'DD/MM/YYYY') || ', ';
    END IF;

    IF UPDATING ('SALARIO') THEN
        v_cad_inser := v_cad_inser || ': ' || :OLD.SALARIO || ' -> ' || :NEW.SALARIO || ', ';
    END IF;

    IF UPDATING ('COMISION') THEN
        v_cad_inser := v_cad_inser || ': ' || :OLD.COMISION || ' -> ' || :NEW.COMISION || ', ';
    END IF;

    IF UPDATING ('DEPT_NO') THEN
        v_cad_inser := v_cad_inser || ': ' || :OLD.DEPT_NO || ' -> ' || :NEW.DEPT_NO || ', ';
    END IF;

    -- Elimina la última coma y espacio si hay al final de la cadena
    IF SUBSTR(v_cad_inser, -2) = ', ' THEN
        v_cad_inser := SUBSTR(v_cad_inser, 1, LENGTH(v_cad_inser) - 2);
    END IF;

    INSERT INTO AUDITAREMPLE VALUES(v_cad_inser);
END;