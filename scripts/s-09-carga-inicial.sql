--@Autor(es): Enrique Job Calderón Olalde <@ksobrenat32>, Erick Nava Santiago
--@Fecha creación: 1 de diciembre de 2024
--@Descripción: Archivo con carga inicial de datos

-- Este script contendrá algunos datos de prueba y carga inicial para poder ilustrar el correcto funcionamiento de la base de datos.

-- Conectando a la base de datos
CONNECT cn_proy_admin/cn_proy_admin@//localhost:1521/FREEPDB1

-- Creación de usuarios cliente
prompt Creando usuarios cliente

-- Usuario cliente 1
INSERT INTO usuario
    (username, nombre, apellido_paterno, apellido_materno, email, contrasenia, es_cliente, es_administrador, es_conductor, usuario_recomendado_id)
VALUES
    ('user1', 'Juan', 'Pérez', 'García', 'juan_perez1@correo.com', '123456', 1, 0, 0, NULL);

DECLARE
    v_usuario_ID usuario.usuario_id%TYPE;
BEGIN
    SELECT usuario_id
    INTO v_usuario_ID
    FROM usuario
    WHERE username = 'user1';

    INSERT INTO usuario_cliente
        (usuario_id, num_celular)
    VALUES
        (v_usuario_ID, '1234567890');
END;
/

-- Usuario cliente 2
INSERT INTO usuario
    (username, nombre, apellido_paterno, apellido_materno, email, contrasenia, es_cliente, es_administrador, es_conductor, usuario_recomendado_id)
VALUES
    ('user2', 'María', 'González', 'Martínez', 'maria_gonzalez2@correo.com', '123456', 1, 0, 0, NULL);

DECLARE
    v_usuario_ID usuario.usuario_id%TYPE;
BEGIN
    SELECT usuario_id
    INTO v_usuario_ID
    FROM usuario
    WHERE username = 'user2';

    INSERT INTO usuario_cliente
        (usuario_id, num_celular)
    VALUES
        (v_usuario_ID, '0987654321');
END;
/

-- Usuario cliente 3
INSERT INTO usuario
    (username, nombre, apellido_paterno, apellido_materno, email, contrasenia, es_cliente, es_administrador, es_conductor, usuario_recomendado_id)
VALUES
    ('user3', 'José', 'Hernández', 'López', 'jose_hernandez3@correo.com', '123456', 1, 0, 0, NULL);

DECLARE
    v_usuario_ID usuario.usuario_id%TYPE;
BEGIN
    SELECT usuario_id
    INTO v_usuario_ID
    FROM usuario
    WHERE username = 'user3';

    INSERT INTO usuario_cliente
        (usuario_id, num_celular)
    VALUES
        (v_usuario_ID, '1122334455');
END;
/

-- Usuario cliente 4
INSERT INTO usuario
    (username, nombre, apellido_paterno, apellido_materno, email, contrasenia, es_cliente, es_administrador, es_conductor, usuario_recomendado_id)
VALUES
    ('user4', 'Luis', 'Ramírez', 'Torres', 'luis_ramirez4@correo.com', '123456', 1, 0, 0, NULL);

DECLARE
    v_usuario_ID usuario.usuario_id%TYPE;
BEGIN
    SELECT usuario_id
    INTO v_usuario_ID
    FROM usuario
    WHERE username = 'user4';

    INSERT INTO usuario_cliente
        (usuario_id, num_celular)
    VALUES
        (v_usuario_ID, '2233445566');
END;
/

-- Usuario cliente 5
INSERT INTO usuario
    (username, nombre, apellido_paterno, apellido_materno, email, contrasenia, es_cliente, es_administrador, es_conductor, usuario_recomendado_id)
VALUES
    ('user5', 'Ana', 'López', 'Gómez', 'ana_lopez5@correo.com', '123456', 1, 0, 0, NULL);

DECLARE
    v_usuario_ID usuario.usuario_id%TYPE;
BEGIN
    SELECT usuario_id
    INTO v_usuario_ID
    FROM usuario
    WHERE username = 'user5';

    INSERT INTO usuario_cliente
        (usuario_id, num_celular)
    VALUES
        (v_usuario_ID, '3344556677');
END;
/

-- Usuario cliente 6
INSERT INTO usuario
    (username, nombre, apellido_paterno, apellido_materno, email, contrasenia, es_cliente, es_administrador, es_conductor, usuario_recomendado_id)
VALUES
    ('user6', 'Carlos', 'Sánchez', 'Martínez', 'carlos_sanchez6@correo.com', '123456', 1, 0, 0, NULL);

DECLARE
    v_usuario_ID usuario.usuario_id%TYPE;
BEGIN
    SELECT usuario_id
    INTO v_usuario_ID
    FROM usuario
    WHERE username = 'user6';

    INSERT INTO usuario_cliente
        (usuario_id, num_celular)
    VALUES
        (v_usuario_ID, '4455667788');
END;
/

-- Usuario cliente 7
INSERT INTO usuario
    (username, nombre, apellido_paterno, apellido_materno, email, contrasenia, es_cliente, es_administrador, es_conductor, usuario_recomendado_id)
VALUES
    ('user7', 'Laura', 'García', 'Hernández', 'laura_garcia7@correo.com', '123456', 1, 0, 0, NULL);

DECLARE
    v_usuario_ID usuario.usuario_id%TYPE;
BEGIN
    SELECT usuario_id
    INTO v_usuario_ID
    FROM usuario
    WHERE username = 'user7';

    INSERT INTO usuario_cliente
        (usuario_id, num_celular)
    VALUES
        (v_usuario_ID, '5566778899');
END;
/

-- Usuario cliente 8
INSERT INTO usuario
    (username, nombre, apellido_paterno, apellido_materno, email, contrasenia, es_cliente, es_administrador, es_conductor, usuario_recomendado_id)
VALUES
    ('user8', 'Marta', 'Fernández', 'Pérez', 'marta_fernandez8@correo.com', '123456', 1, 0, 0, NULL);

DECLARE
    v_usuario_ID usuario.usuario_id%TYPE;
BEGIN
    SELECT usuario_id
    INTO v_usuario_ID
    FROM usuario
    WHERE username = 'user8';

    INSERT INTO usuario_cliente
        (usuario_id, num_celular)
    VALUES
        (v_usuario_ID, '6677889900');
END;
/

-- Creación de usuarios administradores
prompt Creando usuarios administradores

-- Usuario administrador 1
INSERT INTO usuario
    (username, nombre, apellido_paterno, apellido_materno, email, contrasenia, es_cliente, es_administrador, es_conductor, usuario_recomendado_id)
VALUES
    ('admin1', 'Carlos', 'Martínez', 'Gómez', 'carlos_martinez@correo.com', '123456', 0, 1, 0, 2);

DECLARE
    v_usuario_ID usuario.usuario_id%TYPE;
BEGIN
    SELECT usuario_id
    INTO v_usuario_ID
    FROM usuario
    WHERE username = 'admin1';

    INSERT INTO usuario_administrador
        (usuario_id, codigo, certificado, num_cedula)
    VALUES
        (v_usuario_ID, 123456, EMPTY_BLOB(), 'ABC123');
END;
/

-- Usuario administrador 2
INSERT INTO usuario
    (username, nombre, apellido_paterno, apellido_materno, email, contrasenia, es_cliente, es_administrador, es_conductor, usuario_recomendado_id)
VALUES
    ('admin2', 'Ana', 'Ramírez', 'Sánchez', 'ana_ramirez@correo.com', '123456', 0, 1, 0, null);

DECLARE
    v_usuario_ID usuario.usuario_id%TYPE;
BEGIN
    SELECT usuario_id
    INTO v_usuario_ID
    FROM usuario
    WHERE username = 'admin2';

    INSERT INTO usuario_administrador
        (usuario_id, codigo, certificado, num_cedula)
    VALUES
        (v_usuario_ID, 654321, EMPTY_BLOB(), 'XYZ987');
END;
/

-- Creación de usuarios conductores
prompt Creando usuarios conductores

-- Usuario conductor 1
INSERT INTO usuario
    (username, nombre, apellido_paterno, apellido_materno, email, contrasenia, es_cliente, es_administrador, es_conductor, usuario_recomendado_id)
VALUES
    ('driver1', 'Pedro', 'López', 'Hernández', 'pedro_lopez@correo.com', '123456', 0, 0, 1, 3);

DECLARE
    v_usuario_ID usuario.usuario_id%TYPE;
BEGIN
    SELECT usuario_id
    INTO v_usuario_ID
    FROM usuario
    WHERE username = 'driver1';

    INSERT INTO usuario_conductor
        (usuario_id, num_licencia, num_cedula, foto, descripcion)
    VALUES
        (v_usuario_ID, 'ABC123', 'XYZ987', EMPTY_BLOB(), 'Conductor con experiencia');
END;
/

-- Usuario conductor 2
INSERT INTO usuario
    (username, nombre, apellido_paterno, apellido_materno, email, contrasenia, es_cliente, es_administrador, es_conductor, usuario_recomendado_id)
VALUES
    ('driver2', 'Laura', 'Gómez', 'Martínez', 'laura_gomez@correo.com', '123456', 0, 0, 1, 2);

DECLARE
    v_usuario_ID usuario.usuario_id%TYPE;
BEGIN
    SELECT usuario_id
    INTO v_usuario_ID
    FROM usuario
    WHERE username = 'driver2';

    INSERT INTO usuario_conductor
        (usuario_id, num_licencia, num_cedula, foto, descripcion)
    VALUES
        (v_usuario_ID, 'XYZ987', 'ABC123', EMPTY_BLOB(), 'Conductora con excelente historial');
END;
/

-- Usuario conductor 3
INSERT INTO usuario
    (username, nombre, apellido_paterno, apellido_materno, email, contrasenia, es_cliente, es_administrador, es_conductor, usuario_recomendado_id)
VALUES
    ('driver3', 'Miguel', 'Santos', 'Rodríguez', 'miguel_santos@correo.com', '123456', 0, 0, 1, 1);

DECLARE
    v_usuario_ID usuario.usuario_id%TYPE;
BEGIN
    SELECT usuario_id
    INTO v_usuario_ID
    FROM usuario
    WHERE username = 'driver3';

    INSERT INTO usuario_conductor
        (usuario_id, num_licencia, num_cedula, foto, descripcion)
    VALUES
        (v_usuario_ID, 'LMN456', 'DEF789', EMPTY_BLOB(), 'Conductor con 5 años de experiencia');
END;
/

-- Usuario conductor 4
INSERT INTO usuario
    (username, nombre, apellido_paterno, apellido_materno, email, contrasenia, es_cliente, es_administrador, es_conductor, usuario_recomendado_id)
VALUES
    ('driver4', 'Sofía', 'Núñez', 'Pérez', 'sofia_nunez@correo.com', '123456', 0, 0, 1, 4);

DECLARE
    v_usuario_ID usuario.usuario_id%TYPE;
BEGIN
    SELECT usuario_id
    INTO v_usuario_ID
    FROM usuario
    WHERE username = 'driver4';

    INSERT INTO usuario_conductor
        (usuario_id, num_licencia, num_cedula, foto, descripcion)
    VALUES
        (v_usuario_ID, 'OPQ789', 'GHI012', EMPTY_BLOB(), 'Conductora con historial impecable');
END;
/

-- Usuario conductor 5
INSERT INTO usuario
    (username, nombre, apellido_paterno, apellido_materno, email, contrasenia, es_cliente, es_administrador, es_conductor, usuario_recomendado_id)
VALUES
    ('driver5', 'Luis', 'García', 'Fernández', 'luis_garcia@correo.com', '123456', 0, 0, 1, 5);

DECLARE
    v_usuario_ID usuario.usuario_id%TYPE;
BEGIN
    SELECT usuario_id
    INTO v_usuario_ID
    FROM usuario
    WHERE username = 'driver5';

    INSERT INTO usuario_conductor
        (usuario_id, num_licencia, num_cedula, foto, descripcion)
    VALUES
        (v_usuario_ID, 'RST012', 'JKL345', EMPTY_BLOB(), 'Conductor con experiencia en viajes largos');
END;
/

-- Crear usuarios conductores y clientes a la vez

-- Usuario cliente y conductor 1
INSERT INTO usuario
    (username, nombre, apellido_paterno, apellido_materno, email, contrasenia, es_cliente, es_administrador, es_conductor, usuario_recomendado_id)
VALUES
    ('user_driver1', 'Juan', 'Pérez', 'García', 'juan_driver1@correo.com', '123456', 1, 0, 1, 6);

DECLARE
    v_usuario_ID usuario.usuario_id%TYPE;
BEGIN
    SELECT usuario_id
    INTO v_usuario_ID
    FROM usuario
    WHERE username = 'user_driver1';

    INSERT INTO usuario_cliente
        (usuario_id, num_celular)
    VALUES
        (v_usuario_ID, '1234567891');

    INSERT INTO usuario_conductor
        (usuario_id, num_licencia, num_cedula, foto, descripcion)
    VALUES
        (v_usuario_ID, 'ABC123', 'XYZ987', EMPTY_BLOB(), 'Conductor con experiencia');
END;
/

-- Usuario cliente y conductor 2
INSERT INTO usuario
    (username, nombre, apellido_paterno, apellido_materno, email, contrasenia, es_cliente, es_administrador, es_conductor, usuario_recomendado_id)
VALUES
    ('user_driver2', 'María', 'González', 'Martínez', 'maria_driver2@correo.com', '123456', 1, 0, 1, 8);

DECLARE
    v_usuario_ID usuario.usuario_id%TYPE;
BEGIN
    SELECT usuario_id
    INTO v_usuario_ID
    FROM usuario
    WHERE username = 'user_driver2';

    INSERT INTO usuario_cliente
        (usuario_id, num_celular)
    VALUES
        (v_usuario_ID, '0987654322');

    INSERT INTO usuario_conductor
        (usuario_id, num_licencia, num_cedula, foto, descripcion)
    VALUES
        (v_usuario_ID, 'DEF456', 'GHI789', EMPTY_BLOB(), 'Conductora con experiencia');
END;
/

-- Usuario cliente y conductor 3
INSERT INTO usuario
    (username, nombre, apellido_paterno, apellido_materno, email, contrasenia, es_cliente, es_administrador, es_conductor, usuario_recomendado_id)
VALUES
    ('user_driver3', 'José', 'Hernández', 'López', 'jose_driver3@correo.com', '123456', 1, 0, 1, 9);

DECLARE
    v_usuario_ID usuario.usuario_id%TYPE;
BEGIN
    SELECT usuario_id
    INTO v_usuario_ID
    FROM usuario
    WHERE username = 'user_driver3';

    INSERT INTO usuario_cliente
        (usuario_id, num_celular)
    VALUES
        (v_usuario_ID, '1122334456');

    INSERT INTO usuario_conductor
        (usuario_id, num_licencia, num_cedula, foto, descripcion)
    VALUES
        (v_usuario_ID, 'GHI789', 'JKL012', EMPTY_BLOB(), 'Conductor con historial impecable');
END;
/

-- Usuario cliente y conductor 4
INSERT INTO usuario
    (username, nombre, apellido_paterno, apellido_materno, email, contrasenia, es_cliente, es_administrador, es_conductor, usuario_recomendado_id)
VALUES
    ('user_driver4', 'Luis', 'Ramírez', 'Torres', 'luis_driver4@correo.com', '123456', 1, 0, 1, 10);

DECLARE
    v_usuario_ID usuario.usuario_id%TYPE;
BEGIN
    SELECT usuario_id
    INTO v_usuario_ID
    FROM usuario
    WHERE username = 'user_driver4';

    INSERT INTO usuario_cliente
        (usuario_id, num_celular)
    VALUES
        (v_usuario_ID, '2233445567');

    INSERT INTO usuario_conductor
        (usuario_id, num_licencia, num_cedula, foto, descripcion)
    VALUES
        (v_usuario_ID, 'JKL012', 'MNO345', EMPTY_BLOB(), 'Conductor con experiencia en viajes largos');
END;
/

-- Usuario cliente y conductor 5
INSERT INTO usuario
    (username, nombre, apellido_paterno, apellido_materno, email, contrasenia, es_cliente, es_administrador, es_conductor, usuario_recomendado_id)
VALUES
    ('user_driver5', 'Ana', 'López', 'Gómez', 'ana_driver5@correo.com', '123456', 1, 0, 1, 11);

DECLARE
    v_usuario_ID usuario.usuario_id%TYPE;
BEGIN
    SELECT usuario_id
    INTO v_usuario_ID
    FROM usuario
    WHERE username = 'user_driver5';

    INSERT INTO usuario_cliente
        (usuario_id, num_celular)
    VALUES
        (v_usuario_ID, '3344556678');

    INSERT INTO usuario_conductor
        (usuario_id, num_licencia, num_cedula, foto, descripcion)
    VALUES
        (v_usuario_ID, 'MNO345', 'PQR678', EMPTY_BLOB(), 'Conductora con excelente historial');
END;
/

-- Crear usuarios administradores y clientes a la vez

-- Usuario cliente y administrador 1
INSERT INTO usuario
    (username, nombre, apellido_paterno, apellido_materno, email, contrasenia, es_cliente, es_administrador, es_conductor, usuario_recomendado_id)
VALUES
    ('user_admin1', 'Pedro', 'López', 'Hernández', 'pedro_admin1@correo.com', '123456', 1, 1, 0, 7);

DECLARE
    v_usuario_ID usuario.usuario_id%TYPE;
BEGIN
    SELECT usuario_id
    INTO v_usuario_ID
    FROM usuario
    WHERE username = 'user_admin1';

    INSERT INTO usuario_cliente
        (usuario_id, num_celular)
    VALUES
        (v_usuario_ID, '1234567892');

    INSERT INTO usuario_administrador
        (usuario_id, codigo, certificado, num_cedula)
    VALUES
        (v_usuario_ID, 123456, EMPTY_BLOB(), 'ABC123');
END;
/

-- Usuario cliente y administrador 2
INSERT INTO usuario
    (username, nombre, apellido_paterno, apellido_materno, email, contrasenia, es_cliente, es_administrador, es_conductor, usuario_recomendado_id)
VALUES
    ('user_admin2', 'María', 'González', 'Martínez', 'maria_admin2@correo.com', '123456', 1, 1, 0, 12);

DECLARE
    v_usuario_ID usuario.usuario_id%TYPE;
BEGIN
    SELECT usuario_id
    INTO v_usuario_ID
    FROM usuario
    WHERE username = 'user_admin2';

    INSERT INTO usuario_cliente
        (usuario_id, num_celular)
    VALUES
        (v_usuario_ID, '0987654323');

    INSERT INTO usuario_administrador
        (usuario_id, codigo, certificado, num_cedula)
    VALUES
        (v_usuario_ID, 654321, EMPTY_BLOB(), 'DEF456');
END;
/

-- Usuario cliente y administrador 3
INSERT INTO usuario
    (username, nombre, apellido_paterno, apellido_materno, email, contrasenia, es_cliente, es_administrador, es_conductor, usuario_recomendado_id)
VALUES
    ('user_admin3', 'José', 'Hernández', 'López', 'jose_admin3@correo.com', '123456', 1, 1, 0, 13);

DECLARE
    v_usuario_ID usuario.usuario_id%TYPE;
BEGIN
    SELECT usuario_id
    INTO v_usuario_ID
    FROM usuario
    WHERE username = 'user_admin3';

    INSERT INTO usuario_cliente
        (usuario_id, num_celular)
    VALUES
        (v_usuario_ID, '1122334457');

    INSERT INTO usuario_administrador
        (usuario_id, codigo, certificado, num_cedula)
    VALUES
        (v_usuario_ID, 987654, EMPTY_BLOB(), 'GHI789');
END;
/

-- Usuario cliente y administrador 4
INSERT INTO usuario
    (username, nombre, apellido_paterno, apellido_materno, email, contrasenia, es_cliente, es_administrador, es_conductor, usuario_recomendado_id)
VALUES
    ('user_admin4', 'Luis', 'Ramírez', 'Torres', 'luis_admin4@correo.com', '123456', 1, 1, 0, 14);

DECLARE
    v_usuario_ID usuario.usuario_id%TYPE;
BEGIN
    SELECT usuario_id
    INTO v_usuario_ID
    FROM usuario
    WHERE username = 'user_admin4';

    INSERT INTO usuario_cliente
        (usuario_id, num_celular)
    VALUES
        (v_usuario_ID, '2233445568');

    INSERT INTO usuario_administrador
        (usuario_id, codigo, certificado, num_cedula)
    VALUES
        (v_usuario_ID, 456789, EMPTY_BLOB(), 'JKL012');
END;
/

-- Usuario cliente y administrador 5
INSERT INTO usuario
    (username, nombre, apellido_paterno, apellido_materno, email, contrasenia, es_cliente, es_administrador, es_conductor, usuario_recomendado_id)
VALUES
    ('user_admin5', 'Ana', 'López', 'Gómez', 'ana_admin5@correo.com', '123456', 1, 1, 0, 15);

DECLARE
    v_usuario_ID usuario.usuario_id%TYPE;
BEGIN
    SELECT usuario_id
    INTO v_usuario_ID
    FROM usuario
    WHERE username = 'user_admin5';

    INSERT INTO usuario_cliente
        (usuario_id, num_celular)
    VALUES
        (v_usuario_ID, '3344556679');

    INSERT INTO usuario_administrador
        (usuario_id, codigo, certificado, num_cedula)
    VALUES
        (v_usuario_ID, 321654, EMPTY_BLOB(), 'MNO345');
END;
/

-- Crear marcas
prompt Creando marcas

INSERT INTO marca (descripcion, categoria)
VALUES ('Volkswagen', 2);

INSERT INTO marca (descripcion, categoria)
VALUES ('Chevrolet', 1);

INSERT INTO marca (descripcion, categoria)
VALUES ('Ford', 2);

INSERT INTO marca (descripcion, categoria)
VALUES ('Mercedes-Benz', 3);

INSERT INTO marca (descripcion, categoria)
VALUES ('Nissan', 1);

INSERT INTO marca (descripcion, categoria)
VALUES ('Toyota', 1);

-- Crear modelos
prompt Creando modelos

DECLARE
    v_marca_id marca.marca_id%TYPE;
BEGIN
    SELECT marca_id
    INTO v_marca_id
    FROM marca
    WHERE descripcion = 'Volkswagen';

    INSERT INTO modelo (nombre, descripcion, marca_id)
    VALUES ('Jetta', 'Sedán compacto', v_marca_id);

    INSERT INTO modelo (nombre, descripcion, marca_id)
    VALUES ('Golf', 'Hatchback compacto', v_marca_id);

    INSERT INTO modelo (nombre, descripcion, marca_id)
    VALUES ('Tiguan', 'SUV compacta', v_marca_id);
END;
/

DECLARE
    v_marca_id marca.marca_id%TYPE;
BEGIN
    SELECT marca_id
    INTO v_marca_id
    FROM marca
    WHERE descripcion = 'Chevrolet';

    INSERT INTO modelo (nombre, descripcion, marca_id)
    VALUES ('Aveo', 'Sedán subcompacto', v_marca_id);

    INSERT INTO modelo (nombre, descripcion, marca_id)
    VALUES ('Spark', 'Hatchback subcompacto', v_marca_id);

    INSERT INTO modelo (nombre, descripcion, marca_id)
    VALUES ('Trax', 'SUV subcompacta', v_marca_id);
END;
/

DECLARE
    v_marca_id marca.marca_id%TYPE;
BEGIN
    SELECT marca_id
    INTO v_marca_id
    FROM marca
    WHERE descripcion = 'Ford';

    INSERT INTO modelo (nombre, descripcion, marca_id)
    VALUES ('Fiesta', 'Sedán subcompacto', v_marca_id);

    INSERT INTO modelo (nombre, descripcion, marca_id)
    VALUES ('Focus', 'Hatchback compacto', v_marca_id);

    INSERT INTO modelo (nombre, descripcion, marca_id)
    VALUES ('Escape', 'SUV compacta', v_marca_id);
END;
/

DECLARE
    v_marca_id marca.marca_id%TYPE;
BEGIN
    SELECT marca_id
    INTO v_marca_id
    FROM marca
    WHERE descripcion = 'Mercedes-Benz';

    INSERT INTO modelo (nombre, descripcion, marca_id)
    VALUES ('Clase A', 'Sedán de lujo', v_marca_id);

    INSERT INTO modelo (nombre, descripcion, marca_id)
    VALUES ('Clase C', 'Sedán de lujo', v_marca_id);

    INSERT INTO modelo (nombre, descripcion, marca_id)
    VALUES ('Clase G', 'SUV de lujo', v_marca_id);
END;
/

DECLARE
    v_marca_id marca.marca_id%TYPE;
BEGIN
    SELECT marca_id
    INTO v_marca_id
    FROM marca
    WHERE descripcion = 'Nissan';

    INSERT INTO modelo (nombre, descripcion, marca_id)
    VALUES ('March', 'Sedán subcompacto', v_marca_id);

    INSERT INTO modelo (nombre, descripcion, marca_id)
    VALUES ('Versa', 'Sedán compacto', v_marca_id);

    INSERT INTO modelo (nombre, descripcion, marca_id)
    VALUES ('Kicks', 'SUV compacta', v_marca_id);
END;
/

DECLARE
    v_marca_id marca.marca_id%TYPE;
BEGIN
    SELECT marca_id
    INTO v_marca_id
    FROM marca
    WHERE descripcion = 'Toyota';

    INSERT INTO modelo (nombre, descripcion, marca_id)
    VALUES ('Yaris', 'Sedán subcompacto', v_marca_id);

    INSERT INTO modelo (nombre, descripcion, marca_id)
    VALUES ('Corolla', 'Sedán compacto', v_marca_id);

    INSERT INTO modelo (nombre, descripcion, marca_id)
    VALUES ('RAV4', 'SUV compacta', v_marca_id);
END;
/

-- Crear vehículos
prompt Crear vehículos de prueba

DECLARE
    v_modelo_id modelo.modelo_id%TYPE;
    v_usuario_id usuario.usuario_id%TYPE;
BEGIN
    SELECT modelo_id
    INTO v_modelo_id
    FROM modelo
    WHERE nombre = 'Jetta';

    SELECT usuario_id
    INTO v_usuario_id
    FROM usuario
    WHERE username = 'driver1';

    INSERT INTO vehiculo (placas, anio, modelo_id, usuario_id)
    VALUES ('ABC123', 2024, v_modelo_id, v_usuario_id);
END;
/

DECLARE
    v_modelo_id modelo.modelo_id%TYPE;
    v_usuario_id usuario.usuario_id%TYPE;
BEGIN
    SELECT modelo_id
    INTO v_modelo_id
    FROM modelo
    WHERE nombre = 'Aveo';

    SELECT usuario_id
    INTO v_usuario_id
    FROM usuario
    WHERE username = 'driver2';

    INSERT INTO vehiculo (placas, anio, modelo_id, usuario_id)
    VALUES ('XYZ987', 2023, v_modelo_id, v_usuario_id);
END;
/

-- Crear pagos

prompt Crear pagos de prueba

DECLARE
    v_usuario_id usuario.usuario_id%TYPE;
    v_contador pag.folio%TYPE;
BEGIN
    SELECT usuario_id
    INTO v_usuario_id
    FROM usuario
    WHERE username = 'driver1';

    v_contador := 1;

    FOR i IN 1..5 LOOP
        INSERT INTO pago (usuario_id, folio, fecha, monto_total)
        VALUES (v_usuario_id, v_contador, SYSDATE, 1000.00);

        v_contador := v_contador + 1;
    END LOOP;
END;
/

DECLARE
    v_usuario_id usuario.usuario_id%TYPE;
    v_contador pag.folio%TYPE;
BEGIN
    SELECT usuario_id
    INTO v_usuario_id
    FROM usuario
    WHERE username = 'driver2';

    v_contador := 1;

    FOR i IN 1..5 LOOP
        INSERT INTO pago (usuario_id, folio, fecha, monto_total)
        VALUES (v_usuario_id, v_contador, SYSDATE, 1500.00);

        v_contador := v_contador + 1;
    END LOOP;
END;
/

-- Crear tags

prompt Crear tags de prueba

INSERT INTO tags (clave, descripcion)
VALUES ('PUNTUALIDAD', 'Conductor puntual');

INSERT INTO tags (clave, descripcion)
VALUES ('AMABILIDAD', 'Conductor amable');

INSERT INTO tags (clave, descripcion)
VALUES ('PLATICA', 'Conductor platicador');

INSERT INTO tags (clave, descripcion)
VALUES ('MUSICA', 'Conductor con buena música');

INSERT INTO tags (clave, descripcion)
VALUES ('LIMPIEZA', 'Conductor limpio');

INSERT INTO tags (clave, descripcion)
VALUES ('SEGURIDAD', 'Conductor seguro');

-- Crear tags_conductor

prompt Crear tags de prueba para conductores

DECLARE
    v_usuario_id usuario.usuario_id%TYPE;
    v_tag_id tags.tag_id%TYPE;
BEGIN
    SELECT usuario_id
    INTO v_usuario_id
    FROM usuario
    WHERE username = 'driver1';

    SELECT tag_id
    INTO v_tag_id
    FROM tags
    WHERE clave = 'PUNTUALIDAD';

    INSERT INTO tags_conductor (usuario_id, tag_id, contador)
    VALUES (v_usuario_id, v_tag_id, 5);
END;
/

DECLARE
    v_usuario_id usuario.usuario_id%TYPE;
    v_tag_id tags.tag_id%TYPE;
BEGIN
    SELECT usuario_id
    INTO v_usuario_id
    FROM usuario
    WHERE username = 'driver2';

    SELECT tag_id
    INTO v_tag_id
    FROM tags
    WHERE clave = 'AMABILIDAD';

    INSERT INTO tags_conductor (usuario_id, tag_id, contador)
    VALUES (v_usuario_id, v_tag_id, 3);
END;
/

-- Crear tarjetas

prompt Crear tarjetas de prueba

DECLARE
    v_usuario_id usuario.usuario_id%TYPE;
BEGIN
    SELECT usuario_id
    INTO v_usuario_id
    FROM usuario
    WHERE username = 'user1';

    INSERT INTO tarjeta (usuario_id, numero_tarjeta, mes, anio)
    VALUES (v_usuario_ID, '1234567890123456', 12, 24);
END;
/

DECLARE
    v_usuario_id usuario.usuario_id%TYPE;
BEGIN
    SELECT usuario_id
    INTO v_usuario_id
    FROM usuario
    WHERE username = 'user2';

    INSERT INTO tarjeta (usuario_id, numero_tarjeta, mes, anio)
    VALUES (v_usuario_ID, '2345678901234567', 11, 25);
END;
/

DECLARE
    v_usuario_id usuario.usuario_id%TYPE;
BEGIN
    SELECT usuario_id
    INTO v_usuario_id
    FROM usuario
    WHERE username = 'user3';

    INSERT INTO tarjeta (usuario_id, numero_tarjeta, mes, anio)
    VALUES (v_usuario_ID, '3456789012345678', 10, 26);
END;
/

DECLARE
    v_usuario_id usuario.usuario_id%TYPE;
BEGIN
    SELECT usuario_id
    INTO v_usuario_id
    FROM usuario
    WHERE username = 'user4';

    INSERT INTO tarjeta (usuario_id, numero_tarjeta, mes, anio)
    VALUES (v_usuario_ID, '4567890123456789', 9, 27);
END;
/

DECLARE
    v_usuario_id usuario.usuario_id%TYPE;
BEGIN
    SELECT usuario_id
    INTO v_usuario_id
    FROM usuario
    WHERE username = 'user5';

    INSERT INTO tarjeta (usuario_id, numero_tarjeta, mes, anio)
    VALUES (v_usuario_ID, '5678901234567890', 8, 28);
END;
/

DECLARE
    v_usuario_id usuario.usuario_id%TYPE;
BEGIN
    SELECT usuario_id
    INTO v_usuario_id
    FROM usuario
    WHERE username = 'user6';

    INSERT INTO tarjeta (usuario_id, numero_tarjeta, mes, anio)
    VALUES (v_usuario_ID, '6789012345678901', 7, 29);
END;
/

DECLARE
    v_usuario_id usuario.usuario_id%TYPE;
BEGIN
    SELECT usuario_id
    INTO v_usuario_id
    FROM usuario
    WHERE username = 'user7';

    INSERT INTO tarjeta (usuario_id, numero_tarjeta, mes, anio)
    VALUES (v_usuario_ID, '7890123456789012', 6, 30);
END;
/

DECLARE
    v_usuario_id usuario.usuario_id%TYPE;
BEGIN
    SELECT usuario_id
    INTO v_usuario_id
    FROM usuario
    WHERE username = 'user8';

    INSERT INTO tarjeta (usuario_id, numero_tarjeta, mes, anio)
    VALUES (v_usuario_ID, '8901234567890123', 5, 31);
END;
/

-- Crear los status_viaje

prompt Creando status de viaje

INSERT INTO status_viaje (clave, descripcion)
VALUES ('PROGRAMADO', 'Viaje programado');

INSERT INTO status_viaje (clave, descripcion)
VALUES ('CONFIRMADO', 'Viaje confirmado');

INSERT INTO status_viaje (clave, descripcion)
VALUES ('EN CURSO', 'Viaje en curso');

INSERT INTO status_viaje (clave, descripcion)
VALUES ('TERMINADO', 'Viaje terminado');

INSERT INTO status_viaje (clave, descripcion)
VALUES ('POR COBRAR', 'Viaje por cobrar');

INSERT INTO status_viaje (clave, descripcion)
VALUES ('PAGADO', 'Viaje pagado');

INSERT INTO status_viaje (clave, descripcion)
VALUES ('CON ADEUDO', 'Viaje con adeudo');

INSERT INTO status_viaje (clave, descripcion)
VALUES ('CANCELADO', 'Viaje cancelado');

-- Crear los viajes con todo

prompt Creando viajes con resumen_viaje, ubicacion_historico e historico_status_viaje

DECLARE
    v_cliente_id usuario.usuario_id%TYPE;
    v_vehiculo_id vehiculo.vehiculo_id%TYPE;
    v_status_id status_viaje.status_id%TYPE;
    v_viaje_id viaje.viaje_id%TYPE;
BEGIN
    SELECT usuario_id
    INTO v_cliente_id
    FROM usuario
    WHERE username = 'user1';

    SELECT vehiculo_id
    INTO v_vehiculo_id
    FROM vehiculo
    WHERE placas = 'ABC123';

    SELECT status_id
    INTO v_status_id
    FROM status_viaje
    WHERE clave = 'PROGRAMADO';

    INSERT INTO viaje (fecha_hora_inicio, fecha_hora_fin, origen_latitud, origen_longitud, destino_latitud, destino_longitud, fecha_status, status_id, cliente_id, vehiculo_id)
    VALUES (SYSDATE, SYSDATE + 1, 19.4326, -99.1332, 20.4326, -100.1332, SYSDATE, v_status_id, v_cliente_id, v_vehiculo_id);

    SELECT viaje_id
    INTO v_viaje_id
    FROM viaje
    WHERE cliente_id = v_cliente_id AND vehiculo_id = v_vehiculo_id;

    INSERT INTO resumen_viaje (viaje_id, importe, calificacion_estrellas, propina, comentarios)
    VALUES (v_viaje_id, 1000.00, 5, 100.00, 'Excelente servicio');

    INSERT INTO ubicacion_historico (viaje_id, fecha_hora, latitud, longitud)
    VALUES (v_viaje_id, SYSDATE+(1/(24*60)), 19.4326, -99.1332);

    INSERT INTO ubicacion_historico (viaje_id, fecha_hora, latitud, longitud)
    VALUES (v_viaje_id, SYSDATE+(2/(24*60)), 19.4327, -99.1333);

    INSERT INTO historico_status_viaje (viaje_id, status_id, fecha_status)
    VALUES (v_viaje_id, v_status_id, SYSDATE+(1/(24*60)));

    INSERT INTO historico_status_viaje (viaje_id, status_id, fecha_status)
    VALUES (v_viaje_id, v_status_id, SYSDATE+(2/(24*60)));
END;
/

DECLARE
    v_cliente_id usuario.usuario_id%TYPE;
    v_vehiculo_id vehiculo.vehiculo_id%TYPE;
    v_status_id status_viaje.status_id%TYPE;
    v_viaje_id viaje.viaje_id%TYPE;
BEGIN
    SELECT usuario_id
    INTO v_cliente_id
    FROM usuario
    WHERE username = 'user2';

    SELECT vehiculo_id
    INTO v_vehiculo_id
    FROM vehiculo
    WHERE placas = 'XYZ987';

    SELECT status_id
    INTO v_status_id
    FROM status_viaje
    WHERE clave = 'PROGRAMADO';

    INSERT INTO viaje (fecha_hora_inicio, fecha_hora_fin, origen_latitud, origen_longitud, destino_latitud, destino_longitud, fecha_status, status_id, cliente_id, vehiculo_id)
    VALUES (SYSDATE, SYSDATE + 1, 19.4326, -99.1332, 20.4326, -100.1332, SYSDATE, v_status_id, v_cliente_id, v_vehiculo_id);

    SELECT viaje_id
    INTO v_viaje_id
    FROM viaje
    WHERE cliente_id = v_cliente_id AND vehiculo_id = v_vehiculo_id;

    INSERT INTO resumen_viaje (viaje_id, importe, calificacion_estrellas, propina, comentarios)
    VALUES (v_viaje_id, 1200.00, 4, 50.00, 'Buen servicio');

    INSERT INTO ubicacion_historico (viaje_id, fecha_hora, latitud, longitud)
    VALUES (v_viaje_id, SYSDATE+(1/(24*60)), 19.4326, -99.1332);

    INSERT INTO ubicacion_historico (viaje_id, fecha_hora, latitud, longitud)
    VALUES (v_viaje_id, SYSDATE+(2/(24*60)), 19.4327, -99.1333);

    INSERT INTO historico_status_viaje (viaje_id, status_id, fecha_status)
    VALUES (v_viaje_id, v_status_id, SYSDATE+(1/(24*60)));

    INSERT INTO historico_status_viaje (viaje_id, status_id, fecha_status)
    VALUES (v_viaje_id, v_status_id, SYSDATE+(2/(24*60)));
END;
/

DECLARE
    v_cliente_id usuario.usuario_id%TYPE;
    v_vehiculo_id vehiculo.vehiculo_id%TYPE;
    v_status_id status_viaje.status_id%TYPE;
    v_viaje_id viaje.viaje_id%TYPE;
BEGIN
    SELECT usuario_id
    INTO v_cliente_id
    FROM usuario
    WHERE username = 'user3';

    SELECT vehiculo_id
    INTO v_vehiculo_id
    FROM vehiculo
    WHERE placas = 'ABC123';

    SELECT status_id
    INTO v_status_id
    FROM status_viaje
    WHERE clave = 'PROGRAMADO';

    INSERT INTO viaje (fecha_hora_inicio, fecha_hora_fin, origen_latitud, origen_longitud, destino_latitud, destino_longitud, fecha_status, status_id, cliente_id, vehiculo_id)
    VALUES (SYSDATE, SYSDATE + 1, 19.4326, -99.1332, 20.4326, -100.1332, SYSDATE, v_status_id, v_cliente_id, v_vehiculo_id);

    SELECT viaje_id
    INTO v_viaje_id
    FROM viaje
    WHERE cliente_id = v_cliente_id AND vehiculo_id = v_vehiculo_id;

    INSERT INTO resumen_viaje (viaje_id, importe, calificacion_estrellas, propina, comentarios)
    VALUES (v_viaje_id, 1500.00, 5, 200.00, 'Excelente servicio');

    INSERT INTO ubicacion_historico (viaje_id, fecha_hora, latitud, longitud)
    VALUES (v_viaje_id, SYSDATE+(1/(24*60)), 19.4326, -99.1332);

    INSERT INTO ubicacion_historico (viaje_id, fecha_hora, latitud, longitud)
    VALUES (v_viaje_id, SYSDATE+(2/(24*60)), 19.4327, -99.1333);

    INSERT INTO historico_status_viaje (viaje_id, status_id, fecha_status)
    VALUES (v_viaje_id, v_status_id, SYSDATE+(1/(24*60)));

    INSERT INTO historico_status_viaje (viaje_id, status_id, fecha_status)
    VALUES (v_viaje_id, v_status_id, SYSDATE+(2/(24*60)));
END;
/

DECLARE
    v_cliente_id usuario.usuario_id%TYPE;
    v_vehiculo_id vehiculo.vehiculo_id%TYPE;
    v_status_id status_viaje.status_id%TYPE;
    v_viaje_id viaje.viaje_id%TYPE;
BEGIN
    SELECT usuario_id
    INTO v_cliente_id
    FROM usuario
    WHERE username = 'user4';

    SELECT vehiculo_id
    INTO v_vehiculo_id
    FROM vehiculo
    WHERE placas = 'XYZ987';

    SELECT status_id
    INTO v_status_id
    FROM status_viaje
    WHERE clave = 'PROGRAMADO';

    INSERT INTO viaje (fecha_hora_inicio, fecha_hora_fin, origen_latitud, origen_longitud, destino_latitud, destino_longitud, fecha_status, status_id, cliente_id, vehiculo_id)
    VALUES (SYSDATE, SYSDATE + 1, 19.4326, -99.1332, 20.4326, -100.1332, SYSDATE, v_status_id, v_cliente_id, v_vehiculo_id);

    SELECT viaje_id
    INTO v_viaje_id
    FROM viaje
    WHERE cliente_id = v_cliente_id AND vehiculo_id = v_vehiculo_id;

    INSERT INTO resumen_viaje (viaje_id, importe, calificacion_estrellas, propina, comentarios)
    VALUES (v_viaje_id, 1800.00, 4, 150.00, 'Buen servicio');

    INSERT INTO ubicacion_historico (viaje_id, fecha_hora, latitud, longitud)
    VALUES (v_viaje_id, SYSDATE+(1/(24*60)), 19.4326, -99.1332);

    INSERT INTO ubicacion_historico (viaje_id, fecha_hora, latitud, longitud)
    VALUES (v_viaje_id, SYSDATE+(2/(24*60)), 19.4327, -99.1333);

    INSERT INTO historico_status_viaje (viaje_id, status_id, fecha_status)
    VALUES (v_viaje_id, v_status_id, SYSDATE+(1/(24*60)));

    INSERT INTO historico_status_viaje (viaje_id, status_id, fecha_status)
    VALUES (v_viaje_id, v_status_id, SYSDATE+(2/(24*60)));
END;
/

-- Crear descuentos

prompt Crear descuentos de prueba

DECLARE
    v_usuario_id usuario.usuario_id%TYPE;
BEGIN
    SELECT usuario_id
    INTO v_usuario_id
    FROM usuario
    WHERE username = 'user1';

    INSERT INTO descuento (usuario_id, importe, vigencia, descripcion)
    VALUES (v_usuario_id, 100.00, SYSDATE + 30, 'Descuento por ser usuario nuevo');
END;
/

DECLARE
    v_usuario_id usuario.usuario_id%TYPE;
BEGIN
    SELECT usuario_id
    INTO v_usuario_id
    FROM usuario
    WHERE username = 'user2';

    INSERT INTO descuento (usuario_id, importe, vigencia, descripcion)
    VALUES (v_usuario_id, 150.00, SYSDATE + 30, 'Descuento por ser usuario nuevo');
END;
/

-- Crear facturas

prompt Crear facturas de prueba

DECLARE
    v_viaje_id viaje.viaje_id%TYPE;
BEGIN
    SELECT viaje_id
    INTO v_viaje_id
    FROM viaje
    WHERE cliente_id = 1;

    INSERT INTO factura (fecha, importe, archivo, rfc, direccion, viaje_id)
    VALUES (SYSDATE, 1000.00, EMPTY_BLOB(), 'ABC123456789', 'Calle 123 Colonia 456 Ciudad 789', v_viaje_id);
END;
/

DECLARE
    v_viaje_id viaje.viaje_id%TYPE;
BEGIN
    SELECT viaje_id
    INTO v_viaje_id
    FROM viaje
    WHERE cliente_id = 2;

    INSERT INTO factura (fecha, importe, archivo, rfc, direccion, viaje_id)
    VALUES (SYSDATE, 1200.00, EMPTY_BLOB(), 'DEF234567890', 'Calle 234 Colonia 567 Ciudad 890', v_viaje_id);
END;
/

-- Crear cobros

prompt Crear cobros de prueba

DECLARE
    v_viaje_id viaje.viaje_id%TYPE;
    v_tarjeta_id tarjeta.tarjeta_id%TYPE;
BEGIN
    SELECT viaje_id
    INTO v_viaje_id
    FROM viaje
    WHERE cliente_id = 1;

    SELECT tarjeta_id
    INTO v_tarjeta_id
    FROM tarjeta
    WHERE usuario_id = 1;

    INSERT INTO cobro (viaje_id, tarjeta_id, porcentaje, monto_total)
    VALUES (v_viaje_id, v_tarjeta_id, 100, 1000.00);
END;
/

DECLARE
    v_viaje_id viaje.viaje_id%TYPE;
    v_tarjeta_id tarjeta.tarjeta_id%TYPE;
BEGIN
    SELECT viaje_id
    INTO v_viaje_id
    FROM viaje
    WHERE cliente_id = 2;

    SELECT tarjeta_id
    INTO v_tarjeta_id
    FROM tarjeta
    WHERE usuario_id = 2;

    INSERT INTO cobro (viaje_id, tarjeta_id, porcentaje, monto_total)
    VALUES (v_viaje_id, v_tarjeta_id, 100, 1200.00);
END;
/

-- Crear quejas

prompt Crear quejas de prueba

DECLARE
    v_viaje_id viaje.viaje_id%TYPE;
    v_administrador_id usuario.usuario_id%TYPE;
BEGIN
    SELECT viaje_id
    INTO v_viaje_id
    FROM viaje
    WHERE cliente_id = 1;

    SELECT usuario_id
    INTO v_administrador_id
    FROM usuario
    WHERE username = 'admin1';

    INSERT INTO queja (titulo, fecha, descripcion, resultado, viaje_id, administrador_id)
    VALUES ('Conductor grosero', SYSDATE, 'El conductor fue grosero durante el viaje', 'Se sancionó al conductor', v_viaje_id, v_administrador_id);
END;
/

DECLARE
    v_viaje_id viaje.viaje_id%TYPE;
    v_administrador_id usuario.usuario_id%TYPE;
BEGIN
    SELECT viaje_id
    INTO v_viaje_id
    FROM viaje
    WHERE cliente_id = 2;

    SELECT usuario_id
    INTO v_administrador_id
    FROM usuario
    WHERE username = 'admin2';

    INSERT INTO queja (titulo, fecha, descripcion, resultado, viaje_id, administrador_id)
    VALUES ('Conductor tardado', SYSDATE, 'El conductor llegó tarde al punto de encuentro', 'Se sancionó al conductor', v_viaje_id, v_administrador_id);
END;
/
