#!/bin/bash
set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" <<-EOSQL
    CREATE USER srv_viva_metadata;
    CREATE DATABASE viva_metadata;
    GRANT ALL PRIVILEGES ON DATABASE viva_metadata TO srv_viva_metadata;
EOSQL

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" <<-EOSQL
    CREATE USER srv_viva_varkb;
    CREATE DATABASE viva_varkb;

    -- need superuser for CREATE EXTENSION
    ALTER USER srv_viva_varkb WITH SUPERUSER;

    -- if srv_viva_varkb is not a superuser these lines would be needed
    -- GRANT ALL PRIVILEGES ON DATABASE viva_varkb TO srv_viva_varkb;
    -- \connect viva_varkb;
    -- CREATE EXTENSION btree_gist;
    -- CREATE EXTENSION intarray;
EOSQL