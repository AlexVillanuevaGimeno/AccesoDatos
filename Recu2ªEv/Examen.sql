--1 Gestionemos la introducción de socios y préstamos 
--(tanto apertura como cierre) a través de funciones de servidor que gestionen los posibles errores.





Create Table socio (
    id_socio CHAR(4),
    nombre VARCHAR2(30),
    apellidos VARCHAR2(60),
    nacimiento DATE,
    CONSTRAINT PK_socio PRIMARY KEY (id_socio)
);
CREATE OR REPLACE FUNCTION alta_socio (p_nombre VARCHAR2, p_apellidos VARCHAR2, p_nacimiento DATE) RETURN VARCHAR2 IS
    p_id_socio VARCHAR2(4); -- Corregido el tamaño del campo id_socio
    p_count INTEGER;
BEGIN
    IF LENGTH(p_nombre) > 30 THEN
        RAISE_APPLICATION_ERROR(-20004, 'La longitud del nombre excede el límite permitido.');
    END IF;
    
    IF LENGTH(p_apellidos) > 60 THEN
        RAISE_APPLICATION_ERROR(-20005, 'La longitud de los apellidos excede el límite permitido.');
    END IF;
    
    LOOP
        p_id_socio := DBMS_RANDOM.STRING('X', 4); -- Corregido el tamaño del campo id_socio
        -- GENERAR ID ALEATORIA PARA SOCIO
        BEGIN
            SELECT COUNT(*) INTO p_count
            FROM socio
            WHERE id_socio = p_id_socio;
            
            EXIT WHEN p_count = 0; -- Salir del bucle si se encuentra un ID único
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                -- INSERTAR SOCIO CON ID ÚNICO
                BEGIN
                    INSERT INTO socio (id_socio, nombre, apellidos, nacimiento)
                    VALUES (p_id_socio, p_nombre, p_apellidos, p_nacimiento);
                    RETURN p_id_socio;
                EXCEPTION
                --no deberia llegar ya que hay un bucle para generar un id unico
                    WHEN DUP_VAL_ON_INDEX THEN
                        RAISE_APPLICATION_ERROR(-20006, 'El ID generado ya existe en la tabla socio.');
                    WHEN OTHERS THEN
                        RAISE_APPLICATION_ERROR(-20002, 'Error al insertar datos en la tabla socio.');
                END;
            WHEN OTHERS THEN
                RAISE_APPLICATION_ERROR(-20001, 'Error inesperado durante la generación de ID único.');
        END;
    END LOOP;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20003, 'La tabla socio no existe.');
    WHEN OTHERS THEN
        RETURN '-1'; -- Manejar cualquier excepción devolviendo '-1'
END;
/




CREATE TABLE prestamo(
    id_prestamo CHAR(4),
    id_socio CHAR(4),
    id_obra CHAR(4),
    fecha_apertura DATE,
    fecha_cierre DATE
    CONSTRAINT PK_prestamo PRIMARY KEY (id_prestamo),
    CONSTRAINT FK_prestamo_id_socio FOREIGN KEY (id_socio) REFERENCES socio(id_socio),
    CONSTRAINT FK_prestamo_id_obra FOREIGN KEY (id_obra) REFERENCES obra(id_obra)
);

CREATE OR REPLACE FUNCTION alta_prestamo (p_id_socio CHAR, p_id_obra CHAR, p_fecha_apertura DATE)
RETURN VARCHAR2 IS
    p_id_prestamo VARCHAR2(5);
    p_count INTEGER;
BEGIN
    LOOP
        p_id_prestamo := DBMS_RANDOM.STRING('X', 5); -- Generar ID aleatorio para prestamo
        BEGIN
            SELECT COUNT(*) INTO p_count
            FROM prestamo
            WHERE id_prestamo = p_id_prestamo;
            
            EXIT WHEN p_count = 0; -- Salir del bucle si se encuentra un ID único
        EXCEPTION 
            WHEN NO_DATA_FOUND THEN
                -- Insertar préstamo con ID único
                BEGIN
                    INSERT INTO prestamo (id_prestamo, id_socio, id_obra, fecha_apertura)
                    VALUES (p_id_prestamo, p_id_socio, p_id_obra, p_fecha_apertura);
                    RETURN p_id_prestamo;
                EXCEPTION 
                    WHEN DUP_VAL_ON_INDEX THEN
                        RAISE_APPLICATION_ERROR(-20006, 'El ID generado ya existe en la tabla prestamo.');
                    WHEN OTHERS THEN
                        RAISE_APPLICATION_ERROR(-20002, 'Error al insertar datos en la tabla prestamo.');
                END;
            WHEN OTHERS THEN
                RAISE_APPLICATION_ERROR(-20001, 'Error inesperado durante la generación de ID único.');
        END;
    END LOOP;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20003, 'La tabla prestamo no existe.');
    WHEN OTHERS THEN
        RETURN '-1';
END;
/




--2 Auditemos cualquier borrado de socios y/o préstamos a través de triggers.
CREATE TABLE socio_audit(
    id NUMBER GENERATED ALWAYS AS IDENTITY START WITH 1 INCREMENT BY 1,
    id_socio CHAR(4) UNIQUE NOT NULL,
    nombre VARCHAR2(30),
    apellidos VARCHAR2(60),
    nacimiento DATE,
    borrado_en TIMESTAMP WITH TIME ZONE
);

CREATE OR REPLACE TRIGGER auditar_borrado_socio
BEFORE DELETE ON SOCIO
FOR EACH ROW
BEGIN
    IF :OLD.nacimiento > SYSDATE THEN
        DBMS_OUTPUT.PUT_LINE('La fecha de nacimiento es posterior a la fecha actual. No se puede realizar el borrado.');
        -- Puedes optar por lanzar una excepción personalizada o tomar otras medidas según tus necesidades.
    ELSE
        BEGIN
            INSERT INTO c##root.socio_audit(id_socio, nombre, apellidos, nacimiento, borrado_en)
            VALUES(:OLD.id_socio, :OLD.nombre, :OLD.apellidos, :OLD.nacimiento, SYSTIMESTAMP);
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                DBMS_OUTPUT.PUT_LINE('No se encontraron datos para auditar el borrado.');
            WHEN DUP_VAL_ON_INDEX THEN
                DBMS_OUTPUT.PUT_LINE('Se intentó insertar un valor duplicado en la columna id_socio de la tabla socio_audit.');
            WHEN OTHERS THEN
                DBMS_OUTPUT.PUT_LINE('Error inesperado: ' || SQLERRM);
        END;
    END IF;
END;
/



CREATE TABLE prestamo_audit(
    id NUMBER GENERATED ALWAYS AS IDENTITY START WITH 1 INCREMENT BY 1,
    id_prestamo CHAR(4), UNIQUE NOT NULL,
    id_socio CHAR(4),
    id_obra CHAR(4),
    fecha_apertura DATE,
    fecha_cierre DATE,
    borrado_en TIMESTAMP WITH TIME ZONE
);

CREATE OR REPLACE TRIGGER auditar_borrado_prestamo
BEFORE DELETE ON PRESTAMO
FOR EACH ROW 
BEGIN
    INSERT INTO c##root.prestamo_audit(id_prestamo, id_socio, id_obra, fecha_apertura, fecha_cierre, borrado_en)
    VALUES (:OLD.id_prestamo, :OLD.id_socio, :OLD.id_obra, :OLD.fecha_apertura, :OLD.fecha_cierre, SYSTIMESTAMP);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No se encontraron datos para auditar el borrado del prestamo.');
    WHEN DUP_VAL_ON_INDEX THEN
        DBMS_OUTPUT.PUT_LINE('Se intentó insertar un valor duplicado en la tabla prestamo_audit.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error inesperado: ' || SQLERRM);
END;
/


-- 3 Para los cierres de préstamos debemos controlar que se realizan en la fecha correcta,
-- que será la de inicio de préstamo más como máximo una semana,
-- de modo que si se sobrepasa este límite se incluya una anotación en una nueva tabla llamada “sanciones” 
--que incluya el número de socio, la fecha de la sanción, el préstamo asociado a la sanción y un tipo de sanción que variará dependiendo de:
	--  Si el retraso es inferior a 7 días, es decir, la fecha en que se debería de haber devuelto el libro + esos 7 días, la sanción será de una semana en la cual no se podrá pedir ningún préstamo nuevo,
    -- y será considerada falta leve.
	--  Si el retraso es de 8 a 30 días, sanción será de un més en el cual no se podrá pedir ningún préstamo nuevo, y será considerada falta grave.
	--  Si el retraso es de más de 30 días, la sanción será de tres meses en los cuales no se podrá pedir ningún préstamo nuevo, y será considerada falta muy grave.

CREATE TABLE SANCIONES(
    id_sancion NUMBER GENERATED ALWAYS AS IDENTITY START WITH 1 INCREMENT BY 1,
    id_socio CHAR(4) NOT NULL,
    id_prestamo CHAR(4) NOT NULL,
    fecha_sancion DATE,
    tipo INTEGER NOT NULL
);

--añadirle al prestamo una fecha de cierre
--comprobar el tiempo que ha pasado
--añadir una sancion en caso que sea necesario
CREATE OR REPLACE FUNCTION cierre_prestamo(
    p_id_prestamo VARCHAR2
    ) RETURN INTEGER is p_count;
    BEGIN 
    --SACO LA FECHA DE APERTURA DEL PRESTAMO QUE ESTOY CERRANDO
    SELECT fecha_apertura INTO p_fecha_apertura FROM PRESTAMO WHERE id_prestamo = p_id_prestamo;
    --SACO EL ID DEL SOCIO QUE SE CIERRA EL PRESTAMO 
    SELECT id_socio INTO p_id_socio FROM prestamo WHERE id_prestamo = p_id_prestamo;
    --HAGO EL UPDATE PARA CERRA ENL PRESTAMO Y PONER SU FECHA
    UPDATE PRESTAMO SET fecha_cierre = SYSDATE WHERE id_prestamo = p_id_prestamo;
    --COMPROBACIONES DE SANCIONES
    IF fecha_cierre > p_fecha_apertura + 7 AND fecha_cierre < p_fecha_apertura + 15
    THEN 
    INSERT INTO SANCIONES (id_socio, id_prestamo, fecha_sancion, tipo)
    --INSERTO LA SABNCION CON SUS VALORES CORRESPONDIENTES
    --TIPO 1  CORRESPONDE A SANCION LEVE
    VALUES(p_id_socio, p_id_prestamo, SYSDATE, 1)
    DBMS_OUTPUT.PUT_LINE("ENTREGADO CON RETRASO FALTA LEVE");
    END IF;
    IF fecha_cierre > p_fecha_apertura + 14 AND fecha_cierre < p_fecha_apertura + 38
    THEN 
    INSERT INTO SANCIONES (id_socio, id_prestamo, fecha_sancion, tipo)
    --INSERTO LA SABNCION CON SUS VALORES CORRESPONDIENTES
    --TIPO 2  CORRESPONDE A SANCION GRAVE
    VALUES(p_id_socio, p_id_prestamo, SYSDATE, 2)
    DBMS_OUTPUT.PUT_LINE("ENTREGADO CON RETRASO FALTA GRAVE");
    END IF;
    IF fecha_cierre > p_fecha_apertura + 37 
    THEN 
    INSERT INTO SANCIONES (id_socio, id_prestamo, fecha_sancion, tipo)
    --INSERTO LA SABNCION CON SUS VALORES CORRESPONDIENTES
    --TIPO 3  CORRESPONDE A SANCION MUY GRAVE
    VALUES(p_id_socio, p_id_prestamo, SYSDATE, 3)
    DBMS_OUTPUT.PUT_LINE("ENTREGADO CON RETRASO FALTA MUY GRAVE");
    END IF;
EXCEPTION
WHEN OTHERS THEN RETURN -1;
END;
/

--4 Modificar la función de apertura de préstamos para que se apliquen las sanciones mencionadas en el punto anterior de modo 
--que cuando se intente realizar un préstamo el sistema lo impida si estamos en un periodo de sanción de ese socio. 
--Además si un socio tiene más de tres faltas muy graves se le impedirá de por vida poder coger nuevos libros prestados en nuestra biblioteca.
--En cualquiera de los casos anteriores nuestro sistema deberá impedir realizar un préstamo de un libro a alguien que tenga estas sanciones asociadas. 
--El sistema dará error por pantalla indicando el motivo y no realizará la inserción de datos del préstamo que se está intentando realizar.

CREATE OR REPLACE FUNCTION alta_prestamo (p_id_socio CHAR, p_id_obra CHAR, p_fecha_apertura DATE)
RETURN VARCHAR2 IS
    v_id_prestamo VARCHAR2(5);
    v_count INTEGER;
    v_num_sanciones INTEGER := 0;
    v_num_sanciones_graves INTEGER := 0;
    v_fecha_sancion DATE;
    v_fecha_validez DATE;

    CURSOR cur_sanciones IS 
        SELECT COUNT(*) AS num_sanciones, 
               SUM(CASE WHEN tipo = 3 THEN 1 ELSE 0 END) AS num_sanciones_graves,
               MAX(fecha_sancion) AS fecha_sancion, 
               MAX(CASE WHEN tipo = 1 THEN fecha_sancion + 7 
                        WHEN tipo = 2 THEN fecha_sancion + 30 
                        WHEN tipo = 3 THEN fecha_sancion + 90 END) AS fecha_validez
        FROM SANCIONES
        WHERE id_socio = p_id_socio;

BEGIN 
    BEGIN
        FOR sancion_rec IN cur_sanciones LOOP
            v_num_sanciones := sancion_rec.num_sanciones;
            v_num_sanciones_graves := sancion_rec.num_sanciones_graves;
            v_fecha_sancion := sancion_rec.fecha_sancion;
            v_fecha_validez := sancion_rec.fecha_validez;
        END LOOP;
        
        IF v_num_sanciones_graves >= 3 THEN
            DBMS_OUTPUT.PUT_LINE('El usuario ' || p_id_socio || ' tiene tres o más faltas muy graves. No puede solicitar préstamos para siempre.');
            RETURN '-1';
        ELSIF v_num_sanciones > 0 THEN
            IF v_fecha_validez > v_fecha_sancion THEN
                v_fecha_real := v_fecha_validez;
            ELSE
                v_fecha_real := v_fecha_sancion;
            END IF;
            
            DBMS_OUTPUT.PUT_LINE('El usuario ' || p_id_socio || ' tiene una sanción vigente hasta ' || TO_CHAR(v_fecha_real, 'DD-MM-YYYY'));
            RETURN '-1';
        ELSE
            BEGIN
                SELECT COUNT(*) INTO v_count
                FROM socio
                WHERE id_socio = p_id_socio;

                IF v_count = 0 THEN
                    DBMS_OUTPUT.PUT_LINE('No se encontró un socio con ID ' || p_id_socio);
                    RETURN '-1';
                END IF;
            EXCEPTION
                WHEN NO_DATA_FOUND THEN
                    DBMS_OUTPUT.PUT_LINE('No se encontró un socio con ID ' || p_id_socio);
                    RETURN '-1';
            END;

            LOOP 
                v_id_prestamo := DBMS_RANDOM.STRING('X', 5);
                
                BEGIN
                    SELECT COUNT(*) INTO v_count
                    FROM prestamo
                    WHERE id_prestamo = v_id_prestamo;

                    EXIT WHEN v_count = 0;
                EXCEPTION 
                    WHEN NO_DATA_FOUND THEN EXIT;
                END;
            END LOOP;
            
            BEGIN
                INSERT INTO prestamo (id_prestamo, id_socio, id_obra, fecha_apertura)
                VALUES (v_id_prestamo, p_id_socio, p_id_obra, p_fecha_apertura);
            EXCEPTION
                WHEN DUP_VAL_ON_INDEX THEN
                    DBMS_OUTPUT.PUT_LINE('Error: El préstamo con ID ' || v_id_prestamo || ' ya existe.');
                    RETURN '-1';
                WHEN OTHERS THEN
                    DBMS_OUTPUT.PUT_LINE('Error al insertar el préstamo: ' || SQLERRM);
                    RETURN '-1';
            END;
            
            RETURN v_id_prestamo;
        END IF;
    EXCEPTION
        WHEN OTHERS THEN 
            DBMS_OUTPUT.PUT_LINE('Error inesperado: ' || SQLERRM);
            RETURN '-1';
    END;
END alta_prestamo;
/
