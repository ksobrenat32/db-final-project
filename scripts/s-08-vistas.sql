 --@Autor(es): Enrique Job Calderón Olalde <@ksobrenat32>, Erick Nava Santiago
--@Fecha creación: 1 de diciembre de 2024
--@Descripción: Archivo con sinonimos vistas



--CASO 1
/*

se desea ver las especificaciones del auto 

*/

create or replace view v_auto_info(
    vehiculo_id, marca, modelo, anio
)as select v.vehiculo_id, ma.nombre, mo.nombre, v.anio 
from vehiculo v, marca ma, nombre mo 
where ma.marca_id = mo.marca_id 
  and mo.modelo_id = v.vehiculo_id;

--CASO 2

/*
 Se desea conocer las personas involucradas en un viaje 
*/

create or replace view v_viaje_usuarios as
    select usuario_id as usuario_conductor, nombre as nombre_conductor, 
    apellido_paterno as ap_pat_conductor , 
    apellido_materno as ap_mat_conductor 
    from viaje vi, vehiculo v, usuario_conductor uc, usuario u
    where v.vehiculo_id = vi.vehiculo_id
    and uc.usuario_id = v.usuario_id 
    and uc.usuario_id = u.usuario_id

    union

    select usuario_id as usuario_cliete, nombre as nombre_cliente, 
    apellido_paterno as ap_pat_cliente , 
    apellido_materno as ap_mat_cliente 
    from viaje vi, vehiculo v, usuario_cliente ul, usuario u
    where v.vehiculo_id = vi.vehiculo_id
    and ul.usuario_id = v.usuario_id 
    and ul.usuario_id = u.usuario_id;
