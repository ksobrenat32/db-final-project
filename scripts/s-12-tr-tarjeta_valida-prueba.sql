--@Autor(es): Enrique Job Calderón Olalde <@ksobrenat32>, Erick Nava Santiago
--@Fecha creación: 1 de diciembre de 2024
--@Descripción: Pruebas para el trigger tr_tarjeta_valida

SET SERVEROUTPUT ON;

DECLARE
  v_tarjeta_id NUMBER;
  v_mes NUMBER;
  v_anio NUMBER;
BEGIN
  -- Caso 1: Inserción correcta de una tarjeta, se espera que no haya errores
  BEGIN
    DBMS_OUTPUT.PUT_LINE('CASO INSERCIÓN CORRECTA');
    INSERT INTO tarjeta(numero_tarjeta, mes, anio, usuario_id)
    VALUES (1122334455667788, 12, 24, 1);

    -- Verificando que se haya insertado correctamente
    SELECT tarjeta_id INTO v_tarjeta_id
    FROM tarjeta
    WHERE numero_tarjeta = 1122334455667788;

    IF v_tarjeta_id IS NULL THEN
      DBMS_OUTPUT.PUT_LINE('Error en la inserción correcta: No se encontró la tarjeta');
    ELSE
      DBMS_OUTPUT.PUT_LINE('Inserción correcta, tarjeta_id: ' || v_tarjeta_id);
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Error en la inserción correcta: ' || SQLERRM);
  END;

  -- Caso 2: Inserción incorrecta de una tarjeta, se espera que haya un error
  BEGIN
    DBMS_OUTPUT.PUT_LINE('CASO INSERCIÓN INCORRECTA');
    INSERT INTO tarjeta(numero_tarjeta, mes, anio, usuario_id)
    VALUES (1122334455667789, 12, 20, 1);

    -- Si se pudo insertar correctamente, es un error pues no se puede insertar
    DBMS_OUTPUT.PUT_LINE('Error en la inserción incorrecta: Se pudo insertar la tarjeta');
  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Excepción correcta');
  END;

  -- Caso 3: Actualización correcta de una tarjeta, se espera que haya un error
  BEGIN
    DBMS_OUTPUT.PUT_LINE('CASO ACTUALIZACIÓN');
    SELECT tarjeta_id INTO v_tarjeta_id
    FROM tarjeta
    WHERE numero_tarjeta = 1122334455667788;

    UPDATE tarjeta
    SET mes = 01, anio = 25
    WHERE tarjeta_id = v_tarjeta_id;

    -- Si se pudo actualizar correctamente, es un error pues no se puede actualizar
    DBMS_OUTPUT.PUT_LINE('Error en la actualización: Se pudo actualizar la tarjeta');
  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Excepción correcta');
  END;
END;
/
SHOW ERRORS;
ROLLBACK;