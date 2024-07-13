#!/usr/bin/env bash

cd /home/ubuntu/Resume
virtualenv /home/ubuntu/env
source /home/ubuntu/env/bin/activate
pip install -r /home/ubuntu/Resume/requirements.txt
cd /home/ubuntu/Resume