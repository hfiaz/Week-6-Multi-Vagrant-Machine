#!/bin/bash
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 0C49F3730359A14518585931BC711F9BA15703C6
echo "deb [ arch=amd64,arm64 ] http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.4 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.4.list
sudo apt-get update -y
sudo apt-get install mongodb-org -y
sudo rm /etc/mongod.conf
sudo ln -s /home/ubuntu/environment/mongod.conf /etc/mongod.conf
sudo systemctl restart mongod
sudo systemctl enable mongod