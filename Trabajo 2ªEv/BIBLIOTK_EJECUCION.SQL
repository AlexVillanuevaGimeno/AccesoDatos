DECLARE BEGIN DBMS_OUTPUT.PUT_LINE(
    BiblioTK.alta_obra('Star Wars: A New Hope', 1977)
);

END;

/ DECLARE BEGIN DBMS_OUTPUT.PUT_LINE(BiblioTK.borrado_obra('4'));

END;

/ DECLARE BEGIN DBMS_OUTPUT.PUT_LINE(
    BiblioTK.alta_autor(
        'Jane',
        'Smith',
        TO_DATE('01/01/1985', 'DD/MM/YYYY')
    )
);

END;

/ DECLARE BEGIN DBMS_OUTPUT.PUT_LINE(BiblioTK.borrado_autor('3'));

END;

/ DECLARE BEGIN DBMS_OUTPUT.PUT_LINE(BiblioTK.vincular('1', '2'));

END;

/ DECLARE BEGIN DBMS_OUTPUT.PUT_LINE(BiblioTK.desvincular('1', '2'));

END;

/ DECLARE BEGIN DBMS_OUTPUT.PUT_LINE(
    BiblioTK.alta_edicion('ABC123', '978031298328', 2000)
);

END;

/ DECLARE BEGIN DBMS_OUTPUT.PUT_LINE(BiblioTK.borrado_edicion('5'));

END;

/ DECLARE BEGIN DBMS_OUTPUT.PUT_LINE(BiblioTK.alta_ejemplar('3'));

END;

/ DECLARE BEGIN DBMS_OUTPUT.PUT_LINE(BiblioTK.borrado_ejemplar('6', '3'));

END;

/ DECLARE BEGIN DBMS_OUTPUT.PUT_LINE(BiblioTK.baja_ejemplar('ABC123', '1'));

END;

/