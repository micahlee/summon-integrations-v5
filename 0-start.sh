#!/bin/bash  -x
set -eo pipefail
CONJUR_MASTER_IMAGE=conjur-appliance:5-intlzd
CONJUR_BUILD_CONTAINER_NAME=conjur_master
CONJUR_MASTER_NAME=conjur_master
CONJUR_ADMIN_PASSWORD=Cyberark1
CONJUR_ORG_ACCOUNT=dev

main() {
#  startup_conjur
  conjurize_client_node
  docker exec -it client_node bash
}

## TO DO: make this work to avoid running evoke on startup every time
build_initialized_image() {
  if [[ "$(docker images | grep conjur-appliance | grep 5-intlzd | grep -v grep)" == "" ]]; then
 	./build/conjur_master/build_initialized_master.sh $CONJUR_MASTER_IMAGE
  fi
}

startup_conjur() {
  docker-compose up -d
  docker exec $CONJUR_BUILD_CONTAINER_NAME evoke configure master -h $CONJUR_MASTER_NAME -p $CONJUR_ADMIN_PASSWORD $CONJUR_ORG_ACCOUNT
}

conjurize_client_node() {
  docker exec -it conjur_cli bash -x /demo_root/init.sh
  docker cp ./conjur-$CONJUR_ORG_ACCOUNT.pem client_node:/etc
  docker cp ./conjur.conf client_node:/etc
  docker cp ./conjur.identity client_node:/etc
  rm ./conjur*
}

main $@
