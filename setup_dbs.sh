#!/bin/bash

COMPOSEOPTS='-f docker-compose.yml -f docker-compose.dev.yml'

docker-compose $COMPOSEOPTS up --build -d

# wait for postgres to fully load
sleep 10

# set up metadata module
docker-compose $COMPOSEOPTS exec --user root viva_metadata python manage.py makemigrations cpgmetadata
docker-compose $COMPOSEOPTS exec --user root viva_metadata python manage.py migrate
docker-compose $COMPOSEOPTS exec --user root viva_metadata python manage.py loaddata cpgmetadata/fixtures/fixture.cpgmetadata.initial_data.json
docker-compose $COMPOSEOPTS exec --user root viva_metadata python manage.py check_accounts

docker-compose $COMPOSEOPTS exec --user root viva_varkb python manage.py migrate

# docker-compose $COMPOSEOPTS exec postgres pg_restore --no-owner --clean -Fc -U srv_viva_metadata -d viva_metadata /fixture_data/metadata.pgdump

# docker-compose $COMPOSEOPTS exec postgres pg_restore --no-owner --clean -Fc -U srv_viva_varkb -d viva_varkb /fixture_data/varkb.pgdump
# docker-compose $COMPOSEOPTS exec postgres sh -c 'gzip -dc /fixture_data/varkb_calls.gz | psql -U postgres viva_varkb -c "COPY core_call from STDIN with binary"'

# cp viva_varkb/bin/load/utils.sql fixtures/
# docker-compose $COMPOSEOPTS exec postgres sh -c 'psql -U postgres viva_varkb < /fixture_data/utils.sql'
# rm fixtures/utils.sql

# docker-compose $COMPOSEOPTS exec postgres psql -U postgres viva_varkb -c 'SELECT create_join_table();'

docker-compose $COMPOSEOPTS stop