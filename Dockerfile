# Based on https://github.com/jacksoncage/salt-docker

FROM        ubuntu:14.04
MAINTAINER  Marian Zange <marian@crashpad.io>

ENV SALT_VERSION 2015.5.3+ds-1trusty1

RUN apt-get update
RUN	apt-get install -y wget curl dnsutils python-pip python-dev python-apt \
    python-software-properties software-properties-common dmidecode

RUN add-apt-repository ppa:saltstack/salt

RUN apt-get update
RUN apt-get install -y \
    salt-master=$SALT_VERSION \
    salt-minion=$SALT_VERSION \
	  salt-cloud=$SALT_VERSION \
	  salt-ssh=$SALT_VERSION \
	  salt-api=$SALT_VERSION \
	  salt-syndic=$SALT_VERSION

ADD etc/master /etc/salt/master
ADD etc/minion /etc/salt/minion
ADD etc/reactor /etc/salt/master.d/reactor

EXPOSE 4505 4506

ADD run.sh /run.sh
CMD ["bash", "run.sh"]