#!/bin/bash

# Install JDK
set -x

YUM_CMD=$(which yum)
APT_GET_CMD=$(which apt-get)

ctx logger info "Installing Java"

if [[ ! -z $YUM_CMD ]]; then
   sudo yum -y -q install java-1.7.0-openjdk || exit $?   
   ctx logger info "Java installed succesfully"
   
   ctx logger info "Installing Elasticsearch"
   sudo rpm --import https://packages.elasticsearch.org/GPG-KEY-elasticsearch
   sudo echo "[elasticsearch-1.6]
   name=Elasticsearch repository for 1.6.x packages
   baseurl=http://packages.elastic.co/elasticsearch/1.6/centos
   gpgcheck=1
   gpgkey=http://packages.elastic.co/GPG-KEY-elasticsearch
   enabled=1
   EOF" | sudo tee /etc/yum.repos.d/elasticsearch.repo
   sudo yum install elasticsearch
   ctx logger info "Elasticsearch installed succesfully"
else
   sudo apt-get update
   sudo apt-get -f install libdevmapper-event1.02.1
   sudo apt-get -qq --no-upgrade install openjdk-7-jdk || exit $?   
   ctx logger info "Java installed succesfully"

   ctx logger info "Installing Elasticsearch"
   wget -qO - https://packages.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
   curl https://packagecloud.io/gpg.key | sudo apt-key add -
   echo "deb http://packages.elastic.co/elasticsearch/1.5/debian stable main" | sudo tee -a /etc/apt/sources.list
   sudo apt-get update && sudo apt-get install elasticsearch
   sudo update-rc.d elasticsearch defaults 95 10
   ctx logger info "Elasticsearch installed succesfully"
fi


