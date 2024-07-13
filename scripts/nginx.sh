#!/usr/bin/bash

cd /home/ubuntu/Resume
sudo systemctl daemon-reload
sudo rm -f /etc/nginx/sites-enabled/default

sudo cp /home/ubuntu/Resume/nginx/nginx.conf /etc/nginx/sites-available/resume
sudo ln -s /etc/nginx/sites-available/resume /etc/nginx/sites-enabled/
#sudo ln -s /etc/nginx/sites-available/blog /etc/nginx/sites-enabled
#sudo nginx -t
sudo gpasswd -a www-data ubuntu
sudo systemctl restart nginx
cd /home/ubuntu/Resume