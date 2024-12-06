 --@Autor(es): Enrique Job Calderón Olalde <@ksobrenat32>, Erick Nava Santiago
--@Fecha creación: 1 de diciembre de 2024
--@Descripción: Trigger que se encargara de verificar que el automovil ingresado
--              no tenga más de 5 años. 


CREATE OR REPLACE TRIGGER tr_vehiculo_reciente
  BEFORE INSERT OR 
  UPDATE
  ON vehiculo
FOR EACH ROW

DECLARE
--variables a utilizar

v_fecha_actual DATE;
v_fecha_auto DATE;
v_diferencia NUMBER;


BEGIN 
--ASIGNANDO LA FECHA ACTUAL 
v_fecha_actual := sysdate;
v_fecha_auto := to_date('01/01/' ||:new.anio, 'dd/mm/yyyy');
v_diferencia := MONTHS_BETWEEN (v_fecha_actual , v_fecha_auto);

--PARA CUANDO SE INSERTA EL DATO 

  CASE
    WHEN INSERTING THEN 
      IF v_diferencia/12 > 5 THEN 
        RAISE_APPLICATION_ERROR(-20009, 'El auto excede los 5 años de uso');
      ELSE 
        --PERMITIR INSERCCION DE DATOS
        NULL;
      END IF;

--PARA CUANDO SE DESEA ACTULIZAR LOS DATOS
    WHEN UPDATING THEN 
      IF v_diferencia/12 > 5 THEN 
        RAISE_APPLICATION_ERROR(-20010, 'Se esta intentando ingresar un vehiculo que excede los 5 años de uso');
      ELSE 
        --PERMITIR ACTUALIZACIONES
        NULL;
      END IF;
  END CASE;
END;
/
show errors

/*
MONTHS BETWEEN
https://docs.oracle.com/en/database/oracle/oracle-database/21/sqlrf/MONTHS_BETWEEN.html

*/