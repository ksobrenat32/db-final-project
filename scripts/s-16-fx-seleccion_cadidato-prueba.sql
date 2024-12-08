--@Autor(es): Enrique Job Calderón Olalde <@ksobrenat32>, Erick Nava Santiago
--@Fecha creación: 1 de diciembre de 2024
--@Descripción: Script para verificar el funcionamiento del procedimiento 
--    de selección de empleado
set serveroutput on
DECLARE
  v_vehiculo_id NUMBER;
  v_origen_longitud NUMBER;
  v_origen_latitud NUMBER;
  v_asientos NUMBER;
  v_longitud NUMBER;
  v_latitud NUMBER;

BEGIN
  -- INSERCIÓN DE DATOS EN LA TABLA TEMPORAL
  BEGIN
    INSERT INTO vehiculo_candidato(vehiculo_id, longitud, latitud, activo, num_asientos)
    VALUES(1, 134, 213, 1, 4);

    INSERT INTO vehiculo_candidato(vehiculo_id, longitud, latitud, activo, num_asientos)
    VALUES(2, 22, 332, 1, 6);

    INSERT INTO vehiculo_candidato(vehiculo_id, longitud, latitud, activo, num_asientos)
    VALUES(3, 210, 115, 1, 4);

    INSERT INTO vehiculo_candidato(vehiculo_id, longitud, latitud, activo, num_asientos)
    VALUES(4, 222, 111, 1, 5);

    INSERT INTO vehiculo_candidato(vehiculo_id, longitud, latitud, activo, num_asientos)
    VALUES(5, 212, 221, 1, 3);

    INSERT INTO vehiculo_candidato(vehiculo_id, longitud, latitud, activo, num_asientos)
    VALUES(6, -721, 122, 1, 6);

  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Error al insertar datos en la tabla temporal: ' || SQLERRM);
  END;

  -- PRUEBA: USO CORRECTO DE LA FUNCIÓN
  BEGIN
    v_longitud := 777;
    v_latitud := 3231;
    v_asientos := 4;

    DBMS_OUTPUT.PUT_LINE('Prueba correcta: Seleccionando vehículo con asientos: ' || v_asientos);

    v_vehiculo_id := fx_seleccion_auto(v_longitud, v_latitud, v_asientos);

    if v_vehiculo_id = 1 then
      DBMS_OUTPUT.PUT_LINE('Resultado correcto: Vehículo seleccionado con ID: ' || v_vehiculo_id);
    else
      DBMS_OUTPUT.PUT_LINE('Resultado incorrecto: Vehículo seleccionado con ID: ' || v_vehiculo_id);
    end if;
  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Error en la prueba correcta de la función: ' || SQLERRM);
  END;

  -- PRUEBA: USO INCORRECTO CON NÚMERO DE ASIENTOS MUY GRANDE
  BEGIN
    v_longitud := 777;
    v_latitud := 3231;
    v_asientos := 9;

    DBMS_OUTPUT.PUT_LINE('Prueba con asientos grandes: ' || v_asientos);

    v_vehiculo_id := fx_seleccion_auto(v_longitud, v_latitud, v_asientos);

    DBMS_OUTPUT.PUT_LINE('Prueba incorrecta: Vehículo seleccionado con ID: ' || v_vehiculo_id);
  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Excepción correcta');
  END;

  ROLLBACK;
END;
/
SHOW ERRORS;
