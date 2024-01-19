
EJ1:

  CREATE OR REPLACE PROCEDURE Suma(Numero1 INT, Numero2 INT)
  IS
    Total INT;
  BEGIN
    Total := Numero1 + Numero2;
    DBMS_OUTPUT.PUT_LINE('RESULT:: ' || Total);
  END Suma;
  /

  DECLARE
  BEGIN
  Suma(13,25);
  END;
  /
