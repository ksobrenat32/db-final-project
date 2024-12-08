--@Autor(es): Enrique Job Calderón Olalde <@ksobrenat32>, Erick Nava Santiago
--@Fecha creación: 1 de diciembre de 2024
--@Descripción: esta función devolverá el tiempo transcurrido en un viaje

CREATE OR REPLACE FUNCTION viaje_duracion(v_viaje_id NUMBER)
  RETURN VARCHAR2 IS
  v_duracion VARCHAR2(30);
  v_inicio DATE;
  v_fin DATE;
  v_diff_seconds NUMBER;
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

  -- Calculando la diferencia en segundos
  v_diff_seconds := (v_fin - v_inicio) * 24 * 60 * 60;

  -- Convertir la diferencia a formato 'HH24:MI:SS'
  v_duracion := LPAD(FLOOR(v_diff_seconds / 3600), 2, '0') || ':' ||
                LPAD(FLOOR(MOD(v_diff_seconds, 3600) / 60), 2, '0') || ':' ||
                LPAD(MOD(v_diff_seconds, 60), 2, '0');

  RETURN v_duracion;
END;
/
SHOW ERRORS;

