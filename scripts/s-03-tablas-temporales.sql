--@Autor(es): Enrique Job Calderón Olalde <@ksobrenat32>, Erick Nava Santiago
--@Fecha creación: 1 de diciembre de 2024
--@Descripción: Archivo con escenarios de tabla temporal

--Diseñar al menos un escenario donde se haga uso de una o más tablas temporales. Se pueden crear nuevas tablas en caso de ser necesario.

/*
  EJEMPLO 1
  La plataforma donde se solicita el viaje, asigna el auto más cercano.
  Para esto hace un listado de los autos más cercanos en la zona de las
  3 categorías que existen. Estos se le presentan al usuario para que
  elija el que más le convenga.
*/

create global temporary table vehiculo_candidato(
  vehiculo_id NUMBER(10,0),
  num_asientos NUMBER(1,0),
  categoria NUMBER(1,0)
) on commit preserve rows;

/*
  EJEMPLO 2
  El usuario desea añadir una tarjeta de crédito al pago dentro de la
  plataforma. El usuario puede tener varias tarjetas registradas en su
  dispositivo, por lo que se le muestran todas las tarjetas que tiene
  registradas para que elija la que desea añadir.
*/

create private temporary table ora$ptt_tarj_pred(
  nombre_titular VARCHAR2(100),
  banco VARCHAR2(100),
  numero_tarjeta VARCHAR2(16),
  mes NUMBER(2,0),
  anio NUMBER(4,0),
); on commit drop definition;
