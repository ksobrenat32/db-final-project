 --@Autor(es): Enrique Job Calderón Olalde <@ksobrenat32>, Erick Nava Santiago
--@Fecha creación: 1 de diciembre de 2024
--@Descripción: PRUEBAS DEL TRIGGER DE TARJETA VALIDA



DECLARE
  v_tarjeta_id NUMBER;

BEGIN 

  
  --ingreso correcto de una tarjeta
  BEGIN 
    BDMS_OUTPUT.PUT_LINE('CASO INSERCCION CORRECTA');
    INSERT INTO tarjeta(tarjeta_id,numero_tarjeta, mes, anio, usuario_id)
      VALUES(tarjeta_seq.nextval,1122334455667788, 12, 24, 1);
  END;


  --actulización correcta de una tarjeta 
  BEGIN 
    BDMS_OUTPUT.PUT_LINE('CASO SE UNA ACTUALIZACION CORRECTA, SE UTILIZARA EL REGISTRO ANTERIOR');
    --OBTENCION DEL ID
    SELECT tarjeta_id INTO v_tarjeta_id
    FROM tarjeta
    WHERE numero_tarjeta = 1122334455667788;

    --ACTUALIZACION 
    UPDATE tarjeta SET 
    mes = 01,
    anio = 25
    WHERE tarjeta_id = v_tarjeta_id;
      
    
  END:


    
  --ingreso incorrecto de una tarjeta
    BDMS_OUTPUT.PUT_LINE('CASO INSERCCION INCORRECTA');
    INSERT INTO tarjeta(tarjeta_id,numero_tarjeta, mes, anio, usuario_id)
      VALUES(tarjeta_seq.nextval,3333444433334444, 09, 24, 3);
  BEGIN 

  END;


--actualizacion incorrecta de una tarjeta
  BEGIN 
  --SE UTILIZARA LA TERJETA DEL EJEMPLO UNO
  --OBTENCIÓN DEL ID
    SELECT tarjeta_id INTO v_tarjeta_id 
    FROM tarjeta
    WHERE numero_tarjeta = 1122334455667788;
  --SE COLOCA EL UPDATE A UNA FECHA ANTERIOR A LA ACTUAL
    UPDATE tarjeta SET 
    mes = 01,
    anio = 19
    WHERE tarjeta_id = v_tarjeta_id;

  END;
END;
/
SHOW ERROS
