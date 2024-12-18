--@Autor(es): Enrique Job Calderón Olalde <@ksobrenat32>, Erick Nava Santiago
--@Fecha creación: 1 de diciembre de 2024
--@Descripción: Prueba del trigger tr_vehiculo_reciente

CONNECT cn_proy_admin/cn_proy_admin@//localhost:1521/FREEPDB1
SET SERVEROUTPUT ON;

DECLARE
  v_usuario_id NUMBER;
BEGIN
  -- Caso 1: Inserción correcta
  BEGIN
    DBMS_OUTPUT.PUT_LINE('CASO 1: Inserción correcta');

    -- Obteniendo un usuario conductor
    SELECT MAX(usuario_id) INTO v_usuario_id
    FROM usuario
    WHERE es_conductor = 1;

    -- Inserción
    INSERT INTO vehiculo(vehiculo_id, placas, anio, modelo_id, usuario_id)
    VALUES (vehiculo_seq.NEXTVAL, '77RAUP1', 2020, 1, v_usuario_id);

    DBMS_OUTPUT.PUT_LINE('Inserción correcta');
  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Error en el caso 1: ' || SQLERRM);
  END;

  -- Caso 2: Inserción incorrecta
  BEGIN
    DBMS_OUTPUT.PUT_LINE('CASO 2: Inserción incorrecta');
    -- Obteniendo un usuario conductor
    SELECT MAX(usuario_id) INTO v_usuario_id
    FROM usuario
    WHERE es_conductor = 1;

    -- Inserción
    INSERT INTO vehiculo(vehiculo_id, placas, anio, modelo_id, usuario_id)
    VALUES (vehiculo_seq.NEXTVAL, '77RAUP2', 2002, 1, v_usuario_id);

    DBMS_OUTPUT.PUT_LINE('Error en la inserción incorrecta: Se pudo insertar el vehículo');
  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Excepción correcta');
  END;

  -- Caso 3: Actualización correcta
  BEGIN
    DBMS_OUTPUT.PUT_LINE('CASO 3: Actualización correcta');
    -- Seleccionando el usuario
    SELECT MIN(usuario_id) INTO v_usuario_id
    FROM usuario
    WHERE es_conductor = 1;

    -- Actualización
    UPDATE vehiculo
    SET anio = 2023
    WHERE usuario_id = v_usuario_id;

    DBMS_OUTPUT.PUT_LINE('Actualización correcta');
  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Error en el caso 3: ' || SQLERRM);
  END;

  -- Caso 4: Actualización incorrecta
  BEGIN
    DBMS_OUTPUT.PUT_LINE('CASO 4: Actualización incorrecta');
    -- Seleccionando el usuario
    SELECT MIN(usuario_id) INTO v_usuario_id
    FROM usuario
    WHERE es_conductor = 1;

    -- Actualización
    UPDATE vehiculo
    SET anio = 1990
    WHERE usuario_id = v_usuario_id;

    DBMS_OUTPUT.PUT_LINE('Error en la actualización incorrecta: Se pudo actualizar el vehículo');
  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Excepción correcta');
  END;
END;
/
SHOW ERRORS;
ROLLBACK;