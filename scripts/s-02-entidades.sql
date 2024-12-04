--@Autor(es): Enrique Job Calderón Olalde <@ksobrenat32>, Erick Nava Santiago
--@Fecha creación: 1 de diciembre de 2024
--@Descripción:
-- - Este archivo contendrá el código DDL empleado para crear las tablas del caso de estudio. El código no deberá ser creado con ER-Studio. Todas las restricciones deberán tener un nombre asignado.
-- - Se deberá hacer uso de todos los tipos de restricciones vistas en clase: unique, check, primary key, foreign key.
-- - La definición de algunas tablas deberá incluir el uso de default, seleccionar al menos un caso donde pueda aplicarse.
-- - Seleccionar al menos un caso donde sea factible emplear una columna virtual. De ser posible se pueden crear nuevas tablas que hagan uso de este tipo de columnas.
-- - Verificar la existencia de atributos derivados. De no existir se puede agregar algún campo para reproducir el escenario. Los atributos derivados son excelentes candidatos para crear tablas virtuales.

prompt Conectando a la base de datos
CONNECT cn_proy_admin/cn_proy_admin@//localhost:1521/FREEPDB1

prompt Creando tablas

prompt Crear tabla usuario
DROP TABLE IF EXISTS usuario;
CREATE TABLE usuario (
    usuario_id NUMBER(10,0) default usuario_seq.nextval constraint usuario_pk primary key,
    username VARCHAR2(40) not null unique,
    nombre VARCHAR2(40) not null,
    apellido_paterno VARCHAR2(40) not null,
    apellido_materno VARCHAR2(40),
    email VARCHAR2(40) not null unique,
    contrasenia VARCHAR2(20) not null,
    es_cliente NUMBER(1,0) not null,
    es_administrador NUMBER(1,0) not null,
    es_conductor NUMBER(1,0) not null,
    usuario_recomendado_id NUMBER(10,0) constraint usuario_usuario_recomendado_id_fk references usuario(usuario_id),
    constraint usuario_tipo_ck check(
        (es_conductor = 1 and es_administrador = 0) or
        (es_conductor = 0 and es_administrador = 1) or
        (es_conductor = 0 and es_administrador = 0)
    )
);

prompt Crear tabla descuento
DROP TABLE IF EXISTS descuento;
CREATE TABLE descuento (
    descuento_id NUMBER(10,0) default descuento_seq.nextval constraint descuento_pk primary key,
    importe NUMBER(5,2) not null,
    vigencia DATE not null,
    descripcion VARCHAR2(400) not null,
    usuario_id NUMBER(10,0) not null constraint descuento_usuario_id_fk references usuario(usuario_id)
);

prompt Crear tabla usuario_conductor
DROP TABLE IF EXISTS usuario_conductor;
CREATE TABLE usuario_conductor (
    usuario_id NUMBER(10,0) constraint usuario_conductor_pk primary key,
    num_licencia VARCHAR2(18) not null,
    num_cedula VARCHAR2(18) not null,
    foto BLOB not null,
    descripcion VARCHAR2(3000),
    constraint usuario_conductor_usuario_id_fk foreign key(usuario_id) references usuario(usuario_id)
);

prompt Crear tabla usuario_administrador
DROP TABLE IF EXISTS usuario_administrador;
CREATE TABLE usuario_administrador (
    usuario_id NUMBER(10,0) constraint usuario_administrador_pk primary key,
    codigo NUMBER(6,0) not null,
    certificado BLOB not null,
    num_cedula VARCHAR2(16) not null,
    constraint usuario_administrador_usuario_id_fk foreign key(usuario_id) references usuario(usuario_id)
);

prompt Crear tabla usuario_cliente
DROP TABLE IF EXISTS usuario_cliente;
CREATE TABLE usuario_cliente (
    usuario_id NUMBER(10,0) constraint usuario_cliente_pk primary key,
    fecha_registro DATE default SYSDATE not null,
    num_celular VARCHAR2(10) not null,
    constraint usuario_cliente_usuario_id_fk foreign key(usuario_id) references usuario(usuario_id)
);

prompt Crear tabla pago
DROP TABLE IF EXISTS pago;
CREATE TABLE pago (
    usuario_id NUMBER(10,0) constraint pago_usuario_id_fk references usuario_conductor(usuario_id),
    folio NUMBER(8,0),
    fecha DATE not null,
    monto_total NUMBER(7,2) not null,
    constraint pago_pk primary key(usuario_id, folio)
);

prompt Crear tabla tags
DROP TABLE IF EXISTS tags;
CREATE TABLE tags (
    tag_id NUMBER(8,0) default tags_seq.nextval constraint tags_pk primary key,
    clave VARCHAR2(40) not null,
    descripcion VARCHAR2(200) not null
);

prompt Crear tabla tags_conductor
DROP TABLE IF EXISTS tags_conductor;
CREATE TABLE tags_conductor (
    usuario_id NUMBER(10,0) constraint tags_conductor_usuario_id_fk references usuario_conductor(usuario_id),
    tag_id NUMBER(8,0) constraint tags_conductor_tag_id_fk references tags(tag_id),
    contador NUMBER(8,0) not null,
    constraint tags_conductor_pk primary key(usuario_id, tag_id)
);

prompt Crear tabla marca
DROP TABLE IF EXISTS marca;
CREATE TABLE marca (
    marca_id NUMBER(10,0) default marca_seq.nextval constraint marca_pk primary key,
    descripcion VARCHAR2(400) not null,
    categoria NUMBER(1,0) not null,
    constraint marca_categoria_ck check(categoria in (1, 2, 3))
);

prompt Crear tabla modelo
DROP TABLE IF EXISTS modelo;
CREATE TABLE modelo (
    modelo_id NUMBER(10,0) default modelo_seq.nextval constraint modelo_pk primary key,
    nombre VARCHAR2(40) not null,
    descripcion VARCHAR2(400) not null,
    marca_id NUMBER(10,0) not null constraint modelo_marca_id_fk references marca(marca_id)
);

prompt Crear tabla vehiculo
DROP TABLE IF EXISTS vehiculo;
CREATE TABLE vehiculo (
    vehiculo_id NUMBER(10,0) default vehiculo_seq.nextval constraint vehiculo_pk primary key,
    placas VARCHAR(7) not null,
    anio NUMBER(4,0) not null,
    modelo_id NUMBER(10,0) not null constraint vehiculo_modelo_id_fk references modelo(modelo_id),
    usuario_id NUMBER(10,0) not null constraint vehiculo_usuario_id_fk references usuario_conductor(usuario_id)
);

prompt Crear tabla tarjeta
DROP TABLE IF EXISTS tarjeta;
CREATE TABLE tarjeta (
    tarjeta_id NUMBER(10,0) default tarjeta_seq.nextval constraint tarjeta_pk primary key,
    numero_tarjeta VARCHAR2(16) not null,
    mes NUMBER(2,0) not null,
    anio NUMBER(2,0) not null,
    usuario_id NUMBER(10,0) not null constraint tarjeta_usuario_id_fk references usuario_cliente(usuario_id)
);

prompt Crear tabla status_viaje
DROP TABLE IF EXISTS status_viaje;
CREATE TABLE status_viaje (
    status_id NUMBER(10,0) default status_viaje_seq.nextval constraint status_viaje_pk primary key,
    clave VARCHAR2(20) not null,
    descripcion VARCHAR2(200) not null
);

prompt Crear tabla viaje
DROP TABLE IF EXISTS viaje;
CREATE TABLE viaje (
    viaje_id NUMBER(10,0) default viaje_seq.nextval constraint viaje_pk primary key,
    fecha_hora_inicio DATE not null,
    fecha_hora_fin DATE not null,
    origen_longitud NUMBER(9,6) not null,
    origen_latitud NUMBER(9,6) not null,
    destino_longitud NUMBER(9,6) not null,
    destino_latitud NUMBER(9,6) not null,
    fecha_status DATE not null,
    status_id NUMBER(10,0) not null constraint viaje_status_id_fk references status_viaje(status_id),
    cliente_id NUMBER(10,0) not null constraint viaje_cliente_id_fk references usuario_cliente(usuario_id),
    vehiculo_id NUMBER(10,0) not null constraint viaje_vehiculo_id_fk references vehiculo(vehiculo_id)
);

prompt Crear tabla resumen_viaje
DROP TABLE IF EXISTS resumen_viaje;
CREATE TABLE resumen_viaje (
    viaje_id NUMBER(10,0) constraint resumen_viaje_viaje_id_fk references viaje(viaje_id),
    calificacion_estrellas NUMBER(1,0) constraint resumen_viaje_calificacion_estrellas_ck check(calificacion_estrellas between 1 and 5),
    propina NUMBER(5,2),
    comentarios VARCHAR2(200),
    importe NUMBER(7,2) not null,
    constraint resumen_viaje_pk primary key(viaje_id)
);

prompt Crear tabla factura
DROP TABLE IF EXISTS factura;
CREATE TABLE factura (
    factura_id NUMBER(10,0) default factura_seq.nextval constraint factura_pk primary key,
    fecha DATE not null,
    importe NUMBER(7,2) not null,
    archivo BLOB not null,
    rfc VARCHAR2(13) not null,
    direccion VARCHAR2(200) not null
);


prompt Crear tabla ubicacion_historico
DROP TABLE IF EXISTS ubicacion_historico;
CREATE TABLE ubicacion_historico (
    ubicacion_historico_id NUMBER(10,0) default ubicacion_historico_seq.nextval constraint ubicacion_historico_pk primary key,
    fecha_hora DATE not null,
    longitud NUMBER(9,6) not null,
    latitud NUMBER(9,6) not null,
    viaje_id NUMBER(10,0) not null constraint ubicacion_historico_viaje_id_fk references viaje(viaje_id)
);

prompt Crear tabla historico_status_viaje
DROP TABLE IF EXISTS historico_status_viaje;
CREATE TABLE historico_status_viaje (
    historico_status_viaje_id NUMBER(10,0) default historico_status_viaje_seq.nextval constraint historico_status_viaje_pk primary key,
    fecha_status DATE not null,
    viaje_id NUMBER(10,0) not null constraint historico_status_viaje_viaje_id_fk references viaje(viaje_id),
    status_id NUMBER(10,0) not null constraint historico_status_viaje_status_id_fk references status_viaje(status_id)
);

prompt Crear tabla cobro
DROP TABLE IF EXISTS cobro;
CREATE TABLE cobro (
    viaje_id NUMBER(10,0) constraint cobro_viaje_id_fk references viaje(viaje_id),
    tarjeta_id NUMBER(10,0) not null constraint cobro_tarjeta_id_fk references tarjeta(tarjeta_id),
    porcentaje NUMBER(5,2) not null,
    monto_total NUMBER(7,2) not null,
    monto_porcentaje AS (monto_total * porcentaje),
    constraint cobro_pk primary key(viaje_id, tarjeta_id)
);

prompt Crear tabla queja
DROP TABLE IF EXISTS queja;
CREATE TABLE queja (
    queja_id NUMBER(10,0) default queja_seq.nextval constraint queja_pk primary key,
    titulo VARCHAR2(40) not null,
    fecha DATE not null,
    descripcion VARCHAR2(400) not null,
    resultado VARCHAR2(400),
    viaje_id NUMBER(10,0) not null constraint queja_viaje_id_fk references viaje(viaje_id),
    administrador_id NUMBER(10,0) constraint queja_administrador_id_fk references usuario_administrador(usuario_id)
);

