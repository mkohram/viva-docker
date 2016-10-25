# VIVA Install instructions
* Install `git`, `docker-engine` and `docker-compose`
* Run `prepare.sh` to clone appropriate repos.
* The following files will need to be adapted to the environment (the default is localhost):
    1. `nginx/conf.d/viva.conf`
    2. `viva_metadata/cpgmeta/local_settings.py`
    3. `viva_publicapi/public_api/public_api/settings/local.py`
    4. `viva_varkb/varkb_vw/settings/local.py`
    5. `viva_ui/config/environment.js`
    6. `docker-compose.yml`, `docker-compose.proxy.yml` and `docker-compose.dev.yml` depending on environment
* Run `docker-compose up --build`
* The default configs should be enough to setup a running instance of VIVA on `http://localhost:8080` on the host machine

---------------------

To install an independent instance for development:

1. dump data from metadata postgres database to `./fixtures/metadata.pgdump`. The dump command should be along the lines of:
    ```
    $ pg_dump -Fc -h host -U user -d db > <filename>.metadump
    ```

2. dump data from varkb postgres database to `./fixtures/varkb.pgdump`. The dump command should be along the lines of:
    ```
    $ pg_dump -Fc -h host -U user -d db -t core_* -T core_call -T core_variantjoin
    ```

    * **Notice** table `core_call` table being skipped

3. subset the `core_call` table from the varkb postgres db to `./fixtures/varkb_calls.gz` along the following lines:
    ```
    $ psql -h host -U user db -c "\copy (select * from core_call where sample in ('1','2','3','4','5','6','7','8','9','10')) to STDOUT with binary" | gzip > varkb_calls.gz
    ```