--@Autor(es): Enrique Job Calderón Olalde <@ksobrenat32>, Erick Nava Santiago
--@Fecha creación: 1 de diciembre de 2024
--@Descripción: funcionamiento de las funciones declaradas


SET SERVEROUTPUT ON;

BEGIN
  -- Para la primera función
  BEGIN
    DBMS_OUTPUT.PUT_LINE(nombre_generico('Juan', 'Perez', 'Perez'));
    DBMS_OUTPUT.PUT_LINE(nombre_generico('JOB', 'Calderon', NULL));  
  END;

  -- Para la segunda función
  BEGIN
    DBMS_OUTPUT.PUT_LINE('Un viaje finalizado:');
    DBMS_OUTPUT.PUT_LINE(viajeDuracion(1));  
  END;

END;
/
SHOW ERRORS;
