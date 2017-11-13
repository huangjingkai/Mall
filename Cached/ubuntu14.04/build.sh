#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail

if [ ! -d nginx ];then 
	echo "The source attachment does not contain the foder: ./nginx/, download from github.com/huangjingkai/Mall please. "
	exit 1
fi

[ -f /etc/apt/sources.list ] && mv /etc/apt/sources.list /etc/apt/sources.list_bak; 
wget -O sources.list http://mirrors.163.com/.help/sources.list.trusty; 
cp -f sources.list /etc/apt

apt-get update;
apt-get install -y nginx nginx-extras lua-nginx-redis unzip git redis-tools;

[ ! -d /usr/share/nginx/demo_html ] && mkdir -p /usr/share/nginx/demo_html;
chown -R www-data:www-data  /usr/share/nginx/demo_html;

# unzip nginx.zip
cp -r nginx/* /etc/nginx/

nginx -s reload;