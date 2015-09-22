#!/bin/bash

# Based on https://github.com/jacksoncage/salt-docker

# Variables from environement
: "${SALT_TYPE:=master}"
: "${SALT_NAME:=salt-master}"

# Set minion id
echo $SALT_NAME > /etc/salt/minion_id
service salt-minion start

# Set salt grains
if [ ! -z "$SALT_GRAINS" ]; then
  echo "INFO: Set grains on $SALT_NAME to: $SALT_GRAINS"
  echo $SALT_GRAINS > /etc/salt/grains
fi


if [ "$SALT_TYPE" == "master" ]; then
  salt-master -l info
fi