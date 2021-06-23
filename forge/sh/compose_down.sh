#!/bin/sh
. ./forge/sh/constants.sh

set -x
docker-compose \
    -f forge/docker-compose.yaml \
    --project-name ${REPO_FOLDER} \
    --project-directory ${REPO_FOLDER} \
    down
