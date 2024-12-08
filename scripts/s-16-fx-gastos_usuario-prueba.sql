--@Autor(es): Enrique Job Calderón Olalde <@ksobrenat32>, Erick Nava Santiago
--@Fecha creación: 1 de diciembre de 2024
--@Descripción: Prueba de la función que obtiene el total de gastos de un usuario

SET SERVEROUTPUT ON;

BEGIN
  -- Test case: Valid user with charges
  BEGIN
    DBMS_OUTPUT.PUT_LINE('Prueba correcta: Obteniendo el total de gastos de un usuario');
    IF totalGastos(1) = 1000 THEN
      DBMS_OUTPUT.PUT_LINE('Resultado correcto: El usuario ha gastado 1000');
    ELSE
      DBMS_OUTPUT.PUT_LINE('Resultado incorrecto: El usuario ha gastado ' || totalGastos(1));
    END IF;
  END;

  -- Test case: Non-existent user
  DECLARE
    v_total NUMBER;
  BEGIN
    DBMS_OUTPUT.PUT_LINE('Prueba incorrecta: Obteniendo el total de gastos de un usuario inexistente');
    v_total := totalGastos(10000);
    DBMS_OUTPUT.PUT_LINE('Se esperaba un error, resultado obtenido: ' || v_total);
  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Excepción esperada');
  END;
END;
/


