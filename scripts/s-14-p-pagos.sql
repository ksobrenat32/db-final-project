--@Autor(es): Enrique Job Calderón Olalde <@ksobrenat32>, Erick Nava Santiago
--@Fecha creación: 1 de diciembre de 2024
--@Descripción: prueba para los pagos 

SET SERVEROUTPUT ON;
BEGIN 
  --PRUEBA 1: CASO EN EL QUE SE LOGRAN INGRESAR DE MANERA CORRECTA LOS REGISTROS
  BEGIN 
    BEGIN
      DBMS_OUTPUT.PUT_LINE('INGRESANDO 5 PAGOS');
      sp_creacion_pagos('MNO345', 5, 2500, 7);

      --mostrando resultados 
      FOR r IN (SELECT * FROM pago WHERE usuario_id = (
        SELECT usuario_id 
        FROM usuario_conductor
        WHERE num_licencia = 'MNO345'
      )) LOOP
        DBMS_OUTPUT.PUT_LINE('Pago Folio: ' || r.folio || ', Fecha: ' || r.fecha || ', Monto: ' || r.monto_total);
      END LOOP;
 
    EXCEPTION
      WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error en PRUEBA 1: ' || SQLERRM);
    END;
  END;

  --PRUEBA 2: CASO EN EL QUE NO SE TENIA NINGUN PAGO PREVIO
  BEGIN 
    BEGIN
      DELETE FROM pago WHERE usuario_id = (
        SELECT usuario_id 
        FROM usuario_conductor
        WHERE num_licencia = 'MNO345'
      );
      DBMS_OUTPUT.PUT_LINE('INGRESANDO 1 PAGO');
      sp_creacion_pagos('MNO345', 2, 8000, 1);
     --mostrando resultados 
      --mostrando resultados 
      FOR r IN (SELECT * FROM pago WHERE usuario_id = (
        SELECT usuario_id 
        FROM usuario_conductor
        WHERE num_licencia = 'MNO345'
      )) LOOP
        DBMS_OUTPUT.PUT_LINE('Pago Folio: ' || r.folio || ', Fecha: ' || r.fecha || ', Monto: ' || r.monto_total);
      END LOOP;


    EXCEPTION
      WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error en PRUEBA 2: ' || SQLERRM);
    END;
  END;

  --PRUEBA 3: CASO EN EL QUE EL USUARIO NO SE LOGRA ENCONTRAR
  BEGIN 
    BEGIN
      DBMS_OUTPUT.PUT_LINE('INGRESANDO 5 PAGOS');
      sp_creacion_pagos('AAAA', 5, 1, 7);
    EXCEPTION
      WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error en PRUEBA 3: ' || SQLERRM);
    END;
  END;

END;
/
SHOW ERRORS;
