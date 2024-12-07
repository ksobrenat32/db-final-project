#@Autor(es): Enrique Job Calderón Olalde <@ksobrenat32>, Erick Nava Santiago
#@Fecha creación: 4 de diciembre de 2024
#@Descripción: Archivo para registrar usuario

from database import *
import streamlit as st

# Variables
if 'usuario_id' not in st.session_state:
    st.session_state['usuario_id'] = ''
if 'es_cliente' not in st.session_state:
    st.session_state['es_cliente'] = False
if 'es_admin' not in st.session_state:
    st.session_state['es_admin'] = False
if 'es_conductor' not in st.session_state:
    st.session_state['es_conductor'] = False

if 'page' not in st.session_state:
    st.session_state['page'] = 'form_usuario'
if st.session_state['page'] not in ['form_usuario', 'form_usuario_cliente', 'form_usuario_conductor', 'form_usuario_admin']:
    st.session_state['page'] = 'form_usuario'

st.title("Registrar usuario")

def usuario_page():
    with st.form("form_usuario"):
        text_username = st.text_input("Nombre de usuario", max_chars=40)
        text_nombre = st.text_input("Nombre", max_chars=40)
        text_apellido_paterno = st.text_input("Apellido paterno", max_chars=40)
        text_apellido_materno = st.text_input("Apellido materno", max_chars=40)
        text_correo = st.text_input("Correo", max_chars=40)
        text_password = st.text_input("Contraseña", type="password", max_chars=40)

        select_cliente = st.checkbox("Cliente")
        select_admin = st.checkbox("Administrador")
        select_conductor = st.checkbox("Conductor")

        if select_cliente:
            select_cliente = '1'
            st.session_state['es_cliente'] = True
        else:
            select_cliente = '0'
            st.session_state['es_cliente'] = False

        if select_admin:
            select_admin = '1'
            st.session_state['es_admin'] = True
        else:
            select_admin = '0'
            st.session_state['es_admin'] = False

        if select_conductor:
            select_conductor = '1'
            st.session_state['es_conductor'] = True
        else:
            select_conductor = '0'
            st.session_state['es_conductor'] = False

        uc = get_all_usuario()
        uc.insert(0, '')
        select_usuario_recomendado = st.selectbox("Usuario recomendado", uc)

        s = st.form_submit_button(label="Enviar")
        if s:
            if select_conductor == '1' and select_admin == '1':
                st.error("Un usuario no puede ser conductor y administrador al mismo tiempo")
            elif select_admin == '1':
                st.session_state['usuario_id'] = add_usuario(text_username, text_nombre, text_apellido_paterno, text_apellido_materno, text_correo, text_password, select_cliente, select_admin, select_conductor, select_usuario_recomendado)
                st.success("Usuario registrado con id: " + str(st.session_state['usuario_id']))
                st.session_state['page'] = 'form_usuario_admin'
            elif select_conductor == '1':
                st.session_state['usuario_id'] = add_usuario(text_username, text_nombre, text_apellido_paterno, text_apellido_materno, text_correo, text_password, select_cliente, select_admin, select_conductor, select_usuario_recomendado)
                st.success("Usuario registrado con id: " + str(st.session_state['usuario_id']))
                st.session_state['page'] = 'form_usuario_conductor'
            elif select_cliente == '1':
                st.session_state['usuario_id'] = add_usuario(text_username, text_nombre, text_apellido_paterno, text_apellido_materno, text_correo, text_password, select_cliente, select_admin, select_conductor, select_usuario_recomendado)
                st.success("Usuario registrado con id: " + str(st.session_state['usuario_id']))
                st.session_state['page'] = 'form_usuario_cliente'

def usuario_conductor_page():
    with st.form("form_usuario_conductor"):
        text_num_licencia = st.text_input("Número de licencia", max_chars=18)
        text_num_cedula = st.text_input("Número de cédula", max_chars=18)
        file_foto = st.file_uploader("Foto de licencia", type=["jpg"])
        text_descripcion = st.text_area("Descripción", max_chars=3000)

        s = st.form_submit_button(label="Enviar")
        if s:
            add_conductor(st.session_state['usuario_id'], text_num_licencia, text_num_cedula, file_foto.getvalue(), text_descripcion)
            st.success("Conductor registrado")
            if st.session_state['es_cliente']:
                st.session_state['page'] = 'form_usuario_cliente'
            else:
                st.session_state['page'] = 'form_usuario'

def usuario_admin_page():
    with st.form("form_usuario_admin"):
        text_codigo = st.text_input("Código", max_chars=6)
        file_certificado = st.file_uploader("Certificado", type=["cer"])
        text_num_cedula = st.text_input("Número de cédula", max_chars=16)

        s = st.form_submit_button(label="Enviar")
        if s:
            add_administrador(st.session_state['usuario_id'], text_codigo, file_certificado.getvalue(), text_num_cedula)
            st.success("Administrador registrado")
            if st.session_state['es_cliente']:
                st.session_state['page'] = 'form_usuario_cliente'
            else:
                st.session_state['page'] = 'form_usuario'

def usuario_cliente_page():
    with st.form("form_usuario_cliente"):
        text_num_celular = st.text_input("Número de celular", max_chars=10)
        s = st.form_submit_button(label="Enviar")
        if s:
            add_cliente(st.session_state['usuario_id'], text_num_celular)
            st.success("Cliente registrado")
            st.session_state['page'] = 'form_usuario'

if st.session_state['page'] == 'form_usuario':
    usuario_page()
elif st.session_state['page'] == 'form_usuario_cliente':
    usuario_cliente_page()
elif st.session_state['page'] == 'form_usuario_conductor':
    usuario_conductor_page()
elif st.session_state['page'] == 'form_usuario_admin':
    usuario_admin_page()

