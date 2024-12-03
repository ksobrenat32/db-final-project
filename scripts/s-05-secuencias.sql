 --@Autor(es): Enrique Job Calderón Olalde <@ksobrenat32>, Erick Nava Santiago
--@Fecha creación: 1 de diciembre de 2024
--@Descripción: Arichivo con las secuencias


--Este archivo contendrá la definición de todas las secuencias necesarias para poder
--insertar registros en tablas que requieran la generación de valores secuenciales.
--Todas las secuencias deberán iniciar en un número seleccionado por el equipo.

--
-- Usuario Sequencia
--

create sequence usuario_seq
  start with 1
  increment by 1
  minvalue 1
  nomaxvalue
  cache 3
  order
;


--
-- Tags Sequencia
--

create sequence tags_seq
  start with 1
  increment by 1
  minvalue 1
  nomaxvalue
  cache 3
  order
;

--
--Marca Sequencia
--

create sequence marca_seq
  start with 1
  increment by 1
  minvalue 1
  nomaxvalue
  cache 3
  order
;

--
-- Modelo Sequencia
--

create sequence modelo_seq
  start with 1
  increment by 1
  minvalue 1
  nomaxvalue
  cache 3
  order
;

--
-- Vehiculo
--

create sequence vehiculo_seq
  start with 1
  increment by 1
  minvalue 1
  nomaxvalue
  cache 3
  order 
;

--
-- Tarjeta
--

create sequence tarjeta_seq
  start with 1
  increment by 1
  minvalue 1
  nomaxvalue
  cache 4
  order 
;

--
-- status_viaje
--

create sequence status_viaje_seq
  start with 1
  increment by 1
  minvalue 1
  nomaxvalue
  cache 3
  order 
;

--
-- viaje
--
create sequence viaje_seq
  start with 1
  increment by 1
  minvalue 1
  nomaxvalue 
  cache 3
  order
;

--
-- factura
--

create sequence factura_seq
  start with 1
  increment by 1
  minvalue 1
  nomaxvalue
  cache 3 
  order 
;

--
-- ubicacion_historico
--
create sequence ubicacion_historico_seq 
  start with 1
  increment by 1
  minvalue 1
  nomaxvalue 
  cache 3
  order 
;

--
---historico_status_viaje
--

create sequence historico_status_viaje_seq 
  start with 1
  increment by 1
  minvalue 1
  nomaxvalue 
  cache 3
  order 
;

--
-- QUEJA sequence
--


create sequence pago_seq
  start with 1
  increment by 1
  minvalue 1
  nomaxvalue 
  cache 5
  noorder
;
