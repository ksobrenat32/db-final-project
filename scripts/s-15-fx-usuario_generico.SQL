 --@Autor(es): Enrique Job Calderón Olalde <@ksobrenat32>, Erick Nava Santiago
--@Fecha creación: 1 de diciembre de 2024
--@Descripción: esta funcion creara usernames de forma defaul. Basandose en los
-- datos del usuario

CREATE OR REPLACE FUNCTION totalGastos(
    v_nombre VARCHAR2,
    v_ap_pat VARCHAR2,
    v_ap_mat VARCHAR2 DEFAULT NULL
    ) 
  RETURN VARCHAR2 IS v_def_nombre NUMBER;
  v_fecha_numero VARCHAR2(10);

BEGIN 
  --2 letras del nombre
  v_def_nombre := SUBSTR(v_nombre, 1, 2);
  --2 letras del apellido paterno
  v_def_nombre := v_def_nombre || SUBSTR(v_ap_pat, 1, 2);

  --Si el usuario tiene apellido amterno se colocaran dos
   IF v_ap_mat IS NOT NULL THEN
    v_def_nombre := v_def_nombre || SUBSTR(v_ap_mat, 1, 2);
  ELSE
   --en caso de no tenerlo se colocaran dos 'x'
    v_def_nombre := v_def_nombre || 'XX'; 
  END IF;
  
  --SE GENERARA UN NUMERO CON LA FECHA ACTUAL 
  v_fecha_numero := TO_CHAR(SYSDATE, 'YYYYMMDDHH24MISSFF3');


  --SE TIENE EL NUMERO FINAL
   v_def_nombre := UPPER(v_def_nombre || v_fecha_numero);

   --RETORNO
   RETURN v_def_nombre;
END;
/
SHOW ERRORS
