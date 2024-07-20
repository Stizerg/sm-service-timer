#!/bin/bash

# my example of service starting script

cd ~/spacemesh/

gnome-terminal --tab --title='post service smh21' -- bash -c "./service --dir /mnt/smh21/post --address http://192.168.1.6:9114 --operator-address 0.0.0.0:50021 --threads 0 --nonces 224 2>&1 | tee -a ~/spacemesh/logs/smh21.log"
