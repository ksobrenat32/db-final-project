--@Autor(es): Enrique Job Calderón Olalde <@ksobrenat32>, Erick Nava Santiago
--@Fecha creación: 8 de diciembre de 2024
--@Descripción: Se probara la asigancion de porcentajes
SET SERVEROUTPUT ON;
DECLARE
  v_por1 NUMBER; 
  v_por2 NUMBER; 
  v_por3 NUMBER;
  v_valido VARCHAR2(10000);
BEGIN 
  --PRUEBA1: PRUEBAS PARA CUANDO SE INGRESAN TODAS LAS TARJETAS Y UN PORCENTAJE QUE DE EL 100
  BEGIN
    v_por1 := 50; 
    v_por2 := 30; 
    v_por3 := 20;
    DBMS_OUTPUT.PUT_LINE('CASO 1: correcta');
    BEGIN
      sp_seleccion_tarjetas(1, v_por1, 2, v_por2, 3, v_por3, v_valido);
      DBMS_OUTPUT.PUT_LINE('Resultado: ' || v_valido);
      DBMS_OUTPUT.PUT_LINE('Porcentajes asignado: ');
      DBMS_OUTPUT.PUT_LINE('Tarjeta 1: '|| v_por1 || '%');
      DBMS_OUTPUT.PUT_LINE('Tarjeta 2: '|| v_por2 || '%');
      DBMS_OUTPUT.PUT_LINE('Tarjeta 3: '|| v_por3 || '%');

    EXCEPTION
      WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error en PRUEBA 1: ' || SQLERRM);
    END;
  END;

  --PRUEBA2: PRUEBA PARA CUANDO SE INGRESAN 3 TARJETAS Y SE OMITE EL MONTO
  BEGIN
    v_por1 := NULL; 
    v_por2 := NULL; 
    v_por3 := NULL;
    DBMS_OUTPUT.PUT_LINE('CASO 2: correcta');
    BEGIN
      sp_seleccion_tarjetas(1, v_por1, 2, v_por2, 3, v_por3, v_valido);
      DBMS_OUTPUT.PUT_LINE('Resultado: ' || v_valido);
      DBMS_OUTPUT.PUT_LINE('Porcentajes asignado: ');
      DBMS_OUTPUT.PUT_LINE('Tarjeta 1: '|| v_por1 || '%');
      DBMS_OUTPUT.PUT_LINE('Tarjeta 2: '|| v_por2 || '%');
      DBMS_OUTPUT.PUT_LINE('Tarjeta 3: '|| v_por3 || '%');
    EXCEPTION
      WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error en PRUEBA 2: ' || SQLERRM);
    END;
  END;

  --PRUEBA3: PRUEBA PARA CUANDO SE INGRESA UNA TARJETA CON MONTO Y LAS DEMAS SIN MONTO
  BEGIN
    v_por1 := 50; 
    v_por2 := NULL; 
    v_por3 := NULL;
    DBMS_OUTPUT.PUT_LINE('CASO 3: correcta');
    BEGIN
      sp_seleccion_tarjetas(1, v_por1, 2, v_por2, 3, v_por3, v_valido);
      DBMS_OUTPUT.PUT_LINE('Resultado: ' || v_valido);
      DBMS_OUTPUT.PUT_LINE('Porcentajes asignado: ');
      DBMS_OUTPUT.PUT_LINE('Tarjeta 1: '|| v_por1 || '%');
      DBMS_OUTPUT.PUT_LINE('Tarjeta 2: '|| v_por2 || '%');
      DBMS_OUTPUT.PUT_LINE('Tarjeta 3: '|| v_por3 || '%');
    EXCEPTION
      WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error en PRUEBA 3: ' || SQLERRM);
    END;
  END;

  --PRUEBA4: PRUEBA PARA CUANDO SE INGRESA EL MONTO PERO NO UNA TARJETA
  BEGIN
    v_por1 := 50; 
    v_por2 := 30; 
    v_por3 := 20;
    DBMS_OUTPUT.PUT_LINE('CASO 4: incorrecta');
    BEGIN
      sp_seleccion_tarjetas(1, v_por1, 2, v_por2, NULL, v_por3, v_valido);
      DBMS_OUTPUT.PUT_LINE('Resultado: ' || v_valido);
    EXCEPTION
      WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error en PRUEBA 4: ' || SQLERRM);
    END;
  END;

  --PRUEBA5: PRUEBA PARA CUANDO EL TOTAL NO DA 100
  BEGIN
    v_por1 := 50; 
    v_por2 := 100; 
    v_por3 := 20;
    DBMS_OUTPUT.PUT_LINE('CASO 5: incorrecta');
    BEGIN
      sp_seleccion_tarjetas(1, v_por1, 2, v_por2, 3, v_por3, v_valido);
      DBMS_OUTPUT.PUT_LINE('Resultado: ' || v_valido);
    EXCEPTION
      WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error en PRUEBA 5: ' || SQLERRM);
    END;
  END;

END;
/
SHOW ERRORS;
