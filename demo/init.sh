#!/bin/bash 
CONJUR_HOSTNAME=conjur_master
CONJUR_ORG_ACCOUNT=dev
CONJUR_ADMIN_UNAME=admin
CONJUR_ADMIN_PWD=Cyberark1
API_KEY_FILE=/demo/api_key.txt
CLIENT_AUTHN_NAME=client/node

  conjur init -u https://$CONJUR_HOSTNAME -a $CONJUR_ORG_ACCOUNT << END
yes
END
  conjur authn login -u $CONJUR_ADMIN_UNAME -p $CONJUR_ADMIN_PWD
  conjur policy load --replace root /demo/policy.yml
  conjur variable values add secrets/test-db_username ThisIsTheTESTDBuserName
  conjur variable values add secrets/test-db_password 10938471084710238470973
  conjur variable values add secrets/prod-db_username ThisIsThePRODDBuserName
  conjur variable values add secrets/prod-db_password aoiuaspduperjqkjnsoudoo
  HOST_API_KEY=$(conjur host rotate_api_key --host $CLIENT_AUTHN_NAME)
  echo "export CONJUR_AUTHN_API_KEY=$HOST_API_KEY" > $API_KEY_FILE
