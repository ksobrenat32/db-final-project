 --@Autor(es): Enrique Job Calderón Olalde <@ksobrenat32>, Erick Nava Santiago
--@Fecha creación: 1 de diciembre de 2024
--@Descripción: para verificar que la fecha de la tarjeta es valida


 --@Autor(es): Enrique Job Calderón Olalde <@ksobrenat32>, Erick Nava Santiago
--@Fecha creación: 1 de diciembre de 2024
--@Descripción: Trigger que se encargara de verificar que la tarjeta sea vigente
--se debe ingresar una nueva tarjeta vigente
--al actulizar, no se deben de cambiar los numeros de tarjeta ni el id, solo las fechas de vigencia,
--la cual, por supuesto, debe de estar actualmetne vigente

CREATE OR REPLACE TRIGGER tr_tarjeta_valida
  BEFORE INSERT OR 
  UPDATE
  ON tarjeta
FOR EACH ROW

DECLARE
--variables a utilizar

v_fecha_actual DATE;
v_fecha_tarjeta DATE;


BEGIN 
--ASIGNANDO LA FECHA ACTUAL 
v_fecha_actual := sysdate;
v_fecha_tarjeta := last_day(to_date(:new.mes||'/'||:new.anio, 'mm/yy'));
v_diferencia := v_fecha_actual - v_fecha_tarjeta;

  CASE
  --CUANDO SE INSERTA UN NUEVO REGISTRO
    WHEN INSERTING THEN 
      IF v_fecha_actual > v_fecha_tarjeta THEN 
      RAISE_APPLICATION_ERROR(-20020,'La tarjeta se encuentra actualmente vencida');
      END IF;
  --CUANDO SE ACTUALIZA UN REGISTRO YA EXISTENTE   
    WHEN UPDATING THEN 
      IF :old.tarjeta_id != :new-tarjeta_id or :old.numero_tarjeta != :new.numero_tarjeta THEN
            RAISE_APPLICATION_ERROR(-20021,'Los identificadores de la tarjeta no coinciden');
  --EN CASO DE NO SOLTAR ERROR, SE VERIFICARA QUE SE ACTUALIZE A UNA FECHA VIGENTE          
      ELSE:
        IF v_fecha_actual > v_fecha_tarjeta THEN 
           RAISE_APPLICATION_ERROR(-20020,'La tarjeta se encuentra actualmente vencida');
           ELSE:
           --PERMITIR LA ACTUALIZACION DE DATOS
           NULL;
        END IF;
      END IF;
    END CASE;


END;
/
show errors

/*
https://docs.oracle.com/en/database/oracle/oracle-database/21/sqlrf/LAST_DAY.html
*/
