#!/bin/bash 
set -eo pipefail

if [ $# -ne 1 ]; then
	printf "Specify an environment: dev, test or prod\n\n"
	exit -1
fi
export ENV=$1
export ANSIBLE_MODULE=ping
summon -e $ENV ansible -m $ANSIBLE_MODULE -i ./inventory.yml 
