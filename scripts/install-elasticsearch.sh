#!/bin/bash

#!/bin/bash
# Install JDK

set -x

YUM_CMD=$(which yum)
APT_GET_CMD=$(which apt-get)

ctx logger info "Installing Java"
# Get Java
if [[ ! -z $YUM_CMD ]]; then
   sudo yum -y -q install java-1.7.0-openjdk || exit $?   
else
   sudo apt-get update
   sudo apt-get -f install libdevmapper-event1.02.1
   sudo apt-get -qq --no-upgrade install openjdk-7-jdk || exit $?   
fi

ctx logger info "Java installed succesfully"

ctx logger info "Installing Elasticsearch"

wget -qO - https://packages.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
curl https://packagecloud.io/gpg.key | sudo apt-key add -
echo "deb http://packages.elastic.co/elasticsearch/1.5/debian stable main" | sudo tee -a /etc/apt/sources.list
sudo apt-get update && sudo apt-get install elasticsearch

sudo update-rc.d elasticsearch defaults 95 10

ctx logger info "Elasticsearch installed succesfully"
