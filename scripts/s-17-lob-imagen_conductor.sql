 --@Autor(es): Enrique Job Calderón Olalde <@ksobrenat32>, Erick Nava Santiago
--@Fecha creación: 1 de diciembre de 2024
--@Descripción: Aquí se hará uso de un dato lob. La intención es recibir las imagenes
--- de los empleados conductores

--concetando con el usuario sys
CONNECT sys/system1@//localhost:1521/FREEPDB1 AS SYSDBA

--creando directorio a utilizar
CREATE OR REPLACE directory fotos_dir as '/home/oracle/scripts/imagen/';
--otorgando permisos a el usuario admin
GRANT READ ON directory fotos_dir to cn_proy_admin

--inicio del procedimiento para el llenado de la imagen 
CREATE OR REPLACE PROCEDURE empleado_imagen(
    p_usuario_id IN NUMBER,
    p_licencia IN VARCHAR2, 
    p_cedula IN VARCHAR2,
    p_descripcion IN VARCHAR2) is

    v_bfile bfile;
    v_src_offset number := 1;
    v_dest_offset number:= 1;
    v_dest_blob blob;
    v_src_length number;
    v_dest_length number;

    type ch_varray is varray(2) of VARCHAR2;
    extensiones ch_varray ;
    v_encontrado BOOLEAN := FALSE;

BEGIN 
  FOR i IN 1..extensiones.limit LOOP
    v_bfile := BFILENAME('FOTOS_DIR', p_usuario_id || '.jpg');
  
    IF dbms_lob.fileexists(v_bfile) = 1 AND NOT
      dbms_lob.isopen(v_bfile) = 1 THEN
      dbms_lob.open(v_bfile,dbms_lob.lob_readonly);
      v_encontrado := TRUE;
      EXIT;
    END IF;

  END LOOP;

  IF NOT v_encontrado THEN
      raise_application_error(-20212,'NO SE ENCONTRO NINGUNA FOTO ');
  END IF;

  INSERT INTO usuario_conductor(usuario_id,num_licencia,
    num_cedula, foto, descripcion)
    VALUES(p_usuario_id,p_licencia,p_cedula,empty_blob(),p_descripcion);

  SELECT foto INTO v_dest_blob
  FROM usuario_conductor
  WHERE usuario_id = p_usuario_id;

  dbms_lob.loadblobfromfile(
    dest_lob => v_dest_blob,
    src_bfile => v_bfile,
    amount => dbms_lob.getlength(v_bfile),
    dest_offset => v_dest_offset,
    src_offset => v_src_offset);
  dbms_lob.close(v_bfile);


  v_src_length := dbms_lob.getlength(v_bfile);
  v_dest_length := dbms_lob.getlength(v_dest_blob);

  if v_src_length = v_dest_length then
    dbms_output.put_line('Escritura correcta, bytes escritos: '
    || v_src_length);
  else
    raise_application_error(-20211,'Error al escribir datos.\n'
      ||' Se esperaba escribir '||v_src_length
      ||' Pero solo se escribio '||v_dest_length);
  end if;
END ;
/
SHOW ERRORS
