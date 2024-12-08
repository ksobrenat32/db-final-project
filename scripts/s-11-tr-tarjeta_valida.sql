--@Autor(es): Enrique Job Calderón Olalde <@ksobrenat32>, Erick Nava Santiago
--@Fecha creación: 1 de diciembre de 2024
--@Descripción: Trigger que se encargara de verificar que la tarjeta sea vigente. No es posible actualizar datos.

CREATE OR REPLACE TRIGGER tr_tarjeta_valida
  BEFORE INSERT OR
  UPDATE
  ON tarjeta
FOR EACH ROW
DECLARE
  v_fecha_actual DATE;
  v_fecha_tarjeta DATE;
BEGIN
  --ASIGNANDO LA FECHA ACTUAL
  v_fecha_actual := sysdate;
  v_fecha_tarjeta := last_day(to_date(:new.mes||'/'||:new.anio, 'mm/yy'));

  CASE
  --CUANDO SE INSERTA UN NUEVO REGISTRO
    WHEN INSERTING THEN
      IF v_fecha_actual > v_fecha_tarjeta THEN
        RAISE_APPLICATION_ERROR(-20020,'La tarjeta se encuentra actualmente vencida');
      END IF;
  --CUANDO SE ACTUALIZA UN REGISTRO YA EXISTENTE
    WHEN UPDATING THEN
      RAISE_APPLICATION_ERROR(-20020,'No es posible actualizar la tarjeta, crear una nueva');
    END CASE;
END;
/
show errors

/*
https://docs.oracle.com/en/database/oracle/oracle-database/21/sqlrf/LAST_DAY.html
*/
