#!/usr/bin/bash

cd /home/ubuntu/Resume
echo "Pull Finished"
sudo systemctl daemon-reload
sudo systemctl restart nginx
