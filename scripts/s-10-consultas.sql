 --@Autor(es): Enrique Job Calderón Olalde <@ksobrenat32>, Erick Nava Santiago
--@Fecha creación: 1 de diciembre de 2024
--@Descripción: Archivo con casos de consulta

/*
Este archivo contendrá 5 o más consultas. El criterio es libre. Se debe emplear el uso
de los siguientes elementos.
- joins (inner join, natural join, outer join)
- funciones de agregación (group by y having)
- álgebra relacional (operadores set: union, intersect, minus).
- Subconsultas
- Consulta que involucre el uso de un sinónimo
- Consulta que involucre el uso de una vista
- Consulta que involucre una tabla temporal
- Consulta que involucre a una tabla externa.
● No es necesario crear una consulta por cada elemento. En una misma consulta
pueden incluirse varios de los elementos anteriores.
*/

CONNECT cn_proy_admin/cn_proy_admin@//localhost:1521/FREEPDB1

-- Consulta con funciones de agregación y joins.

prompt Consulta 1: Buscamos los viajes que han sido cobrados por completo.

SELECT
  v.viaje_id, v.fecha_hora_inicio, rv.importe, SUM(c.porcentaje) AS porcentaje_cobertura
FROM
  viaje v
  JOIN resumen_viaje rv ON v.viaje_id = rv.viaje_id
  JOIN cobro c ON v.viaje_id = c.viaje_id
GROUP BY
  v.viaje_id, v.fecha_hora_inicio, v.fecha_hora_fin, rv.importe
HAVING
  SUM(c.porcentaje) = 100;

-- Consulta con algebra relacional.

prompt Consulta 2: Buscamos ver todas las tarjetas que ya se encuentren vencidas y que no cuenten con cobros.

SELECT
  tarjeta_id, numero_tarjeta, mes, anio
FROM
  (
    SELECT
      *
    FROM
      tarjeta
    MINUS
    (
      SELECT
        t.*
      FROM
        tarjeta t
        JOIN cobro c ON t.tarjeta_id = c.tarjeta_id
      INTERSECT
      SELECT
        *
      FROM
        tarjeta
      WHERE
        anio < EXTRACT(YEAR FROM SYSDATE) OR
        (anio = EXTRACT(YEAR FROM SYSDATE) AND mes < EXTRACT(MONTH FROM SYSDATE))
    )
  )
;

-- Consulta con subconsultas y sinónimos.

prompt Consulta 3: Buscamos los conductores con coche y que no tengan ni una sola queja.

SELECT u.usuario_id, u.nombre, u.apellido_paterno, u.apellido_materno
FROM
  cn_usuario u
  JOIN cn_usuario_conductor uc ON u.usuario_id = uc.usuario_id
  JOIN cn_vehiculo v ON v.usuario_id = uc.usuario_id
WHERE
  v.vehiculo_id NOT IN (
    SELECT
      v.vehiculo_id
    FROM
      viaje v
      LEFT JOIN queja q ON v.viaje_id = q.viaje_id
  )
;

-- Consulta con vistas y tablas externas.

prompt Consulta 4: Buscamos toda la información de los autos con multas

SELECT
  va.placas, va.anio, va.descripcion_marca, va.categoria_marca, va.modelo_nombre, va.modelo_descripcion,
  m.monto, m.fecha_multa, m.descripcion
FROM
  v_auto_marca_modelo va
  JOIN multas_ext m ON va.placas = m.placa
;

-- Consulta con tablas temporales.

prompt Crear vehículos candidatos de prueba

-- Crear vehiculo_candidato

prompt Crear vehículos candidatos

INSERT INTO vehiculo_candidato
    (vehiculo_id, longitud, latitud, activo)
VALUES
    (1, -99.1332, 19.4326,  1);

INSERT INTO vehiculo_candidato
    (vehiculo_id, longitud, latitud, activo)
VALUES
    (2, -99.1332, 19.4126, 0);

INSERT INTO vehiculo_candidato
    (vehiculo_id, longitud, latitud, activo)
VALUES
    (3, -99.1332, 19.4226, 1);

prompt Consulta 5: Buscamos los vehículos candidatos activos

SELECT
  v.placas, v.anio, va.longitud, va.latitud
FROM
  vehiculo_candidato va
  JOIN vehiculo v ON va.vehiculo_id = v.vehiculo_id
WHERE
  va.activo = 1
;

