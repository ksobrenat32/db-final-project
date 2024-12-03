 --@Autor(es): Enrique Job Calderón Olalde <@ksobrenat32>, Erick Nava Santiago
--@Fecha creación: 1 de diciembre de 2024
--@Descripción: Arichivo con escenarios de tabla temporal


--Diseñar al menos un escenario donde se haga uso de una o más tablas temporales.
--Se pueden crear nuevas tablas en caso de ser necesario.



--EJEMPLO 1
/*
  Se desea ver los candidatos a una vacante de empleo para ser conductor.
  una vez se termine de seleccionar al que se quedadara con el 
  puesto se añadira a la lista de usuario_conductor
*/
create global temporary table usuario_candidato_conductor(
  nombre varchar2(200),
  email  varchar2(100),
  cv blob
 )on commit delete rows;

--EJEMPLO 2
/*
  La plataforma donde se solicita el viaje, asigna el auto màs cercano.
  Para esto hace un listado de los autos de la zona. Tras conciderar
  cual cumple con los requisitos del solicitante, se asignara al viaje
*/
create global temporary table vehiculo_candidato(
  vehiculo_id number(10,0),
  disponible boolean,
  num_acientos number(1,0)
)on commit preserve rows;
--EJEMPLO 3
/*
  El usuario desea añadir una tarjeta de credito, posee varias. De
  forma predeterminada, se le muestran las tarjetas registradas en su
  dispositivo. El puede decidir si agrega la tarjeta o no a su usuario
*/
create private temporary table ora$ptt_tarj_pred(
   num_tarjeta number(30,0),
   banco   varchar2(20),
   nombre  varchar2(200)
); on commit drop definition;
