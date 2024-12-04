--@Autor(es): Enrique Job Calderón Olalde <@ksobrenat32>, Erick Nava Santiago
--@Fecha creación: 1 de diciembre de 2024
--@Descripción: Archivo con sinónimos útiles

-- Conectando a la base de datos como admin
CONNECT cn_proy_admin/cn_proy_admin@//localhost:1521/FREEPDB1

-- Generar 3 o más sinónimos públicos que le pertenezcan al usuario admin. Los sinónimos deberán estar disponibles para que otros usuarios puedan emplearlos, por ejemplo, el usuario invitado.

--  Los tags de los conductores deben ser visibles para otros usuarios pues con esto los conductores pueden ser identificados y se pueden saber los mejores, para esto debemos crear un sinónimo público de la tabla tags_conductor.

create or replace public synonym tags_conductor for cn_proy_admin.tags_conductor;

-- Los vehículos deben ser visibles para otros usuarios, pues con esto se pueden saber los vehículos que están disponibles para el servicio, para esto debemos crear un sinónimo público de la tabla vehiculo.

create or replace public synonym vehiculo for cn_proy_admin.vehiculo;

-- Los descuentos deben ser visibles para otros usuarios, pues con esto se pueden saber los descuentos que se pueden aplicar a los servicios, para esto debemos crear un sinónimo público de la tabla descuento.

create or replace public synonym descuento for cn_proy_admin.descuento;

-- Generar las instrucciones necesarias para que el usuario admin otorgue permisos de lectura al usuario invitado en al menos 3 entidades.

-- Para el sistema de pagos nuestra empresa se alía con una empresa de pagos en línea, por lo que necesitamos que el usuario invitado pueda ver los cobros, las tarjetas y facturas.

grant select on cobro to cn_proy_invitado;
grant select on tarjeta to cn_proy_invitado;
grant select on factura to cn_proy_invitado;

-- Generar 3 o más sinónimos que le pertenezcan al usuario invitado. Dichos sinónimos deberán ser empleados para leer el contenido de las tablas a las que el usuario admin le otorgó permisos de lectura.

-- Conexión a la base de datos como invitado
CONNECT cn_proy_invitado/cn_proy_invitado@//localhost:1521/FREEPDB1

create or replace synonym cobro for cn_proy_admin.cobro;
create or replace synonym tarjeta for cn_proy_admin.tarjeta;
create or replace synonym factura for cn_proy_admin.factura;

-- Finalmente, suponer que un software necesita que todas las tablas del proyecto tengan un prefijo formado por 2 caracteres: <iniciales>_<nombre_tabla>. Sustituir <iniciales> con el primer carácter de los apellidos paternos de los integrantes. Si se realiza de forma individual, emplear como segundo carácter la primera letra del apellido materno. Para implementar este requerimiento se creará un sinónimo privado para cada tabla. Se recomienda realizar un programa anónimo PL/SQL empleando SQL dinámico para evitar escribir manualmente los sinónimos.

-- Conectando a la base de datos como admin
CONNECT cn_proy_admin/cn_proy_admin@//localhost:1521/FREEPDB1

-- Creación de sinónimos para las tablas
set serveroutput on
clear screen

declare

  cursor cur_tablas
  is
  select table_name
  from user_tables;

begin
  for tabla in cur_tablas loop
    execute immediate 'create or replace synonym cn_'|| tabla.table_name || ' on cn_proy_admin.' || tabla.table_name;
    dbms_output.put_line('Sinónimo creado para la tabla ' || tabla.table_name);
  end loop;
end
/
