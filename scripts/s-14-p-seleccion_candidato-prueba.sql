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

  -- PRUEBA: USO CORRECTO DEL PROCEDIMIENTO
  BEGIN
    v_longitud := 777;
    v_latitud := 3231;
    v_asientos := 4;

    sp_seleccion_auto(v_vehiculo_id, v_longitud, v_latitud, v_asientos);
    DBMS_OUTPUT.PUT_LINE('Prueba correcta: Vehículo seleccionado con ID: ' || v_vehiculo_id);

  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Error en la prueba correcta del procedimiento: ' || SQLERRM);
  END;

  -- PRUEBA: USO INCORRECTO CON NÚMERO DE ASIENTOS MUY GRANDE
  BEGIN
    v_longitud := 777;
    v_latitud := 3231;
    v_asientos := 9;

    sp_seleccion_auto(v_vehiculo_id, v_longitud, v_latitud, v_asientos);
    DBMS_OUTPUT.PUT_LINE('Prueba con asientos grandes:' || v_vehiculo_id);

  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Error en la prueba con asientos grandes: ' || SQLERRM);
  END;

END;
/
SHOW ERRORS;
