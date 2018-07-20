#!/bin/bash
if [[ "$1" == "" ]]; then
	echo "need to specify an environment (dev, test or prod)"
	exit 01
fi
. auth.env
. api_key.txt
set -x
summon -e $1 bash -c 'terraform apply -var "db_uname=$DB_UNAME" -var "db_pwd=$DB_PWD" '
