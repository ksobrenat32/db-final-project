#@Autor(es): Enrique Job Calderón Olalde <@ksobrenat32>, Erick Nava Santiago
#@Fecha creación: 4 de diciembre de 2024
#@Descripción: Archivo para acceder a la base de datos y realizar operaciones CRUD.

import oracledb
import math
import datetime
import pytz

def connect() -> oracledb.Cursor:
    dsn = "127.0.0.1:1521/FREEPDB1"
    username = "cn_proy_admin"
    password = "cn_proy_admin"

    try:
        connection = oracledb.connect(user=username, password=password, dsn=dsn)
        print("Connected to Oracle Database")
        return connection
    except oracledb.Error as e:
        print(f"Connection failed: {e}")
        return None

def get_all_vehiculo():
    conn = connect()
    cursor = conn.cursor()
    cursor.execute("SELECT placas FROM vehiculo")
    r = []
    for i in cursor.fetchall():
        r.append(i[0])
    return r

def get_all_usuario():
    conn = connect()
    cursor = conn.cursor()
    cursor.execute("SELECT username FROM usuario")
    r = []
    for i in cursor.fetchall():
        r.append(i[0])
    return r

def get_all_usuario_cliente():
    conn = connect()
    cursor = conn.cursor()
    cursor.execute("SELECT username FROM usuario WHERE ES_CLIENTE = 1")
    r = []
    for i in cursor.fetchall():
        r.append(i[0])
    return r

def get_all_usuario_conductor():
    conn = connect()
    cursor = conn.cursor()
    cursor.execute("SELECT username FROM usuario WHERE ES_CONDUCTOR = 1")
    r = []
    for i in cursor.fetchall():
        r.append(i[0])
    return r

def get_all_marca_from_categoria(categoria):
    conn = connect()
    cursor = conn.cursor()
    cursor.execute(f"SELECT descripcion FROM marca WHERE categoria = '{categoria}'")
    r = []
    for i in cursor.fetchall():
        r.append(i[0])
    return r

def get_all_modelo_from_marca(marca):
    conn = connect()
    cursor = conn.cursor()
    cursor.execute(f"SELECT nombre FROM modelo WHERE marca_id = (SELECT marca_id FROM marca WHERE descripcion = '{marca}')")
    r = []
    for i in cursor.fetchall():
        r.append(i[0])
    return r

def get_all_tarjeta_usuario_id(usuario_id):
    conn = connect()
    cursor = conn.cursor()
    cursor.execute(f"SELECT numero_tarjeta FROM tarjeta WHERE usuario_id = {usuario_id}")
    r = []
    for i in cursor.fetchall():
        r.append(i[0])
    return r

def get_usuario_id(username):
    conn = connect()
    cursor = conn.cursor()
    cursor.execute(f"SELECT usuario_id FROM usuario WHERE username = '{username}'")
    return cursor.fetchone()[0]

def get_modelo_id(modelo):
    conn = connect()
    cursor = conn.cursor()
    cursor.execute(f"SELECT modelo_id FROM modelo WHERE nombre = '{modelo}'")
    return cursor.fetchone()[0]

def get_vehiculo_id(placas):
    conn = connect()
    cursor = conn.cursor()
    cursor.execute(f"SELECT vehiculo_id FROM vehiculo WHERE placas = '{placas}'")
    return cursor.fetchone()[0]

def get_tarjeta_id(numero_tarjeta):
    conn = connect()
    cursor = conn.cursor()
    cursor.execute(f"SELECT tarjeta_id FROM tarjeta WHERE numero_tarjeta = '{numero_tarjeta}'")
    return cursor.fetchone()[0]

def get_viaje_distancia(viaje_id):
    conn = connect()
    cursor = conn.cursor()
    cursor.execute(f"SELECT origen_longitud, origen_latitud, destino_longitud, destino_latitud FROM viaje WHERE viaje_id = {viaje_id}")
    origen_longitud, origen_latitud, destino_longitud, destino_latitud = cursor.fetchone()
    # Get distance between two points in km
    R = 6371.0
    lat1_rad = math.radians(origen_latitud)
    lon1_rad = math.radians(origen_longitud)
    lat2_rad = math.radians(destino_latitud)
    lon2_rad = math.radians(destino_longitud)

    delta_lat = lat2_rad - lat1_rad
    delta_lon = lon2_rad - lon1_rad
    # Haversine formula
    a = math.sin(delta_lat / 2)**2 + math.cos(lat1_rad) * math.cos(lat2_rad) * math.sin(delta_lon / 2)**2
    c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a))
    distance = R * c
    return distance

def get_viaje_cliente_id(viaje_id):
    conn = connect()
    cursor = conn.cursor()
    cursor.execute(f"SELECT cliente_id FROM viaje WHERE viaje_id = {viaje_id}")
    return cursor.fetchone()[0]

def add_vehiculo(username, modelo, placas, anio):
    conn = connect()
    cursor = conn.cursor()
    cursor.execute(f"INSERT INTO vehiculo (usuario_id, modelo_id, placas, anio) VALUES ((SELECT usuario_id FROM usuario WHERE username = '{username}'), (SELECT modelo_id FROM modelo WHERE nombre = '{modelo}'), '{placas}', '{anio}')")
    conn.commit()

    cursor.execute(f"SELECT vehiculo_id FROM vehiculo WHERE placas = '{placas}'")
    return cursor.fetchone()[0]

def add_usuario(username, nombre, apellido_paterno, apellido_materno, correo, password, es_cliente, es_administrador, es_conductor, usuario_recomendado):
    conn = connect()
    cursor = conn.cursor()
    if usuario_recomendado == '':
        cursor.execute(f"INSERT INTO usuario (username, nombre, apellido_paterno, apellido_materno, email, contrasenia, es_cliente, es_administrador, es_conductor, usuario_recomendado_id) VALUES ('{username}', '{nombre}', '{apellido_paterno}', '{apellido_materno}', '{correo}', '{password}', {es_cliente}, {es_administrador}, {es_conductor}, NULL)")
    else:
        cursor.execute(f"INSERT INTO usuario (username, nombre, apellido_paterno, apellido_materno, email, contrasenia, es_cliente, es_administrador, es_conductor, usuario_recomendado_id) VALUES ('{username}', '{nombre}', '{apellido_paterno}', '{apellido_materno}', '{correo}', '{password}', {es_cliente}, {es_administrador}, {es_conductor}, (SELECT usuario_id FROM usuario WHERE username = '{usuario_recomendado}'))")
    conn.commit()

    cursor.execute(f"SELECT usuario_id FROM usuario WHERE username = '{username}'")
    return cursor.fetchone()[0]

def add_conductor(usuario_id, num_licencia, num_cedula, foto, descripcion):
    conn = connect()
    cursor = conn.cursor()
    cursor.execute(f"INSERT INTO usuario_conductor (usuario_id, num_licencia, num_cedula, foto, descripcion) VALUES ({usuario_id}, '{num_licencia}', '{num_cedula}', :blobdata, '{descripcion}')", blobdata=foto)
    conn.commit()

def add_administrador(usuario_id, codigo, certificado, num_cedula):
    conn = connect()
    cursor = conn.cursor()
    cursor.execute(f"INSERT INTO usuario_administrador (usuario_id, codigo, certificado, num_cedula) VALUES ({usuario_id}, '{codigo}', :blobdata, '{num_cedula}')", blobdata=certificado)
    conn.commit()

def add_cliente(usuario_id, num_celular):
    conn = connect()
    cursor = conn.cursor()
    cursor.execute(f"INSERT INTO usuario_cliente (usuario_id, num_celular) VALUES ({usuario_id}, '{num_celular}')")
    conn.commit()

def add_viaje(origen_longitud, origen_latitud, destino_longitud, destino_latitud, cliente_id, vehiculo_id):
    # Calculate time, this is calculated from the distance between the origin and the destination
    R = 6371.0
    lat1_rad = math.radians(origen_latitud)
    lon1_rad = math.radians(origen_longitud)
    lat2_rad = math.radians(destino_latitud)
    lon2_rad = math.radians(destino_longitud)

    delta_lat = lat2_rad - lat1_rad
    delta_lon = lon2_rad - lon1_rad
    # Haversine formula
    a = math.sin(delta_lat / 2)**2 + math.cos(lat1_rad) * math.cos(lat2_rad) * math.sin(delta_lon / 2)**2
    c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a))
    distance = R * c
    # Supposes a speed of 40 km/h and give time in minutes
    travel_time = round(distance / 40 * 60)

    fecha_hora_inicio = datetime.datetime.now(pytz.timezone('America/Mexico_City'))
    fecha_hora_fin = fecha_hora_inicio + datetime.timedelta(minutes=travel_time)

    conn = connect()
    cursor = conn.cursor()

    try:
        # Add main viaje
        cursor.execute(f"INSERT INTO viaje (fecha_hora_inicio, fecha_hora_fin, origen_longitud, origen_latitud, destino_longitud, destino_latitud, fecha_status, status_id, cliente_id, vehiculo_id) VALUES (TO_DATE('{fecha_hora_inicio.strftime('%Y-%m-%d %H:%M:%S')}', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('{fecha_hora_fin.strftime('%Y-%m-%d %H:%M:%S')}', 'YYYY-MM-DD HH24:MI:SS'), {origen_longitud}, {origen_latitud}, {destino_longitud}, {destino_latitud}, TO_DATE('{fecha_hora_fin.strftime('%Y-%m-%d %H:%M:%S')}', 'YYYY-MM-DD HH24:MI:SS'), (SELECT status_id FROM status_viaje WHERE clave = 'TERMINADO'), {cliente_id}, {vehiculo_id})")

        # Get viaje_id
        cursor.execute("SELECT MAX(viaje_id) FROM viaje")
        viaje_id = cursor.fetchone()[0]

        # Add to historico_status_viaje PROGRAMADO
        cursor.execute(f"INSERT INTO historico_status_viaje (fecha_status, viaje_id, status_id) VALUES (TO_DATE('{fecha_hora_inicio.strftime('%Y-%m-%d %H:%M:%S')}', 'YYYY-MM-DD HH24:MI:SS'), {viaje_id}, 1)")
        # Add to historico_status_viaje CONFIRMADO
        cursor.execute(f"INSERT INTO historico_status_viaje (fecha_status, viaje_id, status_id) VALUES (TO_DATE('{(fecha_hora_inicio + datetime.timedelta(minutes=1)).strftime('%Y-%m-%d %H:%M:%S')}', 'YYYY-MM-DD HH24:MI:SS'), {viaje_id}, 2)")
        # Add to historico_status_viaje EN CURSO
        cursor.execute(f"INSERT INTO historico_status_viaje (fecha_status, viaje_id, status_id) VALUES (TO_DATE('{(fecha_hora_inicio + datetime.timedelta(minutes=2)).strftime('%Y-%m-%d %H:%M:%S')}', 'YYYY-MM-DD HH24:MI:SS'), {viaje_id}, 3)")
        # Add to historico_status_viaje TERMINADO
        cursor.execute(f"INSERT INTO historico_status_viaje (fecha_status, viaje_id, status_id) VALUES (TO_DATE('{fecha_hora_fin.strftime('%Y-%m-%d %H:%M:%S')}', 'YYYY-MM-DD HH24:MI:SS'), {viaje_id}, 4)")

        # Add ubicacion_historico for each minute until the end of the trip
        for i in range(1, travel_time + 1):
            cursor.execute(f"INSERT INTO ubicacion_historico (fecha_hora, longitud, latitud, viaje_id) VALUES (TO_DATE('{(fecha_hora_inicio + datetime.timedelta(minutes=i)).strftime('%Y-%m-%d %H:%M:%S')}', 'YYYY-MM-DD HH24:MI:SS'), {origen_longitud + (destino_longitud - origen_longitud) * i / travel_time}, {origen_latitud + (destino_latitud - origen_latitud) * i / travel_time}, {viaje_id})")
        conn.commit()
    except oracledb.Error as e:
        conn.rollback()
        print(f"Error adding viaje: {e}")

    return viaje_id

def add_resumen_viaje(viaje_id, calificacion_estrellas, propina, comentarios, importe):
    conn = connect()
    cursor = conn.cursor()
    cursor.execute(f"INSERT INTO resumen_viaje (viaje_id, calificacion_estrellas, propina, comentarios, importe) VALUES ({viaje_id}, {calificacion_estrellas}, {propina}, '{comentarios}', {importe})")
    conn.commit()

def add_tarjeta(numero, mes, anio, usuario_id):
    conn = connect()
    cursor = conn.cursor()
    cursor.execute(f"INSERT INTO tarjeta (numero_tarjeta, mes, anio, usuario_id) VALUES ('{numero}', '{mes}', '{anio}', {usuario_id})")
    conn.commit()
    cursor.execute("SELECT MAX(tarjeta_id) FROM tarjeta")
    tarjeta_id = cursor.fetchone()[0]
    return tarjeta_id

def add_cobro(viaje_id, tarjeta_id):
    conn = connect()
    cursor = conn.cursor()
    cursor.execute(f"SELECT importe FROM resumen_viaje WHERE viaje_id = {viaje_id}")
    monto_total = cursor.fetchone()[0]
    porcentaje = 1
    cursor.execute(f"INSERT INTO cobro (viaje_id, tarjeta_id, porcentaje, monto_total) VALUES ({viaje_id}, {tarjeta_id}, {porcentaje}, {monto_total})")
    conn.commit()
