#!/bin/bash

# Copyright @ HuangJingkai. All Rights Reserved.

set -o errexit
set -o pipefail

[ -f /etc/apt/sources.list ] && mv sources.list /tmp
find /etc/apt -type f | xargs rm -f

wget -O sources.list http://mirrors.163.com/.help/sources.list.trusty; 
cp sources.list /etc/apt

apt-get update;
apt-get install -y --force-yes nginx nginx-extras lua-nginx-redis unzip git redis-tools dos2unix;

[ ! -d /usr/share/nginx/demo_html ] && mkdir -p /usr/share/nginx/demo_html;
chown -R www-data:www-data  /usr/share/nginx/demo_html;

# unzip nginx.zip
cp -rf nginx/* /etc/nginx/

nginx -s reload;
