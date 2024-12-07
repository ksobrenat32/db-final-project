 --@Autor(es): Enrique Job Calderón Olalde <@ksobrenat32>, Erick Nava Santiago
--@Fecha creación: 1 de diciembre de 2024
--@Descripción: Aquí se hará uso de un dato lob. La intención es recibir las imagenes
--- de los empleados conductores

--concetando con el usuario sys
CONNECT sys/system1@//localhost:1521/FREEPDB1 AS SYSDBA

--creando directorio a utilizar
create or replace directory fotos_dir as '';
--otorgando permisos a el usuario admin
grant read on directory data_dir to cn_proy_admin

--inicio del procedimiento para el llenado de la imagen 

BEGIN

  v_bfile := bfilename('fotos_dir', v_usuario_id);
  

END
/