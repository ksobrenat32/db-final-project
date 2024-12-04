 --@Autor(es): Enrique Job Calderón Olalde <@ksobrenat32>, Erick Nava Santiago
--@Fecha creación: 1 de diciembre de 2024
--@Descripción: Archivo con sinonimos utiles


--sinonimos publicos del usuario admin


create or replace public synonym tags_conductor for cn_proy_admin.tags_conductor;

create or replace public synonym cobro for cn_proy_admin.cobro;

create or replace public synonym vehiculo for cn_proy_admin.vehiculo;

--otorgando permisos de visualizacion al usuario invitado

grant select on usuario_administrador to cn_proy_invitado;
grant select on usuario_conductor to cn_proy_invitado;
grant select on historico_status_viaje to cn_proy_invitado;

--sinonimo del usuario invitado

create or replace synonym administradores for cn_proy_admin.usuario_administrador;
create or replace synonym conductores for cn_proy_admin.usuario_conductor;
create or replace synonym viaje_hist for cn_proy_admin.historico_status_viaje;

--nombramiento en las tablas
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
  end loop;
end 
/
