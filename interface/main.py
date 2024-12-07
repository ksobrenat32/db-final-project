#@Autor(es): Enrique Job Calderón Olalde <@ksobrenat32>, Erick Nava Santiago
#@Fecha creación: 4 de diciembre de 2024
#@Descripción: Archivo principal de la interfaz gráfica

import streamlit as st

st.set_page_config(
    page_title="Virtual Traveler",
    page_icon="🌍",
    layout="centered",
    initial_sidebar_state="expanded",
    menu_items={
        'Report a bug': 'https://github.com/ksobrenat32/db-final-project/issues',
        'About': 'This is a web application for the final project of the Databases course.'
    }
)


st.markdown("# Virtual Traveler")
st.markdown("Welcome to Virtual Traveler! This is a web application that moves you to the place you want to visit.")
