CREATE OR REPLACE FUNCTION sust_por_blancos(
cad VARCHAR2)
RETURN VARCHAR2
AS
nueva_cad VARCHAR2(30);
car CHARACTER;
BEGIN
FOR i IN 1..LENGTH(cad) LOOP
car:=SUBSTR(cad,i,1);
IF (ASCII(car) NOT BETWEEN 65 AND 90)
AND (ASCII(car) NOT BETWEEN 97 AND 122) THEN
car :=' ';
END IF;
nueva_cad := nueva_cad || car;
END LOOP;
RETURN nueva_cad;
END sust_por_blancos;