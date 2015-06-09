#!/bin/bash

wget -qO - https://packages.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
curl https://packagecloud.io/gpg.key | sudo apt-key add -
echo "deb http://packages.elastic.co/elasticsearch/1.5/debian stable main" | sudo tee -a /etc/apt/sources.list
sudo apt-get update && sudo apt-get install elasticsearch

sudo update-rc.d elasticsearch defaults 95 10

