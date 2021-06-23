#!/bin/sh

if [ -z $1 ]
then
  COMMAND="bash"
else
  COMMAND="${@}"
fi

. ./forge/sh/constants.sh
. ./forge/sh/docker_network_create.sh

#Make more verbose now
set -x
docker-compose -f forge/docker-compose.yaml pull
docker-compose \
  -f forge/docker-compose.yaml \
  -p ${REPO_FOLDER} \
  --project-directory ${REPO_FOLDER} \
  ps | grep ${REPO_FOLDER} > /dev/null
#$? is 0 if already running, 1 if not (0=no error)
ALREADY_RUNNING=$?
#Make less verbose now
set +x

if [ "$ALREADY_RUNNING" -eq 0 ];
then
  echo "Service already running, only opening shell"
else
  docker-compose \
    -f forge/docker-compose.yaml \
    --project-name ${REPO_FOLDER} \
    --project-directory ${REPO_FOLDER} \
    up -d
fi

echo "Connecting to docker shell and running command $COMMAND... and project $REPO_FOLDER"
docker-compose \
  -f forge/docker-compose.yaml \
  --project-name ${REPO_FOLDER} \
  --project-directory ${REPO_FOLDER} \
  exec $PROJECT_NAME $COMMAND
