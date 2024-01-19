
EJ2:
  CREATE OR REPLACE PROCEDURE CadenaReversa(text VARCHAR2)
  IS
      CadenaReversaVARCHAR2(32767);
  BEGIN
      FOR i IN REVERSE 1..LENGTH(text)
      LOOP
        CadenaReversa:= CadenaReversa|| SUBSTR(text, i, 1);
      END LOOP;

    DBMS_OUTPUT.PUT_LINE('Inverted Text:: ' || CadenaReversa);
  END;
  /

  DECLARE
  BEGIN
      CadenaReversa(Alex);
  END;
  /

