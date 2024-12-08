--@Autor(es): Enrique Job Calderón Olalde <@ksobrenat32>, Erick Nava Santiago
--@Fecha creación: 1 de diciembre de 2024
--@Descripción: Aquí se hará uso de un dato lob dentro del procedimiento para que con las imágenes ubicadas en /home/oracle/scripts/imagen/ se pueda actualizar la imagen de un usuario_conductor. El formato de la imagen almacenada es usuario_id.jpg y en la tabla usuario_conductor se almacenará la imagen en el atributo foto de tipo BLOB.

-- Conectando con el usuario administrador
CONNECT cn_proy_admin/cn_proy_admin@//localhost:1521/FREEPDB1

-- Creando directorio a utilizar
CREATE OR REPLACE directory fotos_dir as '/home/oracle/scripts/imagen/';

-- Inicio del procedimiento para el llenado de la imagen
-- Procedimiento corregido para actualizar imágenes de usuarios
CREATE OR REPLACE PROCEDURE actualizar_empleado_imagen(
    p_usuario_id IN NUMBER
)
IS
  v_bfile BFILE;
  v_blob BLOB;
  v_cnt NUMBER;
  v_src_length NUMBER;
BEGIN
  -- Verificar que el usuario exista
  SELECT COUNT(*)
  INTO v_cnt
  FROM usuario_conductor
  WHERE usuario_id = p_usuario_id;

  IF v_cnt = 0 THEN
    RAISE_APPLICATION_ERROR(-20100, 'El usuario no existe');
  END IF;

  -- Inicializar el archivo BFILE
  v_bfile := BFILENAME('FOTOS_DIR', p_usuario_id || '.jpg');

  -- Verificar que el archivo exista
  IF NOT DBMS_LOB.FILEEXISTS(v_bfile) = 1 THEN
    RAISE_APPLICATION_ERROR(-20101, 'El archivo no existe en el directorio');
  END IF;

  -- Abrir el archivo
  DBMS_LOB.OPEN(v_bfile, DBMS_LOB.LOB_READONLY);

  -- Crear un BLOB temporal
  DBMS_LOB.CREATETEMPORARY(v_blob, TRUE);

  -- Leer el archivo BFILE y escribirlo en el BLOB
  v_src_length := DBMS_LOB.GETLENGTH(v_bfile);
  DBMS_LOB.LOADFROMFILE(v_blob, v_bfile, v_src_length);

  -- Actualizar la imagen en la tabla
  UPDATE usuario_conductor
  SET foto = v_blob
  WHERE usuario_id = p_usuario_id;

  -- Cerrar el archivo BFILE
  DBMS_LOB.CLOSE(v_bfile);

  -- Liberar el BLOB temporal
  DBMS_LOB.FREETEMPORARY(v_blob);

  DBMS_OUTPUT.PUT_LINE('Imagen actualizada exitosamente para el usuario ' || p_usuario_id);
EXCEPTION
  WHEN OTHERS THEN
    -- Asegurarse de cerrar el archivo y liberar recursos en caso de error
    IF DBMS_LOB.ISOPEN(v_bfile) = 1 THEN
      DBMS_LOB.CLOSE(v_bfile);
    END IF;
    IF v_blob IS NOT NULL AND DBMS_LOB.ISTEMPORARY(v_blob) = 1 THEN
      DBMS_LOB.FREETEMPORARY(v_blob);
    END IF;
    RAISE_APPLICATION_ERROR(-20002, 'Error al actualizar la imagen: ' || SQLERRM);
END;
/
SHOW ERRORS;
