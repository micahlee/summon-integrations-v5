#!/bin/bash  -x
set -eo pipefail
CONJUR_MASTER_IMAGE=conjur-appliance:5-intlzd
CONJUR_BUILD_CONTAINER_NAME=conjur_master
CONJUR_MASTER_NAME=conjur_master
CONJUR_ADMIN_PASSWORD=Cyberark1
CONJUR_ORG_ACCOUNT=dev

#if [[ "$(docker images | grep conjur-appliance | grep 5-intlzd | grep -v grep)" == "" ]]; then
#	./build/conjur_master/build_initialized_master.sh $CONJUR_MASTER_IMAGE
#fi

docker-compose up -d
docker exec $CONJUR_BUILD_CONTAINER_NAME evoke configure master -h $CONJUR_MASTER_NAME -p $CONJUR_ADMIN_PASSWORD $CONJUR_ORG_ACCOUNT
docker exec -it conjur_cli bash -x /demo/init.sh
docker cp conjur_cli:/root/conjur-dev.pem ./demo
docker exec -it client_node bash
