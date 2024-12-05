--@Autor(es): Enrique Job Calderón Olalde <@ksobrenat32>, Erick Nava Santiago
--@Fecha creación: 1 de diciembre de 2024
--@Descripción: Archivo con vistas

-- Realizar un análisis y crear 3 o más vistas. Analizar posibles escenarios donde una vista podría ser adecuada.

prompt Conectando a la base de datos como administrador
CONNECT cn_proy_admin/cn_proy_admin@//localhost:1521/FREEPDB1

prompt Creando vistas

-- Vista 1: Vista de auto con marca y modelo

prompt Crear vista de auto con marca y modelo
DROP VIEW IF EXISTS v_auto_marca_modelo;
CREATE VIEW v_auto_marca_modelo AS
SELECT
    v.placas, v.anio,
    ma.descripcion AS descripcion_marca,
    ma.categoria AS categoria_marca,
    mo.nombre AS modelo_nombre,
    mo.descripcion AS modelo_descripcion
FROM vehiculo v
JOIN modelo mo ON v.modelo_id = mo.modelo_id
JOIN marca ma ON mo.marca_id = ma.marca_id;

-- Vista 2: Vista de usuario conductor completo, se puede usar para mostrar información de los conductores

prompt Crear vista de usuario conductor completo
DROP VIEW IF EXISTS v_usuario_conductor_completo;
CREATE VIEW v_usuario_conductor_completo AS
SELECT
    u.usuario_id, u.username, u.nombre, u.apellido_paterno, u.apellido_materno, u.email,
    ur.nombre AS usuario_recomendado_nombre, ur.apellido_paterno AS usuario_recomendado_apellido_paterno, ur.apellido_materno AS usuario_recomendado_apellido_materno,
    uc.num_licencia, uc.num_cedula, uc.foto, uc.descripcion
FROM usuario u
JOIN usuario_conductor uc ON u.usuario_id = uc.usuario_id
LEFT JOIN usuario ur ON u.usuario_recomendado_id = ur.usuario_id
WHERE u.es_conductor = 1;

-- Vista 3: Vista de viajes completados, viajes y su resumen_viaje.

prompt Crear vista de viajes completados
DROP VIEW IF EXISTS v_viajes_completados;
CREATE VIEW v_viajes_completados AS
SELECT
    v.fecha_hora_inicio, v.fecha_hora_fin, v.origen_latitud, v.origen_longitud, v.destino_latitud, v.destino_longitud, v.fecha_status,
    sv.clave AS status_clave, sv.descripcion AS status_descripcion,
    u.username AS username_usuario,
    ve.placas AS placas_auto,
    rv.importe, rv.calificacion_estrellas, rv.propina, rv.comentarios
FROM viaje v
JOIN resumen_viaje rv ON v.viaje_id = rv.viaje_id
JOIN status_viaje sv ON v.status_id = sv.status_id
JOIN usuario_cliente uc ON v.cliente_id = uc.usuario_id
JOIN usuario u ON uc.usuario_id = u.usuario_id
JOIN vehiculo ve ON v.vehiculo_id = ve.vehiculo_id
WHERE sv.clave = 'COMPLETADO';

