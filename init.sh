#!/bin/bash 
# this script:
# - executes in the CLI container
# - mounts the demo root directory at /demo_root
# - loads policy from the mounted fs
# - initializes variables 
# - creates conjur* conjurization files in the mounted fs

CONJUR_HOSTNAME=conjur-master
CONJUR_ORG_ACCOUNT=dev
CONJUR_ADMIN_UNAME=admin
CONJUR_ADMIN_PWD=Cyberark1
CLIENT_AUTHN_NAME=client/node

  conjur init -u https://$CONJUR_HOSTNAME -a $CONJUR_ORG_ACCOUNT << END
yes
END

conjur authn login -u $CONJUR_ADMIN_UNAME -p $CONJUR_ADMIN_PWD
cd /demo_root
conjur policy load --replace root policy.yml
conjur variable values add secrets/test-db_username ThisIsTheTESTDBuserName
conjur variable values add secrets/test-db_password 10938471084710238470973
conjur variable values add secrets/prod-db_username ThisIsThePRODDBuserName
conjur variable values add secrets/prod-db_password aoiuaspduperjqkjnsoudoo

HOST_API_KEY=$(conjur host rotate_api_key --host $CLIENT_AUTHN_NAME)

# create configuration and identity files (AKA conjurize the host)
cp ~/conjur-$CONJUR_ORG_ACCOUNT.pem .

echo "Generating identity file..."
cat <<IDENTITY_EOF | tee conjur.identity
machine https://$CONJUR_HOSTNAME/api/authn
  login host/$CLIENT_AUTHN_NAME
  password $HOST_API_KEY
IDENTITY_EOF

echo
echo "Generating host configuration file..."
cat <<CONF_EOF | tee conjur.conf
---
appliance_url: https://$CONJUR_HOSTNAME/api
account: $CONJUR_ORG_ACCOUNT
netrc_path: "/etc/conjur.identity"
cert_file: "/etc/conjur-$CONJUR_ORG_ACCOUNT.pem"
CONF_EOF
