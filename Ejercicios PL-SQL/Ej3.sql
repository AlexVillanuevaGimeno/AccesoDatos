EJ3:

EJ3.1
  CREATE OR REPLACE FUNCTION AddNumbers(Number1 INT, Number2 INT) RETURN NUMBER
  IS
      TotalNumber INT;
  BEGIN
    TotalNumber := Number1 + Number2;
      RETURN TotalNumber;
  END AddNumbers;
  /

  DECLARE
      TotalNumber NUMBER;
  BEGIN
      TotalNumber := AddNumbers(3,4);
      DBMS_OUTPUT.PUT_LINE('TOTAL NUMBER:: ' || TotalNumber);
  END;
  /

EJ3.2
  CREATE OR REPLACE FUNCTION InvertString(text VARCHAR2) RETURN VARCHAR2
  IS
      InvertedText VARCHAR2(32767);
  BEGIN
    FOR i IN REVERSE 1..LENGTH(text)
      LOOP
        InvertedText := InvertedText || SUBSTR(text, i, 1);
      END LOOP;

      RETURN InvertedText;
  END InvertString;
  /

  DECLARE
      text VARCHAR2(50);
  BEGIN
      text := InvertString('hola');
      DBMS_OUTPUT.PUT_LINE('TOTAL NUMBER:: ' || text);
  END;
  /



