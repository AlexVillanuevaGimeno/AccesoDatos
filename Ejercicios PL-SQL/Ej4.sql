EJ4
  CREATE OR REPLACE FUNCTION ExtractYear(dateAux DATE) RETURN NUMBER
  IS
      year NUMBER;
  BEGIN
      year := EXTRACT(YEAR FROM dateAux);
    RETURN year;
  END ExtractYear;
  /


