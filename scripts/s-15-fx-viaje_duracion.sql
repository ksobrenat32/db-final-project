 --@Autor(es): Enrique Job Calderón Olalde <@ksobrenat32>, Erick Nava Santiago
--@Fecha creación: 1 de diciembre de 2024
--@Descripción: esta funcion devolvera el tiempo transcurrido en un viaje


CREATE OR REPLACE FUNCTION viajeDuracion(v_viaje_id NUMBER) 
  RETURN VARCHAR2 IS v_duracion VARCHAR2;
  v_inicio DATE;
  v_fin DATE;


BEGIN 
  --DEFINIENDO LA HORA DE INICIO
  SELECT fecha_hora_inicio INTO v_inicio
  FROM viaje 
  WHERE viaje_id = v_viaje_id;

  --DEFINIENDO LA HORA DE FINALIZACION
  SELECT fecha_hora_fin INTO v_fin
  FROM viaje 
  WHERE viaje_id = v_viaje_id;
  
  IF v_fin IS NULL THEN 
    RAISE_APPLICATION_ERROR(-20420,'El viaje se encuantra en progreso');
  END IF;

  v_duracion := to_char((v_fin - v_inicio), 'DD 24HH:MI:SS');
  RETURN v_duracion;
END;
/
SHOW ERRORS

