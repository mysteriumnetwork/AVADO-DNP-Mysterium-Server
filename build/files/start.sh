#!/bin/bash

export OS_DIR_CONFIG="/"
export OS_DIR_DATA="/data/mysterium/var/lib/mysterium-node"
export OS_DIR_RUN="/data/mysterium/var/run/mysterium-node"

mkdir -p $OS_DIR_DATA
mkdir -p $OS_DIR_RUN

echo "Starting nginx"
nginx -c /etc/nginx/nginx.conf 

sleep 2
netstat -ln

export VPN_PORT=1294
echo "Starting myst on port $VPN_PORT"

/usr/local/bin/prepare-run-env.sh 

#Wireguard
/usr/bin/myst --vendor.id="AVADO" --tequilapi.allowed-hostnames=".localhost, localhost, .localdomain, mysterium.my.ava.do" --data-dir=$OS_DIR_DATA service --agreed-terms-and-conditions wireguard

echo "myst exited... wait 5m"
sleep 600

