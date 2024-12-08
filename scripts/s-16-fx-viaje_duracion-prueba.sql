--@Autor(es): Enrique Job Calderón Olalde <@ksobrenat32>, Erick Nava Santiago
--@Fecha creación: 1 de diciembre de 2024
--@Descripción: Funcionamiento de las funciones declaradas


SET SERVEROUTPUT ON;

BEGIN
  -- Para la primera función
  BEGIN
    DBMS_OUTPUT.PUT_LINE('Nombres generados:');

    DBMS_OUTPUT.PUT_LINE(nombre_generico('Juan', 'Perez', 'Perez'));
    DBMS_OUTPUT.PUT_LINE(nombre_generico('Job', 'Calderon', NULL));
  END;

  -- Para la segunda función
  DECLARE
    v_viaje_id NUMBER;
    duracion VARCHAR2(30);
    v_fecha_hora_inicio DATE;
    v_fecha_hora_fin DATE;
  BEGIN
    DBMS_OUTPUT.PUT_LINE('Prueba de la función viaje_duracion:');

    INSERT INTO viaje (fecha_hora_inicio, fecha_hora_fin, origen_longitud, origen_latitud, destino_longitud, destino_latitud, fecha_status, status_id, cliente_id, vehiculo_id)
    VALUES (TO_DATE('2024-12-01 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2024-12-01 10:25:00', 'YYYY-MM-DD HH24:MI:SS'), 19.4326, -99.1332, 19.4326, -99.1332, TO_DATE('2024-12-01 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 1, 1, 1);
    SELECT viaje_id INTO v_viaje_id
    FROM viaje
    WHERE fecha_hora_inicio = TO_DATE('2024-12-01 10:00:00', 'YYYY-MM-DD HH24:MI:SS') AND fecha_hora_fin = TO_DATE('2024-12-01 10:25:00', 'YYYY-MM-DD HH24:MI:SS') AND cliente_id = 1 AND vehiculo_id = 1 AND status_id = 1 AND origen_longitud = 19.4326 AND origen_latitud = -99.1332 AND destino_longitud = 19.4326 AND destino_latitud = -99.1332;

    duracion := viaje_duracion(v_viaje_id);
    SELECT fecha_hora_inicio, fecha_hora_fin INTO v_fecha_hora_inicio, v_fecha_hora_fin
    FROM viaje
    WHERE viaje_id = v_viaje_id;
    DBMS_OUTPUT.PUT_LINE('El viaje ' || v_viaje_id || ' inicio el ' || TO_CHAR(v_fecha_hora_inicio, 'DD/MM/YYYY HH24:MI:SS') || ' y termino el ' || TO_CHAR(v_fecha_hora_fin, 'DD/MM/YYYY HH24:MI:SS'));
    DBMS_OUTPUT.PUT_LINE('Duración: ' || duracion);
  END;

  ROLLBACK;
END;
/
SHOW ERRORS;
