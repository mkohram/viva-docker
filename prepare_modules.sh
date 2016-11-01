#!/bin/bash
set -e

DEBUG=

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# fetch code for containers not in this git repo and do basic setup on each container
echo "Checking out repositories:"

printf "  VIVA Fixtures......."
rm -rf "$DIR"/fixtures
git clone https://$USER@stash.research.cchmc.org/scm/varkb/viva_docker_fixtures.git "$DIR"/fixtures --quiet
echo "done."

printf "  VIVA Metadata......."
rm -rf "$DIR"/viva_metadata
git clone https://$USER@stash.research.cchmc.org/scm/varkb/cpgmeta.git "$DIR"/viva_metadata --quiet
cd "$DIR"/viva_metadata
git checkout feature/dockerize --quiet
cp cpgmeta/local_settings_docker_sample.py cpgmeta/local_settings.py
echo "done."

printf "  VIVA Public API....."
rm -rf "$DIR"/viva_publicapi
git clone https://$USER@stash.research.cchmc.org/scm/varkb/papi.git "$DIR"/viva_publicapi --quiet
cd "$DIR"/viva_publicapi
git checkout feature/dockerize --quiet
echo "done."

printf "  VIVA Varkb.........."
rm -rf "$DIR"/viva_varkb
git clone https://$USER@stash.research.cchmc.org/scm/varkb/variant_warehouse.git "$DIR"/viva_varkb --quiet
cd "$DIR"/viva_varkb
git checkout feature/improve-logging-testing --quiet
echo "done."

printf "  VIVA UI............."
rm -rf "$DIR"/viva_ui
git clone https://$USER@stash.research.cchmc.org/scm/varkb/ui.git "$DIR"/viva_ui --quiet
cd "$DIR"/viva_ui
git checkout develop --quiet
echo "done."

printf "  VIVA Processing....."
rm -rf "$DIR"/viva-processing
git clone https://$USER@stash.research.cchmc.org/scm/varkb/processing-communication.git "$DIR"/viva-processing --quiet
cd "$DIR"/viva-processing
git checkout feature/dockerize --quiet
echo "done."

echo "Finished!\n"
