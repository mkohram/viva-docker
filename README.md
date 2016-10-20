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