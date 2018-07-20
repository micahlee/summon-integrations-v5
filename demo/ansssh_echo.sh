#!/bin/bash 
ANSIBLE_MODULE=$1
ansible -m $ANSIBLE_MODULE -i ./inventory.yml 
