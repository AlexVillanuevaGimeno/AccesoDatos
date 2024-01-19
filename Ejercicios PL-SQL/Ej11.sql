CREATE OR REPLACE
PROCEDURE modificar_localidad(
num_depart NUMBER,
localidad VARCHAR2)
AS
BEGIN
UPDATE depart SET loc = localidad
WHERE dept_no = num_depart;
END modificar_localidad;
