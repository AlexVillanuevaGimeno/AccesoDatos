CREATE OR REPLACE PROCEDURE borrar_emple(
num_emple emple.emp_no%TYPE)
AS
BEGIN
DELETE FROM emple WHERE emp_no = num_emple;
END borrar_emple;
