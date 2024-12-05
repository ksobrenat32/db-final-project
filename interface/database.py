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
        return connection.cursor()
    except oracledb.Error as e:
        print(f"Connection failed: {e}")
        return None

class Usuario:
    def __init__(self, usuario_id, username, nombre, apellido_paterno, apellido_materno, email, contrasenia, es_cliente, es_administrador, es_conductor, usuario_recomendado_id):
        self.usuario_id = usuario_id
        self.username = username
        self.nombre = nombre
        self.apellido_paterno = apellido_paterno
        self.apellido_materno = apellido_materno
        self.email = email
        self.contrasenia = contrasenia
        self.es_cliente = es_cliente
        self.es_administrador = es_administrador
        self.es_conductor = es_conductor
        self.usuario_recomendado_id = usuario_recomendado_id

    def save(self):
        cursor = connect()
        cursor.execute("INSERT INTO USUARIO VALUES (:1, :2, :3, :4, :5, :6, :7, :8, :9, :10)", (self.usuario_id, self.username, self.nombre, self.apellido_paterno, self.apellido_materno, self.email, self.contrasenia, self.es_cliente, self.es_administrador, self.es_conductor, self.usuario_recomendado_id))
        cursor.close()

class Descuento:
    def __init__(self, descuento_id, importe, vigencia, descripcion, usuario_id):
        self.descuento_id = descuento_id
        self.importe = importe
        self.vigencia = vigencia
        self.descripcion = descripcion
        self.usuario_id = usuario_id

class UsuarioConductor:
    def __init__(self, usuario_id, num_licencia, num_cedula, foto, descripcion):
        self.usuario_id = usuario_id
        self.num_licencia = num_licencia
        self.num_cedula = num_cedula
        self.foto = foto
        self.descripcion = descripcion

class UsuarioAdministrador:
    def __init__(self, usuario_id, codigo, certificado, num_cedula):
        self.usuario_id = usuario_id
        self.codigo = codigo
        self.certificado = certificado
        self.num_cedula = num_cedula

class UsuarioCliente:
    def __init__(self, usuario_id, fecha_registro, num_celular):
        self.usuario_id = usuario_id
        self.fecha_registro = fecha_registro
        self.num_celular = num_celular

class Pago:
    def __init__(self, usuario_id, folio, fecha, monto_total):
        self.usuario_id = usuario_id
        self.folio = folio
        self.fecha = fecha
        self.monto_total = monto_total

class Tags:
    def __init__(self, tag_id, clave, descripcion):
        self.tag_id = tag_id
        self.clave = clave
        self.descripcion = descripcion

class TagsConductor:
    def __init__(self, usuario_id, tag_id, contador):
        self.usuario_id = usuario_id
        self.tag_id = tag_id
        self.contador = contador

class Marca:
    def __init__(self, marca_id, descripcion, categoria):
        self.marca_id = marca_id
        self.descripcion = descripcion
        self.categoria = categoria

class Modelo:
    def __init__(self, modelo_id, nombre, descripcion, marca_id):
        self.modelo_id = modelo_id
        self.nombre = nombre
        self.descripcion = descripcion
        self.marca_id = marca_id

class Vehiculo:
    def __init__(self, vehiculo_id, placas, anio, modelo_id, usuario_id):
        self.vehiculo_id = vehiculo_id
        self.placas = placas
        self.anio = anio
        self.modelo_id = modelo_id
        self.usuario_id = usuario_id

class Tarjeta:
    def __init__(self, tarjeta_id, numero_tarjeta, mes, anio, usuario_id):
        self.tarjeta_id = tarjeta_id
        self.numero_tarjeta = numero_tarjeta
        self.mes = mes
        self.anio = anio
        self.usuario_id = usuario_id

class StatusViaje:
    def __init__(self, status_id, clave, descripcion):
        self.status_id = status_id
        self.clave = clave
        self.descripcion = descripcion

class Viaje:
    def __init__(self, viaje_id, fecha_hora_inicio, fecha_hora_fin, origen_longitud, origen_latitud, destino_longitud, destino_latitud, fecha_status, status_id, cliente_id, vehiculo_id):
        self.viaje_id = viaje_id
        self.fecha_hora_inicio = fecha_hora_inicio
        self.fecha_hora_fin = fecha_hora_fin
        self.origen_longitud = origen_longitud
        self.origen_latitud = origen_latitud
        self.destino_longitud = destino_longitud
        self.destino_latitud = destino_latitud
        self.fecha_status = fecha_status
        self.status_id = status_id
        self.cliente_id = cliente_id
        self.vehiculo_id = vehiculo_id

class ResumenViaje:
    def __init__(self, viaje_id, calificacion_estrellas, propina, comentarios, importe):
        self.viaje_id = viaje_id
        self.calificacion_estrellas = calificacion_estrellas
        self.propina = propina
        self.comentarios = comentarios
        self.importe = importe

class Factura:
    def __init__(self, factura_id, fecha, importe, archivo, rfc, direccion, viaje_id):
        self.factura_id = factura_id
        self.fecha = fecha
        self.importe = importe
        self.archivo = archivo
        self.rfc = rfc
        self.direccion = direccion
        self.viaje_id = viaje_id

class UbicacionHistorico:
    def __init__(self, ubicacion_historico_id, fecha_hora, longitud, latitud, viaje_id):
        self.ubicacion_historico_id = ubicacion_historico_id
        self.fecha_hora = fecha_hora
        self.longitud = longitud
        self.latitud = latitud
        self.viaje_id = viaje_id

class HistoricoStatusViaje:
    def __init__(self, historico_status_viaje_id, fecha_status, viaje_id, status_id):
        self.historico_status_viaje_id = historico_status_viaje_id
        self.fecha_status = fecha_status
        self.viaje_id = viaje_id
        self.status_id = status_id

class Cobro:
    def __init__(self, viaje_id, tarjeta_id, porcentaje, monto_total, monto_porcentaje):
        self.viaje_id = viaje_id
        self.tarjeta_id = tarjeta_id
        self.porcentaje = porcentaje
        self.monto_total = monto_total
        self.monto_porcentaje = monto_porcentaje

class Queja:
    def __init__(self, queja_id, titulo, fecha, descripcion, resultado, viaje_id, administrador_id):
        self.queja_id = queja_id
        self.titulo = titulo
        self.fecha = fecha
        self.descripcion = descripcion
        self.resultado = resultado
        self.viaje_id = viaje_id
        self.administrador_id = administrador_id
