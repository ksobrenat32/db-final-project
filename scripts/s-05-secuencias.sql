--@Autor(es): Enrique Job Calderón Olalde <@ksobrenat32>, Erick Nava Santiago
--@Fecha creación: 1 de diciembre de 2024
--@Descripción: Archivo con las secuencias


-- Este archivo contendrá la definición de todas las secuencias necesarias para poder
-- insertar registros en tablas que requieran la generación de valores secuenciales.
-- Todas las secuencias deberán iniciar en un número seleccionado por el equipo.

prompt Conectando a la base de datos
CONNECT cn_proy_admin/cn_proy_admin@//localhost:1521/FREEPDB1

-- Contienen start with 1, increment by 1, minvalue 1, nomaxvalue, cache 3, order

prompt Crear secuencia usuario_seq para usuario_id
DROP SEQUENCE IF EXISTS usuario_seq;
CREATE SEQUENCE usuario_seq
    start with 1
    increment by 1
    minvalue 1
    nomaxvalue
    cache 3
    order
;


prompt Crear secuencia descuento_seq para descuento_id
DROP SEQUENCE IF EXISTS descuento_seq;
CREATE SEQUENCE descuento_seq
    start with 1
    increment by 1
    minvalue 1
    nomaxvalue
    cache 3
    order
;

prompt Crear tabla secuencia tags_seq para tag_id
DROP SEQUENCE IF EXISTS tags_seq;
CREATE SEQUENCE tags_seq
    start with 1
    increment by 1
    minvalue 1
    nomaxvalue
    cache 3
    order
;

prompt Crear secuencia marca_seq para marca_id
DROP SEQUENCE IF EXISTS marca_seq;
CREATE SEQUENCE marca_seq
    start with 1
    increment by 1
    minvalue 1
    nomaxvalue
    cache 3
    order
;

prompt Crear secuencia modelo_seq para modelo_id
DROP SEQUENCE IF EXISTS modelo_seq;
CREATE SEQUENCE modelo_seq
    start with 1
    increment by 1
    minvalue 1
    nomaxvalue
    cache 3
    order
;

prompt Crear secuencia vehiculo_seq para vehiculo_id
DROP SEQUENCE IF EXISTS vehiculo_seq;
CREATE SEQUENCE vehiculo_seq
    start with 1
    increment by 1
    minvalue 1
    nomaxvalue
    cache 3
    order
;

prompt Crear secuencia tarjeta_seq para tarjeta_id
DROP SEQUENCE IF EXISTS tarjeta_seq;
CREATE SEQUENCE tarjeta_seq
    start with 1
    increment by 1
    minvalue 1
    nomaxvalue
    cache 3
    order
;

prompt Crear secuencia status_viaje_seq para status_id
DROP SEQUENCE IF EXISTS status_viaje_seq;
CREATE SEQUENCE status_viaje_seq
    start with 1
    increment by 1
    minvalue 1
    nomaxvalue
    cache 3
    order
;

prompt Crear secuencia viaje_seq para viaje_id
DROP SEQUENCE IF EXISTS viaje_seq;
CREATE SEQUENCE viaje_seq
    start with 1
    increment by 1
    minvalue 1
    nomaxvalue
    cache 3
    order
;

prompt Crear secuencia factura_seq para factura_id
DROP SEQUENCE IF EXISTS factura_seq;
CREATE SEQUENCE factura_seq
    start with 1
    increment by 1
    minvalue 1
    nomaxvalue
    cache 3
    order
;

prompt Crear secuencia ubicacion_historico_seq para ubicacion_historico_id
DROP SEQUENCE IF EXISTS ubicacion_historico_seq;
CREATE SEQUENCE ubicacion_historico_seq
    start with 1
    increment by 1
    minvalue 1
    nomaxvalue
    cache 3
    order
;

prompt Crear secuencia historico_status_viaje_seq para historico_status_viaje_id
DROP SEQUENCE IF EXISTS historico_status_viaje_seq;
CREATE SEQUENCE historico_status_viaje_seq
    start with 1
    increment by 1
    minvalue 1
    nomaxvalue
    cache 3
    order
;

prompt Crear secuencia queja_seq para queja_id
DROP SEQUENCE IF EXISTS queja_seq;
CREATE SEQUENCE queja_seq
    start with 1
    increment by 1
    minvalue 1
    nomaxvalue
    cache 3
    order
;
