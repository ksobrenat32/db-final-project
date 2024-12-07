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
