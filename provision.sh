#! /bin/bash
sudo apt-get update -y
sudo apt-get install nginx -y
sudo systemctl start nginx
sudo apt install curl
curl -sL https://deb.nodesource.com/setup_13.x | sudo bash -
sudo apt-get install -y nodejs
npm install -g express --save
npm install mongoose
npm install ejs
sudo npm install pm2@latest -g
sudo unlink /etc/nginx/sites-enabled/default
sudo ln -s /home/vagrant/app/reverse-proxy.conf /etc/nginx/sites-available/reverse-proxy.conf
sudo ln -s /etc/nginx/sites-available/reverse-proxy.conf /etc/nginx/sites-enabled/reverse-proxy.conf
sudo service nginx restart
