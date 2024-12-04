 --@Autor(es): Enrique Job Calderón Olalde <@ksobrenat32>, Erick Nava Santiago
--@Fecha creación: 1 de diciembre de 2024
--@Descripción: Archivo con casos de consulta

/*
Este archivo contendrá 5 o más consultas. El criterio es libre. Se debe emplear el uso
de los siguientes elementos.
○ joins (inner join, natural join, outer join)
○ funciones de agregación (group by y having)
○ álgebra relacional (operadores set: union, intersect, minus).
○ Subconsultas
○ Consulta que involucre el uso de un sinónimo
○ Consulta que involucre el uso de una vista
○ Consulta que involucre una tabla temporal
○ Consulta que involucre a una tabla externa.
● No es necesario crear una consulta por cada elemento. En una misma consulta
pueden incluirse varios de los elementos anteriores.
*/


-- Se mostrara el nomber, usuario_id, numero de cedula y el numero de etiquetas que 
-- posee un conductor 

select usuario_id, nombre, apellido_paterno, apellido_materno, numero_cedula,
  sum(contador)
from usuario
natural join usuario_conductor
natural join tags_condutor
group by usuario_id, nombre, apellido_paterno, apellido_paterno, numero_cedula;
