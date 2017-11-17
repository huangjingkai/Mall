#!/bin/bash

# Copyright @ HuangJingkai. All Rights Reserved.

set -o errexit
set -o pipefail

cd /etc/apt;
[ -f sources.list ] && mv sources.list /tmp
find /etc/apt -type f | xargs rm -f

wget -O sources.list http://mirrors.163.com/.help/sources.list.trusty; 
apt-get update;
apt-get install -y --force-yes mysql-server-5.6 mysql-client-5.6 nginx nginx-extras lua-nginx-redis php5-fpm php5-curl php5-gd php5-mysql php5-dev php-pear libmysqlclient-dev unzip git;

sed -i 's#/var/run/php5-fpm.sock#127.0.0.1:9000#g' /etc/php5/fpm/pool.d/www.conf;
service php5-fpm restart;

cat << EOF > /etc/nginx/sites-available/default
server { 
    listen 80 default_server; 
    root /var/www/verydows; 
    index index.html index.htm index.php; 
    server_name localhost; 
    location / { 
        rewrite ^/index\.php$ - last; 
        if (!-e \$request_filename){ 
            rewrite ^(.*)$ /index.php?/$1 last; 
        } 
    } 
    location ^~ /protected/ { 
        deny all; 
    } 
    location ~ \.php$ { 
         fastcgi_split_path_info ^(.+\.php)(/.+)$; 
         fastcgi_pass 127.0.0.1:9000; 
         fastcgi_index index.php; 
         include fastcgi_params; 
    } 
} 
EOF

mkdir -p /var/www; cd /var/www
[ ! -d verydows ] && git clone https://gitee.com/huangjingkai/verydows.git
chown -R www-data:www-data verydows
service php5-fpm restart

nginx -s reload
