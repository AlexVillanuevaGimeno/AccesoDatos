CREATE OR REPLACE FUNCTION anios_dif (
fecha1 DATE,
fecha2 DATE)
RETURN NUMBER
AS
v_anios_dif NUMBER(6);
BEGIN
v_anios_dif := ABS(TRUNC(MONTHS_BETWEEN(fecha2,fecha1)
/ 12));
RETURN v_anios_dif;
END anios_dif;