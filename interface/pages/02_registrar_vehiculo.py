#@Autor(es): Enrique Job Calderón Olalde <@ksobrenat32>, Erick Nava Santiago
#@Fecha creación: 4 de diciembre de 2024
#@Descripción: Archivo para registrar vehículo

from database import *
import streamlit as st

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

# Variables

if 'categoria' not in st.session_state:
    st.session_state['categoria'] = ''
if 'marca_list' not in st.session_state:
    st.session_state['marca_list'] = []
if 'modelo_list' not in st.session_state:
    st.session_state['modelo_list'] = []

if 'page' not in st.session_state:
    st.session_state['page'] = 'form_categoria'


st.title("Registrar vehículo")

def categoria_page():
    with st.form("form_categoria"):
        select_categoria = st.selectbox("Selecciona la categoría del vehículo", ['Baja', 'Media', 'Alta'])
        s = st.form_submit_button(label="Enviar")
        if s:
            if select_categoria == 'Baja':
                select_categoria = '1'
            elif select_categoria == 'Media':
                select_categoria = '2'
            elif select_categoria == 'Alta':
                select_categoria = '3'
            st.session_state['marca_list'] = get_all_marca_from_categoria(select_categoria)
            print(st.session_state['marca_list'])
            st.session_state['page'] = 'form_marca'

def marca_page():
    with st.form("form_marca"):
        select_marca = st.selectbox("Selecciona la marca del vehículo", st.session_state['marca_list'])
        s = st.form_submit_button(label="Enviar")
        if s:
            st.session_state['modelo_list'] = get_all_modelo_from_marca(select_marca)
            st.session_state['page'] = 'form_vehiculo'

def vehiculo_page():
    with st.form("form_vehiculo"):
        select_usuario = st.selectbox("Usuario conductor", get_all_usuario_conductor())
        select_modelo = st.selectbox("Selecciona el modelo del vehículo", st.session_state['modelo_list'])
        text_placas = st.text_input("Placas", max_chars=7)
        text_anio = st.text_input("Año", max_chars=4)


        s = st.form_submit_button(label="Enviar")
        if s:
            add_vehiculo(select_usuario, select_modelo, text_placas, text_anio)
            st.success("Vehículo registrado con id: " + str(get_vehiculo_id(text_placas)))
            st.session_state['page'] = 'form_categoria'


if st.session_state['page'] == 'form_categoria':
    categoria_page()
elif st.session_state['page'] == 'form_marca':
    marca_page()
elif st.session_state['page'] == 'form_vehiculo':
    vehiculo_page()

