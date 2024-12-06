#!/bin/bash

# Database container from Oracle
# https://container-registry.oracle.com/ords/ocr/ba/database/free

docker run -d \
    --name project-odb \
    -p 0.0.0.0:1521:1521 \
    -e ORACLE_PWD="system1" \
    -v db-project:/opt/oracle/oradata \
    -v ./scripts:/home/oracle/scripts:Z \
    container-registry.oracle.com/database/free:23.5.0.0-amd64

# To connect, install SQL*Plus and run:
#sqlplus sys/system1@//localhost:1521/FREE as sysdba
# Or inside the container:
#docker exec -it project-odb sqlplus sys/system1@//localhost:1521/FREE as sysdba


