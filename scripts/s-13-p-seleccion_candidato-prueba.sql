 --@Autor(es): Enrique Job Calderón Olalde <@ksobrenat32>, Erick Nava Santiago
--@Fecha creación: 1 de diciembre de 2024
--@Descripción: Scrip para verificar le funcionamietno del procedimiento 
--    de seleccion de empleado


DECLARE
  v_vehiculo_id NUMBER,
  v_origen_longitud NUMBER,
  v_origen_latitud NUMBER,
  v_asientos NUMBER

BEGIN
  --PARA ESTO SE TENDRAN LOS SIGUIENTES DATOS EN LA TABLA TEMPORAL QUE UTILIZA
  --ESTE PROCEDIMIENTO 


  --INSERCCION DE DATOS
  INSERT INTO vehiculo_candidato(vehiculo_id, longitud, latitud, activo)
  VALUES(1, 1234, 213, 1, 4);

  INSERT INTO vehiculo_candidato(vehiculo_id, longitud, latitud, activo)
  VALUES(2, 22, 332, 1, 6);

  INSERT INTO vehiculo_candidato(vehiculo_id, longitud, latitud, activo)
  VALUES(3, 210, 115, 1, 4);

  INSERT INTO vehiculo_candidato(vehiculo_id, longitud, latitud, activo)
  VALUES(4, 2222, 1111, 1, 5);

  INSERT INTO vehiculo_candidato(vehiculo_id, longitud, latitud, activo)
  VALUES(5, 2212, 23921, 1, 3);

  INSERT INTO vehiculo_candidato(vehiculo_id, longitud, latitud, activo)
  VALUES(6, -8721, 1232, 1, 6);

  --UNA VEZ CON LOS DATOS, SE PUEDE HACER LA USO DE LOS PROCEDIMIENTOS

  --PRUEBA USO CORRECTO DEL PROCEDIMIENTO
  BEGIN 
    v_longitud := 777;
    v_latitud := 3231;
    sp_seleccion_auto(v_vehiculo_id, v_longitud, v_latitud, v_asientos);
  END;

  --PRUEBA EN DONDE SE COLOCARA UN NUMERO DE ASIENTOS MUY GRANDE
  --PRUEBA USO CORRECTO DEL PROCEDIMIENTO
  BEGIN 
    v_longitud := 777;
    v_latitud := 3231;
    v_asientos := 25;
    sp_seleccion_auto(v_vehiculo_id, v_longitud, v_latitud, v_asientos);
  END;




END;
/
SHOW ERRORS
