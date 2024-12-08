 --@Autor(es): Enrique Job Calderón Olalde <@ksobrenat32>, Erick Nava Santiago
--@Fecha creación: 1 de diciembre de 2024
--@Descripción: Procedimiento que dará obtener la asignacion de un automovil
 -- Aun lado a eso se utilzara un cursor, cumpliendo con el script s19


CREATE OR DELETE PROCEDURE sp_seleccion_auto(
  v_vehiculo_id OUT NUMBER,
  v_origen_longitud IN NUMBER,
  v_origen_latitud IN NUMBER,
  v_asientos IN NUMBER
) is 

v_distancia NUMBER;
v_distancia_candidato NUMBER;
--declaracion de un cursor para recorrer los vehiculos diponibles
CURSOR cur_vehiculo IS 
SELECT vehiculo_id, num_asientos, longitud, latitud 
FROM vehiculo_candidato
WHERE activo = 1
  AND num_asientos <= v_asientos;
for each row
BEGIN
  --asignando un numero muy grande a la diatancia
  v_distancia := 100000000000000000;
  --se recorren los candidatos y se hace el calculo de distancia
  FOR vehiculo_candidato in cur_vehiculo LOOP
    v_distancia_candidato := SQRT(
                   POWER(ABS(v_origen_longitud - vehiculo_candidato.longitud),2) 
                    + 
                   POWER(ABS(v_origen_latitud - vehiculo_candidato.latitud),2)
                   ,2);
    --seleccionando un candidato temporal
    IF v_distancia > v_distancia_candidato THEN 
       v_distancia := v_distancia_candidato;
       v_vehiculo_id := vehiculo_candidato.vehiculo_id;
    END IF;

  END LOOP;

END 
/
show errors
