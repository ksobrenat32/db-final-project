--@Autor(es): Enrique Job Calderón Olalde <@ksobrenat32>, Erick Nava Santiago
--@Fecha creación: 1 de diciembre de 2024
--@Descripción: Pruebas para el procedimiento actualizar_empleado_imagen

SET SERVEROUTPUT ON;

DECLARE
  v_usuario_1 usuario_conductor.usuario_id%TYPE;
  v_usuario_3 usuario_conductor.usuario_id%TYPE;

  v_longitud_1 NUMBER;
BEGIN
  -- Prueba 1: foto y usuario existen
  BEGIN
    DBMS_OUTPUT.PUT_LINE('Prueba 1: foto y usuario existen');

    SELECT u.usuario_id
    INTO v_usuario_1
    FROM usuario_conductor uc
      JOIN usuario u ON uc.usuario_id = u.usuario_id
    WHERE u.username = 'driver1';

    DBMS_OUTPUT.PUT_LINE('Usuario: ' || v_usuario_1);
    actualizar_empleado_imagen(v_usuario_1);

    -- Asignar blob vacío
    UPDATE usuario_conductor
    SET foto = EMPTY_BLOB()
    WHERE usuario_id = v_usuario_1;

    SELECT DBMS_LOB.GETLENGTH(foto) AS longitud_foto
    INTO v_longitud_1
    FROM usuario_conductor
    WHERE usuario_id = v_usuario_1;

    DBMS_OUTPUT.PUT_LINE('Longitud de la imagen previo a update: ' || v_longitud_1);

    actualizar_empleado_imagen(v_usuario_1);

    -- Verificar que la imagen se haya actualizado
    SELECT DBMS_LOB.GETLENGTH(foto) AS longitud_foto
    INTO v_longitud_1
    FROM usuario_conductor
    WHERE usuario_id = v_usuario_1;

    DBMS_OUTPUT.PUT_LINE('Longitud de la imagen posterior a update: ' || v_longitud_1);
    DBMS_OUTPUT.PUT_LINE('Prueba 1: exitosa');
  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Error, Prueba 1: ' || SQLERRM);
  END;

  -- Prueba 2: usuario no existe
  BEGIN
    DBMS_OUTPUT.PUT_LINE('Prueba 2: usuario no existe');
    actualizar_empleado_imagen(0);
    DBMS_OUTPUT.PUT_LINE('Error, Prueba 2: no se lanzó excepción');
  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Prueba 2: exitosa');
  END;

  -- Prueba 3: foto no existe
  BEGIN
    DBMS_OUTPUT.PUT_LINE('Prueba 3: foto no existe');
    SELECT u.usuario_id
    INTO v_usuario_3
    FROM usuario_conductor uc
      JOIN usuario u ON uc.usuario_id = u.usuario_id
    WHERE u.username = 'driver3';

    actualizar_empleado_imagen(v_usuario_3);
    DBMS_OUTPUT.PUT_LINE('Error, Prueba 3: no se lanzó excepción');
  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Prueba 3: exitosa');
  END;

  DBMS_OUTPUT.PUT_LINE('Pruebas finalizadas');
  ROLLBACK;
END;
/
SHOW ERRORS;
