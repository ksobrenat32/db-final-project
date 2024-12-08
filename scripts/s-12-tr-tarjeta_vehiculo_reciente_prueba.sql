DECLARE
  v_usuario_id NUMBER;
BEGIN
  --CASO EN EL QUE ES CORRECTA LA INSERCCION
    BEGIN 
      -- obteniendo un usuario conductor
      SELECT MAX(usuario_id) INTO v_usuario_id
      FROM usuario
      WHERE es_conductor = TRUE;

      --INSERCCION
      INSERT INTO vehiculo(vehiculo_id, placas,anio modelo_id, usuario_id)
      VALUES(vehiculo_seq.nextval, '77RAUP1',2020, 1, v_usuario_id);

    END;


  --CASO EN EL QUE ES INCORRECTA LA INSERCCION
    BEGIN 
      SELECT MAX(usuario_id) INTO v_usuario_id
      FROM usuario
      WHERE es_conductor = TRUE;

      --INSERCCION
      INSERT INTO vehiculo(vehiculo_id, placas,anio modelo_id, usuario_id)
      VALUES(vehiculo_seq.nextval, '77RAUP2',2002, 1, v_usuario_id);


    END;

  --CASO EN EL QUE SE ACTUALIZAN LOS DATOS DE FORMA CORRECTA

    BEGIN 
      --SELECCIONANDO EL USUARIO DE LA PRUEBA 1
      SELECT MIN(usuario_id) INTO v_usuario_id
      FROM usuario
      WHERE es_conductor = TRUE;

      --ACTUALIZACION
      UPDATE vehiculo SET
      anio = 2023
      WHERE usuario_id = v_usuario_id;

    END;
  --CASO EN EL QUE NO SE ACTUALIZAN DEBIDO A UNA ACTUALIZACION INCORRECTA
    BEGIN 
      --SELECCIONANDO EL USUARIO DE LA PRUEBA 1
      SELECT MIN(usuario_id) INTO v_usuario_id
      FROM usuario
      WHERE es_conductor = TRUE;

      --ACTUALIZACION
      UPDATE vehiculo SET
      anio = 1990
      WHERE usuario_id = v_usuario_id;

    END;

END;
SHOW ERRORS;
