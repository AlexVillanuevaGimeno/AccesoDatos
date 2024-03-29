--ej3
CREATE VIEW DEPARTAM AS
SELECT DEPART.DEPT_NO, DNOMBRE, LOC, COUNT(EMP_NO) TOT_EMPLE
FROM EMPLE, DEPART
WHERE EMPLE.DEPT_NO (+) = DEPART.DEPT_NO
GROUP BY DEPART.DEPT_NO, DNOMBRE, LOC;


CREATE OR REPLACE TRIGGER ges_depart
INSTEAD OF DELETE OR INSERT OR UPDATE
ON DEPARTAM
FOR EACH ROW
BEGIN
    IF DELETING THEN
        DELETE FROM depart WHERE dept_no = :old.dept_no;
    ELSIF INSERTING THEN
        INSERT INTO depart VALUES(:new.dept_no, :new.dnombre, :new.loc);
    ELSIF UPDATING('loc') THEN
        UPDATE depart SET loc = :new.loc WHERE dept_no = :old.dept_no;
    ELSE
        RAISE_APPLICATION_ERROR(-20001, 'Error en la actualización');
    END IF;
END;