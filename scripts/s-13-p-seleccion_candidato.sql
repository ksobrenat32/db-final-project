--@Autor(es): Enrique Job Calderón Olalde <@ksobrenat32>, Erick Nava Santiago
--@Fecha creación: 1 de diciembre de 2024
--@Descripción: Procedimiento que selecciona un automóvil basado en ubicación y asientos requeridos.
--               Maneja casos donde no hay vehículos disponibles con asientos suficientes.

CREATE OR REPLACE PROCEDURE sp_seleccion_auto(
  v_vehiculo_id OUT NUMBER,
  v_origen_longitud IN NUMBER,
  v_origen_latitud IN NUMBER,
  v_asientos IN NUMBER
) IS 

  v_distancia NUMBER;
  v_distancia_candidato NUMBER;
  v_vehiculo_encontrado BOOLEAN := FALSE;

  -- Declaración de un cursor para recorrer los vehículos disponibles
  CURSOR cur_vehiculo IS 
    SELECT vehiculo_id, num_asientos, longitud, latitud 
    FROM vehiculo_candidato
    WHERE activo = 1
      AND num_asientos <= v_asientos; -- Vehículos con igual o mayor número de asientos

BEGIN
  -- Inicializando la distancia con un valor muy grande
  v_distancia := 100000000000000000;

  -- Recorrer los candidatos y calcular la distancia
  FOR vehiculo_candidato IN cur_vehiculo LOOP
    -- Cálculo de la distancia
    v_distancia_candidato := SQRT(
                  POWER(v_origen_longitud - vehiculo_candidato.longitud, 2) + 
                  POWER(v_origen_latitud - vehiculo_candidato.latitud, 2)
                );

    -- Seleccionando un candidato temporal
    IF v_distancia > v_distancia_candidato AND   v_asientos <= vehiculo_candidato.num_asientos  THEN 
      v_distancia := v_distancia_candidato;
      v_vehiculo_id := vehiculo_candidato.vehiculo_id;
      v_vehiculo_encontrado := TRUE;
    END IF;

  END LOOP;

  -- Sin asientos suficientes 
IF NOT v_vehiculo_encontrado THEN
    RAISE_APPLICATION_ERROR(-23331, 'No se encontraron vehículos con suficientes asientos.');
  END IF;

EXCEPTION
  WHEN OTHERS THEN
    -- Errores
    RAISE_APPLICATION_ERROR(-20612, 'Ocurrió un error inesperado: ' || SQLERRM);
END;
/
SHOW ERRORS;
