--@Autor(es): Enrique Job Calderón Olalde <@ksobrenat32>, Erick Nava Santiago
--@Fecha creación: 1 de diciembre de 2024
--@Descripción: Este procedimiento divide un pago total en múltiples pagos distribuidos en partes, según el número de pagos y días de diferencia.

CONNECT cn_proy_admin/cn_proy_admin@//localhost:1521/FREEPDB1

CREATE OR REPLACE PROCEDURE sp_creacion_pagos(
  v_num_licencia IN NUMBER,
  v_num_pagos IN NUMBER,
  v_monto_total IN NUMBER,
  v_dif_dias IN NUMBER
) IS 

  v_conductor_id NUMBER;
  v_monto_pago NUMBER;
  v_ultimo_pag NUMBER;
BEGIN
  -- OBTENCIÓN DEL ID DEL EMPLEADO 
  SELECT usuario_id INTO v_conductor_id
  FROM usuario_conductor
  WHERE num_licencia = v_num_licencia;

  --ENCASO DE QUE NO SE ENCUENTRE EN LA BASE DE DATOS 
  IF v_conductor_id IS NULL THEN 
    RAISE_APPLICATION_ERROR(-20870,'NO SE ENCONTRÓ EL REGISTRO');
  END IF;
  -- OBTENCIÓN DEL ULTIMO PAGO. EN CASO DE QUE NO EXISTA, SE COLOCARÁ COMO PRIMERO
  SELECT MAX(folio) INTO v_ultimo_pag
  FROM pago
  WHERE usuario_id = v_conductor_id;

  -- SI NO HAY PAGOS ANTERIORES SE INICIA CON 1
  IF v_ultimo_pag IS NULL THEN
    v_ultimo_pag := 0; 
  END IF;

  -- CÁLCULO DEL MONTO POR PAGO
  v_monto_pago := v_monto_total / v_num_pagos;

  -- PARA INSERTAR LOS DATOS SE USA UN LOOP
  FOR i IN 1..v_num_pagos LOOP 
    -- INSERTANDO EL PAGO
    v_ultimo_pag := v_ultimo_pag + 1; 
    INSERT INTO pago(usuario_id, folio, fecha, monto_total)
    VALUES(v_conductor_id, v_ultimo_pag, SYSDATE + (v_dif_dias * i), v_monto_pago);
  END LOOP;

END;
/
SHOW ERRORS;
