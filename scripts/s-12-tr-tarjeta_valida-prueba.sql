SET SERVEROUTPUT ON;

DECLARE
  v_tarjeta_id NUMBER;

BEGIN
  -- Caso 1: Inserción correcta de una tarjeta
  BEGIN
    DBMS_OUTPUT.PUT_LINE('CASO INSERCION CORRECTA');
    INSERT INTO tarjeta(tarjeta_id, numero_tarjeta, mes, anio, usuario_id)
    VALUES (tarjeta_seq.NEXTVAL, 1122334455667788, 12, 24, 1);
  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Error en la insercion correcta: ' || SQLERRM);
  END;

  -- Caso 2: Actualización correcta de una tarjeta
  BEGIN
    DBMS_OUTPUT.PUT_LINE('CASO ACTUALIZACION CORRECTA');
    SELECT tarjeta_id INTO v_tarjeta_id
    FROM tarjeta
    WHERE numero_tarjeta = 1122334455667788;

    UPDATE tarjeta
    SET mes = 01, anio = 25
    WHERE tarjeta_id = v_tarjeta_id;
  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Error en la actualizacion correcta: ' || SQLERRM);
  END;

  -- Caso 3: Inserción incorrecta de una tarjeta
  BEGIN
    DBMS_OUTPUT.PUT_LINE('CASO INSERCION INCORRECTA');
    INSERT INTO tarjeta(tarjeta_id, numero_tarjeta, mes, anio, usuario_id)
    VALUES (tarjeta_seq.NEXTVAL, 3333444433334444, 09, 24, 3);
  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Error en la insercion incorrecta: ' || SQLERRM);
  END;

  -- Caso 4: Actualización incorrecta de una tarjeta
  BEGIN
    DBMS_OUTPUT.PUT_LINE('CASO ACTUALIZACION INCORRECTA');
    SELECT tarjeta_id INTO v_tarjeta_id
    FROM tarjeta
    WHERE numero_tarjeta = 1122334455667788;

    UPDATE tarjeta
    SET mes = 01, anio = 19
    WHERE tarjeta_id = v_tarjeta_id;
  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Error en la actualizacion incorrecta: ' || SQLERRM);
  END;
END;
/
SHOW ERRORS;
ROLLBACK;