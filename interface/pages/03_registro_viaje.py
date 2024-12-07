#@Autor(es): Enrique Job Calderón Olalde <@ksobrenat32>, Erick Nava Santiago
#@Fecha creación: 4 de diciembre de 2024
#@Descripción: Archivo para registrar usuario

from database import *
import streamlit as st

# Variables
if 'usuario_id' not in st.session_state:
    st.session_state['usuario_id'] = ''
if 'viaje_id' not in st.session_state:
    st.session_state['viaje_id'] = ''
if 'tarjeta_id' not in st.session_state:
    st.session_state['tarjeta_id'] = ''

if 'page' not in st.session_state:
    st.session_state['page'] = 'form_viaje'
if st.session_state['page'] not in ['form_viaje', 'form_resumen_viaje', 'form_tarjeta', 'form_nueva_tarjeta']:
    st.session_state['page'] = 'form_viaje'

st.title("Registro de viaje")

def viaje_page():
    with st.form("form_viaje"):
        select_usuario_cliente = st.selectbox("Usuario cliente", get_all_usuario_cliente())
        number_origen_latitud = st.number_input("Latitud de origen", min_value=-90.0, max_value=90.0, step=0.0001)
        number_origen_longitud = st.number_input("Longitud de origen", min_value=-180.0, max_value=180.0, step=0.0001)
        number_destino_latitud = st.number_input("Latitud de destino", min_value=-90.0, max_value=90.0, step=0.0001)
        number_destino_longitud = st.number_input("Longitud de destino", min_value=-180.0, max_value=180.0, step=0.0001)
        select_vehiculo = st.selectbox("Vehículo", get_all_vehiculo())

        s = st.form_submit_button(label="Enviar")
        if s:
            viaje_id = add_viaje(number_origen_longitud, number_origen_latitud, number_destino_longitud, number_destino_latitud, get_usuario_id(select_usuario_cliente), get_vehiculo_id(select_vehiculo))
            st.session_state['viaje_id'] = viaje_id
            st.session_state['usuario_id'] = get_usuario_id(select_usuario_cliente)

            st.success("Viaje registrado con id: " + str(viaje_id))
            st.session_state['page'] = 'form_resumen_viaje'

def resumen_viaje_page():
    with st.form("form_resumen_viaje"):
        number_calificacion_estrellas = st.number_input("Calificación en estrellas", min_value=1, max_value=5, step=1)
        propina = st.number_input("Propina", min_value=0.0, step=0.1)
        text_comentario = st.text_area("Comentario", max_chars=200)
        distancia = get_viaje_distancia(st.session_state['viaje_id'])
        st.write("Distancia: " + str(distancia) + " km")
        tarifa = distancia * 10
        st.write("Tarifa: $" + str(tarifa))

        s = st.form_submit_button(label="Enviar")
        if s:
            add_resumen_viaje(st.session_state['viaje_id'], number_calificacion_estrellas, propina, text_comentario, tarifa)
            st.success("Calificación registrada")
            st.session_state['page'] = 'form_tarjeta'

def nueva_tarjeta_page():
    with st.form("form_nueva_tarjeta"):
        text_numero = st.text_input("Número de tarjeta", max_chars=16)
        text_mes = st.text_input("Mes de vencimiento", max_chars=2)
        text_anio = st.text_input("Año de vencimiento", max_chars=2)

        s = st.form_submit_button(label="Enviar")
        if s:
            tarjeta_id = add_tarjeta(text_numero, text_mes, text_anio, st.session_state['usuario_id'])
            st.session_state['tarjeta_id'] = tarjeta_id
            st.success("Tarjeta registrada")
            st.session_state['page'] = 'form_tarjeta'

def tarjeta_page():
    # Button to create a new card
    if st.button("Nueva tarjeta"):
        st.session_state['page'] = 'form_nueva_tarjeta'

    with st.form("form_tarjeta"):
        select_tarjeta = st.selectbox("Tarjeta", get_all_tarjeta_usuario_id(st.session_state['usuario_id']))
        s = st.form_submit_button(label="Enviar")
        if s:
            st.session_state['tarjeta_id'] = get_tarjeta_id(select_tarjeta)
            add_cobro(st.session_state['viaje_id'], st.session_state['tarjeta_id'])
            st.success("Cobro realizado")
            st.session_state['page'] = 'form_viaje'

if st.session_state['page'] == 'form_viaje':
    viaje_page()
elif st.session_state['page'] == 'form_resumen_viaje':
    resumen_viaje_page()
elif st.session_state['page'] == 'form_nueva_tarjeta':
    nueva_tarjeta_page()
elif st.session_state['page'] == 'form_tarjeta':
    tarjeta_page()
