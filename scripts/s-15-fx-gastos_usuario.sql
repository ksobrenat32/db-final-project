 --@Autor(es): Enrique Job Calderón Olalde <@ksobrenat32>, Erick Nava Santiago
--@Fecha creación: 1 de diciembre de 2024
--@Descripción: Función encargada de obtener el total de los gastos que ha tenido un usuario

CREATE OR REPLACE FUNCTION totalGastos(v_usuario_id NUMBER) 
  return NUMBER is v_total NUMBER;

BEGIN 


  SELECT sum(c.monto_total) into v_total
  FROM usuario_cliente us 
  JOIN viaje v 
  ON v.usuario_id = us.usuario_id
  JOIN cobro c 
  ON c.viaje_id = v.viaje_id
  where us.usuario_id = v_usuario_id;

  RETURN v_total;

  EXCEPTION

    WHEN NO_DATA_FOUND THEN 
      RETURN 0;
    WHEN OTHERS THEN 
      RAISE_APPLICATION_ERROR(-20043, 'ERROR DESCONOCIDO');
      


END;
/
SHOW ERRORS
