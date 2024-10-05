#!/bin/bash

cd ~/spacemesh/

gnome-terminal --tab --title='post service smh11' -- bash -c "./service --dir /mnt/smh11/post --address http://192.168.1.6:9114 --operator-address 0.0.0.0:50011 --threads 0 --nonces 224 2>&1 | tee -a ~/spacemesh/logs/smh11.log"
