#!/bin/bash

# Based on https://github.com/jacksoncage/salt-docker

# Variables from environement
: "${SALT_TYPE:=master}"
: "${SALT_NAME:=master}"
: "${LOG_LEVEL:=info}"
: "${OPTIONS:=}"

# Set minion id
echo $SALT_NAME > /etc/salt/minion_id

# If salt master also start minion in background
if [ "$SALT_TYPE" == "master" ]; then
  echo "INFO: Starting salt-minion and auto connect to salt-master"
  sudo service salt-minion start
fi

# Set salt grains
if [ ! -z "$SALT_GRAINS" ]; then
  echo "INFO: Set grains on $SALT_NAME to: $SALT_GRAINS"
  echo $SALT_GRAINS > /etc/salt/grains
fi

# Start salt
echo "INFO: Starting salt-$SALT_TYPE with log level $LOG_LEVEL with hostname $SALT_NAME"
