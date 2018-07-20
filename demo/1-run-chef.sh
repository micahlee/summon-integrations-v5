#!/bin/bash
if [[ "$1" == "" ]]; then
	echo "need to specify an environment (dev, test or prod)"
	exit 01
fi
. auth.env
. api_key.txt
set -x
summon -e $1 chef-solo secrets-echo.rb
