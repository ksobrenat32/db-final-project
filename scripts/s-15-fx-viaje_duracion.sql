--@Autor(es): Enrique Job Calderón Olalde <@ksobrenat32>, Erick Nava Santiago
--@Fecha creación: 1 de diciembre de 2024
--@Descripción: esta función devolverá el tiempo transcurrido en un viaje

CREATE OR REPLACE FUNCTION viajeDuracion(v_viaje_id NUMBER) 
  RETURN VARCHAR2 IS 
  v_duracion VARCHAR2(30); 
  v_inicio DATE;
  v_fin DATE;

BEGIN 
  -- Definiendo la hora de inicio
  SELECT fecha_hora_inicio INTO v_inicio
  FROM viaje 
  WHERE viaje_id = v_viaje_id;

  -- Definiendo la hora de finalización
  SELECT fecha_hora_fin INTO v_fin
  FROM viaje 
  WHERE viaje_id = v_viaje_id;

  IF v_fin IS NULL THEN 
    RAISE_APPLICATION_ERROR(-20420, 'El viaje se encuentra en progreso');
  END IF;

  -- Calculando la duración
  v_duracion := TO_CHAR((v_fin - v_inicio), 'DD24HH:MI:SS');
  
  RETURN v_duracion;
END;
/
SHOW ERRORS;
