#!/bin/bash
set -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# fetch code for containers not in this git repo and do basic setup on each container
rm -rf "$DIR"/viva_metadata
git clone https://$USER@stash.research.cchmc.org/scm/varkb/cpgmeta.git "$DIR"/viva_metadata
cd "$DIR"/viva_metadata
git checkout feature/dockerize
cp cpgmeta/local_settings_docker_sample.py cpgmeta/local_settings.py

rm -rf "$DIR"/viva_publicapi
git clone https://$USER@stash.research.cchmc.org/scm/varkb/papi.git "$DIR"/viva_publicapi
cd "$DIR"/viva_publicapi
git checkout feature/dockerize

rm -rf "$DIR"/viva_varkb
git clone https://$USER@stash.research.cchmc.org/scm/varkb/variant_warehouse.git "$DIR"/viva_varkb
cd "$DIR"/viva_varkb
git checkout feature/dockerize

rm -rf "$DIR"/viva_ui
git clone https://$USER@stash.research.cchmc.org/scm/varkb/ui.git "$DIR"/viva_ui
cd "$DIR"/viva_ui
git checkout feature/dockerize