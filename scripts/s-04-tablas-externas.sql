--@Autor(es): Enrique Job Calderón Olalde <@ksobrenat32>, Erick Nava Santiago
--@Fecha creación: 1 de diciembre de 2024
--@Descripción: Archivo con la implementación de tablas externas

--Diseñar un escenario donde se haga uso de una o más tablas externas.

/*
  EJEMPLO 1
  Tabla de usuarios que tienen una solicitud para ser conductores de
  la plataforma. Esta tabla se alimenta de un archivo CSV que contiene
  los datos de los usuarios que desean ser conductores.
*/

create table usuario_conductor_ext(
  nombre VARCHAR2(40),
  apellido_paterno VARCHAR2(40),
  apellido_materno VARCHAR2(40),
  fecha_nacimiento DATE,
  telefono VARCHAR2(20),
  correo_electronico VARCHAR2(100),
  direccion VARCHAR2(200),
  ciudad VARCHAR2(50),
  estado VARCHAR2(50),
  codigo_postal VARCHAR2(10),
  pais VARCHAR2(50)
)
organization external(
  type oracle_loader
  default directory tablas_externas
  access parameters(
    records delimited by newline
    badfile tablas_externas:'usuario_conductor_ext_bad.log'
    logfile tablas_externas:'usuario_conductor_ext.log'
    fields terminated by ','
    lrtrim
    missing field values are null
    (
      nombre, apellido_paterno, apellido_materno, fecha_nacimiento date mask "dd/mm/yyyy",
      telefono, correo_electronico, direccion, ciudad, estado, codigo_postal, pais
    )
  )
  location ('usuario_conductor_ext.csv')
) reject limited unlimited;

/*
  EJEMPLO 2
  Autos registrados con multas pendientes a pagar. Estas multas se
  obtienen por medio del sistema del gobierno de la ciudad. Se alimenta
  de un archivo CSV que contiene las placas de los autos, el monto de la
  multa, la fecha de la multa y la descripción de la multa.
*/

create table multas_ext(
  placa VARCHAR2(7),
  monto NUMBER(7,2),
  fecha_multa DATE,
  descripcion VARCHAR2(400)
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
      placa, monto, fecha_multa date mask "dd/mm/yyyy", descripcion
    )
  )
  location ('multas_ext.csv')
) reject limited unlimited;

/*
  EJEMPLO 3
  Una de las formas de conseguir promociones es por medio de campañas,
  estas campañas son de empresas externas que desean promocionar sus
  productos o servicios. Se alimenta de un archivo CSV que contiene el
  nombre de la campaña, la fecha de inicio, la fecha de fin, la descripción
  y el importe de la promoción.
*/

create table campania_ext(
  importe NUMBER(5,2)
  fecha_inicio DATE,
  fecha_fin DATE,
  nombre_campania VARCHAR2(100),
  descripcion VARCHAR2(300)
)
organization external(
  type oracle_loader
  default directory tablas_externas
  access parameters(
    records delimited by newline
    badfile tablas_externas:'campania_ext_bad.log'
    logfile tablas_externas:'campania_ext.log'
    fields terminated by ','
    lrtrim
    missing field values are null
    (
      importe, fecha_inicio date mask "dd/mm/yyyy", fecha_fin date mask "dd/mm/yyyy", nombre_campania, descripcion
    )
  )
  location ('campania_ext.csv')
)reject limited unlimited;
