#!/bin/bash

cd ~/spacemesh/

gnome-terminal --tab --title='post service smh12' -- bash -c "./service --dir /mnt/smh12/post --address http://192.168.1.6:9114 --operator-address 0.0.0.0:50012 --threads 0 --nonces 224 2>&1 | tee -a ~/spacemesh/logs/smh12.log"
