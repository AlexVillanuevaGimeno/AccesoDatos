EJ5:
  DECLARE
    myDate DATE;
    myYear NUMBER;
  BEGIN
      myDate := TO_DATE('2023-11-22', 'YYYY-MM-DD');
    myYear := ExtractYear(myDate);
    DBMS_OUTPUT.PUT_LINE('Extracted Year:: ' || myYear);
  END;
  /

