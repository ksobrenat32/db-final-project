--@Autor(es): Enrique Job Calderón Olalde <@ksobrenat32>, Erick Nava Santiago
--@Fecha creación: 1 de diciembre de 2024
--@Descripción: Este script contendrá la definición de 2 usuarios: <iniciales>_proy_invitado y <iniciales>_proy_admin, donde <iniciales> corresponden a la primera letra de cada apellido paterno de cada integrante. El usuario admin será el dueño de todos los objetos del caso de estudio.
-- Incluir en el script la definición de 2 roles:
-- - rol_admin Contendrá todos los roles necesarios para poder implementar el caso de estudio asignado.
-- - rol_invitado Sólo deberá tener permisos para crear sesiones.
-- - Asignar a los usuarios admin e invitado los roles rol_admin y rol_invitado respectivamente.

prompt Conectando a la base de datos

-- Conectar a la base de datos como sysdba en la PDB FREEPDB1
CONNECT sys/system1@//localhost:1521/FREEPDB1 AS SYSDBA

prompt Creando usuarios y roles

-- Crear roles con los permisos necesarios
prompt Creando rol_admin
DROP ROLE IF EXISTS rol_admin;
CREATE ROLE rol_admin;
GRANT CREATE VIEW, CREATE SEQUENCE, CREATE SYNONYM, CREATE TABLE, CREATE PROCEDURE, CREATE TRIGGER, CREATE SESSION TO rol_admin;

prompt Creando rol_invitado
DROP ROLE IF EXISTS rol_invitado;
CREATE ROLE rol_invitado;
GRANT CREATE SESSION TO rol_invitado;

-- Crear usuarios
prompt Creando cn_proy_admin
DROP USER IF EXISTS cn_proy_admin CASCADE;
CREATE USER cn_proy_admin IDENTIFIED BY cn_proy_admin QUOTA UNLIMITED ON USERS;
GRANT rol_admin TO cn_proy_admin;

prompt Creando cn_proy_invitado
DROP USER IF EXISTS cn_proy_invitado CASCADE;
CREATE USER cn_proy_invitado IDENTIFIED BY cn_proy_invitado;
GRANT rol_invitado TO cn_proy_invitado;
