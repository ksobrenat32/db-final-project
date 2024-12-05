 --@Autor(es): Enrique Job Calderón Olalde <@ksobrenat32>, Erick Nava Santiago
--@Fecha creación: 1 de diciembre de 2024
--@Descripción: Carga de datos para tablas relevantes

--REGISTROS PARA LA TABLA USUARIO
insert into usuario(usuario_id, username, nombre, apellido_paterno, apellido_materno,
  correo, contrasenia, es_cliente, es_administrador, es_conductor, usuario_recomendado_id)
  values(usuario_seq.nextval, 'juan','frias','gonzalez', 'jfgoz@gmail.com',0,0,1,null);
