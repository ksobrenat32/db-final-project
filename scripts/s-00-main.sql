--@Autor(es): Enrique Job Calderón Olalde <@ksobrenat32>, Erick Nava Santiago
--@Fecha creación: 1 de diciembre de 2024
--@Descripción: Este llama a los scripts necesarios para crear todo.

spool s-00-main.log append

-- Crear usuarios
@s-01-usuarios.sql

-- Crear secuencias
@s-05-secuencias.sql

-- Crear entidades
@s-02-entidades.sql

-- Crear indices
@s-06-indices.sql

-- Crear sinónimos
@s-07-sinonimos.sql

-- Crear vistas
@s-08-vistas.sql

-- Crear tablas temporales
@s-03-tablas-temporales.sql

-- Crear tablas externas
@s-04-tablas-externas.sql

-- Carga inicial
@s-09-carga-inicial.sql

spool off
