--ej 4
CREATE OR REPLACE PACKAGE gest_depart AS
PROCEDURE insert_depart
(v_nom_dep VARCHAR2,
v_loc VARCHAR2);
PROCEDURE borrar_depar
(v_dep_borrar NUMBER,
v_dep_nue NUMBER);
PROCEDURE cambiar_localidad
(v_num_dep NUMBER,
v_loc VARCHAR2);
PROCEDURE visualizar_datos_depart
(v_num_dep NUMBER);
PROCEDURE visualizar_datos_depart
(v_nom_dep VARCHAR2);
END gest_depart;
/

CREATE OR REPLACE PACKAGE BODY gest_depart AS
FUNCTION buscar_depart_por_nombre 
(v_nom_dep VARCHAR2)
RETURN NUMBER;

------------------
--BORRAR DEPART
PROCEDURE borrar_depar
(v_dep_borrar NUMBER,
v_dep_nue NUMBER)
AS
BEGIN
UPDATE emple SET dept_no = v_dep_nue
WHERE DEPT_NO=v_dep_borrar;
DELETE FROM depart WHERE dept_no = v_dep_borrar;
END borrar_depar;

------------------------
--VISUALIZAR DATOS DEPART
PROCEDURE visualizar_datos_depart
(v_num_dep NUMBER)
AS
vr_dep depart%ROWTYPE;
v_num_empleados NUMBER(4);
BEGIN
SELECT * INTO vr_dep FROM depart
WHERE DEPT_NO=v_num_dep;
SELECT COUNT(*) INTO v_num_empleados FROM
EMPLE WHERE DEPT_NO=v_num_dep;

DBMS_OUTPUT.PUT_LINE
('Número de departamento: '||vr_dep.dept_no);
DBMS_OUTPUT.PUT_LINE
('Nombre del departamento: '||vr_dep.dnombre);
DBMS_OUTPUT.PUT_LINE
('Localidad : '||vr_dep.loc);
DBMS_OUTPUT.PUT_LINE
('Numero de empleados : '||v_num_empleados);
EXCEPTION
WHEN NO_DATA_FOUND THEN
DBMS_OUTPUT.PUT_LINE('Err departamento no encontrado');
END visualizar_datos_depart;

----------------------
--CAMBIAR LOCALIDAD
PROCEDURE cambiar_localidad(
v_num_dep NUMBER,
v_loc VARCHAR2)
AS
BEGIN
UPDATE depart
SET LOC=v_loc
WHERE dept_no=v_num_dep;
EXCEPTION
WHEN NO_DATA_FOUND THEN
DBMS_OUTPUT.PUT_LINE('Err departamento no encontrado');
END cambiar_localidad;
END gest_depart;

---------------------
--VISUALIZAR DATOS (S0BRECARGADO)
PROCEDURE visualizar_datos_depart /* Versión sobrecargada */
(v_nom_dep VARCHAR2)
AS
v_num_dep depart.dept_no%TYPE;
vr_dep depart%ROWTYPE;
v_num_empleados NUMBER(4);
BEGIN
v_num_dep:=buscar_depart_por_nombre(v_nom_dep);
SELECT * INTO vr_dep FROM depart
WHERE dept_no=v_num_dep;
SELECT COUNT(*) INTO v_num_empleados FROM EMPLE
WHERE dept_no=v_num_dep;

DBMS_OUTPUT.PUT_LINE
('Número de departamento: '||vr_dep.dept_no);
DBMS_OUTPUT.PUT_LINE
('Nombre del departamento: '||vr_dep.dnombre);
DBMS_OUTPUT.PUT_LINE
('Localidad : '||vr_dep.loc);
DBMS_OUTPUT.PUT_LINE
('Numero de empleados : '||v_num_empleados);

EXCEPTION
WHEN NO_DATA_FOUND THEN
DBMS_OUTPUT.PUT_LINE('Err departamento no encontrado');
END visualizar_datos_depart;

----------------------
--INSERT DEPART
PROCEDURE insert_depart(
    v_nom_dep VARCHAR2,
    v_loc VARCHAR2
)
AS
    ultimo_dep DEPART.DEPT_NO%TYPE;
    nombre_repetido EXCEPTION;
BEGIN
    SELECT MAX(DEPT_NO) INTO ultimo_dep FROM DEPART;

    INSERT INTO DEPART VALUES (ultimo_dep + 10, v_nom_dep, v_loc);

EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        RAISE_APPLICATION_ERROR(-20001, 'Err. Nombre de departamento duplicado');
    WHEN NO_DATA_FOUND THEN
        INSERT INTO DEPART VALUES (10, v_nom_dep, v_loc);
END insert_depart;

------------------------
--BUSCAR DEPART POR NOMBRE
PROCEDURE buscar_depart_por_nombre(
    v_nom_dep VARCHAR2
)
RETURN NUMBER
AS
    v_num_dep depart.dept_no%TYPE;
BEGIN
    SELECT dept_no INTO v_num_dep FROM depart WHERE DNOMBRE = v_nom_dep;
    RETURN v_num_dep;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20001, 'Err departamento no encontrado');
END buscar_depart_por_nombre;