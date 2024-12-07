#@Autor(es): Enrique Job Calderón Olalde <@ksobrenat32>, Erick Nava Santiago
#@Fecha creación: 4 de diciembre de 2024
#@Descripción: Archivo para acceder a la base de datos y realizar operaciones CRUD.

import oracledb

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

def get_modelo_id(modelo):
    conn = connect()
    cursor = conn.cursor()
    cursor.execute(f"SELECT modelo_id FROM modelo WHERE nombre = '{modelo}'")
    return cursor.fetchone()[0]

def add_vehiculo(username, modelo, placas, anio):
    conn = connect()
    cursor = conn.cursor()
    cursor.execute(f"INSERT INTO vehiculo (usuario_id, modelo_id, placas, anio) VALUES ((SELECT usuario_id FROM usuario WHERE username = '{username}'), (SELECT modelo_id FROM modelo WHERE nombre = '{modelo}'), '{placas}', '{anio}')")
    conn.commit()

def get_vehiculo_id(placas):
    conn = connect()
    cursor = conn.cursor()
    cursor.execute(f"SELECT vehiculo_id FROM vehiculo WHERE placas = '{placas}'")
    return cursor.fetchone()[0]
