 --@Autor(es): Enrique Job Calderón Olalde <@ksobrenat32>, Erick Nava Santiago
--@Fecha creación: 1 de diciembre de 2024
--@Descripción: Arichivo que contiene indices para utilizar posteriormente

--BASADOS EN FUNCIONES
--Indice para buscar por fecha los pagos que se tienen
create index pago_ifx on pago(to_char(fecha,'mm/yyyy'));

--COMPUESTOS UNIQUE

create unique index vehiculo_iuk on vehiculo(placas, vehiculo_id);

--TIPO UNIQUE 

create unique index factura_rfc_iuk on factura(rfc); 

--NO UNIQUE

create index tarjeta_numero_tarjeta_ix on tarjeta(numero_tarjeta);