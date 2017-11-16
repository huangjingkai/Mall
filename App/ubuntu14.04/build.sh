#!/bin/bash

# Copyright @ HuangJingkai. All Rights Reserved.

set -o errexit
set -o pipefail

cd /etc/apt;
mv sources.list sources.list_bak; 
wget -O sources.list http://mirrors.163.com/.help/sources.list.trusty; 
apt-get update;
apt-get install -y mysql-server-5.6 mysql-client-5.6 nginx nginx-extras lua-nginx-redis php5-fpm php5-curl php5-gd php5-mysql php5-dev php-pear libmysqlclient-dev unzip git;

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
git clone https://gitee.com/huangjingkai/verydows.git
chown -R www-data:www-data verydows
service php5-fpm restart

nginx -s reload

# dms configuration
cd /var/www/verydows/service
wget http://114.115.148.177/jdk-8u151-linux-x64.tar.gz
tar -zxvf jdk-8u151-linux-x64.tar.gz
tar xf demo.tar
echo "============================================"
# db config to connect db
echo "Please enter db config "
read -p "DB Username:  " username
read -s -p "DB Password:  " password
sed -i "s@^server.type=.*@server.type=rest@" dms-score/score.properties
sed -i "s@jdbc:mysql://.* />@jdbc:mysql://localhost:3306/mysql\" />@" dms-score/db_conf.xml
if [ -z $username ]; then
    username=root
fi
if [ -z $username ]; then
    password=
fi
sed -i "s/<property name=\"username\" value=.* \/>/<property name=\"username\" value=\"$username\" \/>/" dms-score/db_conf.xml
sed -i "s/<property name=\"password\" value=.* \/>/<property name=\"password\" value=\"$password\" \/>/" dms-score/db_conf.xml
sh dms-manager/manager-start.sh
sh dms-manager/dms-start.sh
