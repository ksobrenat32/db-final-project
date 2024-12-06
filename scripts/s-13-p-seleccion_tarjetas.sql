 --@Autor(es): Enrique Job Calderón Olalde <@ksobrenat32>, Erick Nava Santiago
--@Fecha creación: 1 de diciembre de 2024
--@Descripción: Procedimiento que dará obtener la asignacion de un automovil

--suponiendo que el usuario escoge sus tarjetas y el porcentaje a pagar
CREATE OR DELETE PROCEDURE sp_seleccion_tarjetas(
  v_tarjeta_1 IN NUMBER,
  v_porcentaje_1 IN NUMBER DEFAULT NULL,
  v_tarjeta_2 IN NUMBER DEFAULT NULL,
  v_procentaje_2 IN NUMBER DEFAULT NULL,
  v_tarjeta_3 IN NUMBER DEFAULT NULL,
  v_porcentaje_3 IN NUMBER DEFAULT NULL
  v_valido OUT varchar2
) is 

v_porcentaje_total NUMBER;
v_count_tarjetas NUMBER;


--declaracion de un cursor para recorrer los vehiculos diponibles
BEGIN 
  --en caso de que se asigne un porcentaje pero no una tarjeta
  IF (v_tarjeta_2 IS NULL AND v_procentaje_2 IS NOT NULL) 
  OR (v_tarjeta_3 IS NULL AND v_procentaje_3 IS NOT NULL) THEN
    v_valido := 'No se ha seleccionado tarjeta para el porcentaje, favor de reintentar';
    RETURN;
  END IF;


  --
  -- Calcular el porcentaje total
  v_porcentaje_total := NVL(v_porcentaje_1, 0) + NVL(v_procentaje_2, 0) + NVL(v_porcentaje_3, 0);


  -- Validación: porcentaje total excede el 100%
  IF (v_porcentaje_total > 100) THEN
    v_valido := 'Error: El porcentaje total excede el 100%.';
    RETURN;
  END IF;
  


  -- Contar tarjetas sin porcentaje asignado
  IF v_tarjeta_1 IS NOT NULL AND v_porcentaje_1 IS NULL THEN 
    v_count_tarjetas := v_count_tarjetas + 1;
  END IF;

  IF v_tarjeta_2 IS NOT NULL AND v_procentaje_2 IS NULL THEN 
    v_count_tarjetas := v_count_tarjetas + 1;
  END IF;

  IF v_tarjeta_3 IS NOT NULL AND v_porcentaje_3 IS NULL THEN 
    v_count_tarjetas := v_count_tarjetas + 1;
  END IF;




  -- Calcular porcentaje faltante para asignarlo automáticamente
  IF v_count_tarjetas > 0 THEN
    v_porcentaje_faltante := (100 - v_porcentaje_total) / v_count_tarjetas;


    -- Asignar porcentajes automáticos
    IF v_tarjeta_1 IS NOT NULL AND v_porcentaje_1 IS NULL THEN 
      v_porcentaje_1 := v_porcentaje_faltante;
    END IF;

    IF v_tarjeta_2 IS NOT NULL AND v_procentaje_2 IS NULL THEN 
      v_procentaje_2 := v_porcentaje_faltante;
    END IF;

    IF v_tarjeta_3 IS NOT NULL AND v_porcentaje_3 IS NULL THEN 
      v_porcentaje_3 := v_porcentaje_faltante;
    END IF;


  END IF;

  -- Validación final: porcentaje total debe ser exactamente 100%
  v_porcentaje_total := NVL(v_porcentaje_1, 0) + NVL(v_procentaje_2, 0) + NVL(v_porcentaje_3, 0);
  IF v_porcentaje_total <> 100 THEN
    v_valido := 'Error: El porcentaje total no suma 100%.';
    RETURN;
  END IF;
  -- Éxito: Asignación correcta
  v_valido := 'Asignación válida: Porcentajes correctamente distribuidos.';
END
/
show errors