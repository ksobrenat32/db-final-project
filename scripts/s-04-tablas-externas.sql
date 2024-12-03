 --@Autor(es): Enrique Job Calderón Olalde <@ksobrenat32>, Erick Nava Santiago
--@Fecha creación: 1 de diciembre de 2024
--@Descripción: Arichivo con la implentaciòn de tablas externas


--Diseñar un escenario donde se haga uso de una o más tablas externas.
--● Sugerencias:
--○ Se tiene un archivo de texto y se desea consultar sus datos sin tener que
--cargar los datos al interior de la BD. El archivo de texto deberá contener una
--lista de registros separados por algún carácter, por ejemplo: “#”, “*”,”,”, etc.


--EJEMPLO 1
/*
  tabla de conductores que poseen antecedentes penales
*/
create table empleado_ext(
  nombre varchar2(200),
  ap_pat varchar2(200),
  ap_mat varchar2(200),
  fecha_nacimiento date
 )
organization external(
  type oracle_loader
  default directory tablas_externas
  access parameters(
    records delimited by newline
    badfile tablas_externas:'empleado_ext_bad.log'
    logfile tablas_externas:'empleado_ext.log'
    fields terminated by ','
    lrtrim
    missing field values are null
    (
     nombre, ap_pat, ap_mat, fecha_nacimiento date mask "dd/mm/yyyy"
    )
  )
  location ('empleados_ext.csv')
 )reject limited unlimited;
--EJEMPLO 2
/*
  autos registrados con multas pendientes a pagar
*/
create table multas_ext(
  auto_id number(10,0),
  multa_clave varchar2(40),
  monto number(10,0),
  fecha_multa date,
  descripcion varchar2(400),
  sanciones varchar2(800)
 )
organization external(
  type oracle_loader
  default directory tablas_externas
  access parameters(
    records delimited by newline
    badfile tablas_externas:'multas_ext_bad.log'
    logfile tablas_externas:'multas_ext.log'
    fields terminated by ','
    lrtrim
    missing field values are null
    (
     auto_id, multa_clave, monto, fecha_multa date mask "dd/mm/yyyy",
     descripcion, sanciones
    )
  )
  location ('multas_ext.csv')
 )reject limited unlimited;

--EJEMPLO 3
/*
  las campañas de cupones de descuento
*/
create table descuento_ext(
  nombre_campania varchar2(50),
  fecha_ini date,
  fecha_fin date,
  descripcion varchar2(200),
  terminos_condiciones varchar2(800)
 )
organization external(
  type oracle_loader
  default directory tablas_externas
  access parameters(
    records delimited by newline
    badfile tablas_externas:'descuento_ext_bad.log'
    logfile tablas_externas:'descuento_ext.log'
    fields terminated by ','
    lrtrim
    missing field values are null
    (
     nombre_campania, fecha_ini date mask "dd/mm/yyyy",
     fecha_fin date mask "dd/mm/yyyy", descripcion,
     terminos_condiciones
    )
  )
  location ('descuento_ext.csv')
 )reject limited unlimited;
