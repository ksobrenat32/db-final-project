--@Autor(es): Enrique Job Calderón Olalde <@ksobrenat32>, Erick Nava Santiago
--@Fecha creación: 1 de diciembre de 2024
--@Descripción: Archivo que contiene índices.

-- Realizar un análisis y seleccionar algunos casos donde el uso de índices pudiera ser adecuado

prompt Crear índices

-- BASADOS EN FUNCIONES

-- Índice para buscar por fecha los pagos que se tienen por mes
prompt Crear indice para buscar por fecha los pagos que se tienen por mes
DROP INDEX IF EXISTS pago_mes_ifx;
create index pago_mes_ifx on pago(to_char(fecha,'mm'));

-- Índice para buscar por fecha los pagos que se tienen por año
prompt Crear indice para buscar por fecha los pagos que se tienen por año
DROP INDEX IF EXISTS pago_anio_ifx;
create index pago_anio_ifx on pago(to_char(fecha,'yyyy'));

-- COMPUESTOS UNIQUE

-- Índice único para placas y vehículo_id en vehículo, esto pues no puede haber un vehículo con más de una placa.
prompt Crear índice único para placas y vehículo_id en vehículo
DROP INDEX IF EXISTS vehiculo_placas_vehiculo_iuk;
create unique index vehiculo_placas_vehiculo_iuk on vehiculo(placas, vehiculo_id);

-- COMPUESTO

-- Índice para viaje_id y administrador_id en queja, esto pues se suele buscar que las quejas de cada administrador para hacer eficiente las solicitudes de los mismos.
prompt Crear índice para viaje_id y administrador_id en queja
DROP INDEX IF EXISTS queja_administrador_viaje_ix;
create index queja_administrador_viaje_ix on queja(viaje_id, administrador_id);

-- UNIQUE

-- Índice único para correo electrónico, pues no puede haber dos usuarios con el mismo correo.
prompt Crear índice único para correo electrónico
DROP INDEX IF EXISTS usuario_email_iuk;
create unique index usuario_email_iuk on usuario(email);

-- Índice único para teléfono de usuario_cliente, pues no puede haber dos usuarios con el mismo teléfono.
prompt Crear índice único para número de celular de usuario_cliente
DROP INDEX IF EXISTS usuario_cliente_num_celular_iuk;
create unique index usuario_cliente_num_celular_iuk on usuario_cliente(num_celular);

-- Índice único para número de tarjeta, pues no puede haber dos tarjetas con el mismo número.
prompt Crear índice único para número de tarjeta
DROP INDEX IF EXISTS tarjeta_numero_tarjeta_iuk;
create unique index tarjeta_numero_tarjeta_iuk on tarjeta(numero_tarjeta);

-- ÍNDICES SIMPLES

-- Índice para las placas, pues se suele utilizar para verificar que no existan multas pendientes en un vehículo.
prompt Crear índice para las placas
DROP INDEX IF EXISTS vehiculo_placas_ix;
create index vehiculo_placas_ix on vehiculo(placas);

-- Índice para los rfc, pues al resolver problemas de contabilidad se suele buscar por este campo.
prompt Crear índice para los rfc
DROP INDEX IF EXISTS factura_rfc_ix;
create index factura_rfc_ix on factura(rfc);
