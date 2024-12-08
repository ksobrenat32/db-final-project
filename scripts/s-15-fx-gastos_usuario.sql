--@Autor(es): Enrique Job Calderón Olalde <@ksobrenat32>, Erick Nava Santiago
--@Fecha creación: 1 de diciembre de 2024
--@Descripción: Función encargada de obtener el total de los gastos que ha tenido un usuario

CREATE OR REPLACE FUNCTION totalGastos(v_usuario_id NUMBER) return NUMBER
IS
  v_total NUMBER;
  username usuario_cliente.usuario_id%TYPE;
BEGIN
  -- Si el usuario no existe, se manda excepción
  SELECT usuario.usuario_id INTO username
  FROM usuario_cliente
  JOIN usuario ON usuario.usuario_id = usuario_cliente.usuario_id
  WHERE usuario.usuario_id = v_usuario_id;

  DBMS_OUTPUT.PUT_LINE('Usuario encontrado: ' || username);

  IF username IS NULL THEN
    RAISE_APPLICATION_ERROR(-20042, 'El usuario no existe');
  END IF;

  SELECT sum(c.monto_total) into v_total
  FROM usuario_cliente uc
  JOIN viaje v
  ON v.cliente_id = uc.usuario_id
  JOIN cobro c
  ON c.viaje_id = v.viaje_id
  where uc.usuario_id = v_usuario_id;

  RETURN v_total;
EXCEPTION
  WHEN OTHERS THEN
    RAISE_APPLICATION_ERROR(-20043, 'Error al obtener el total de gastos del usuario: ' || SQLERRM);
END;
/
SHOW ERRORS
