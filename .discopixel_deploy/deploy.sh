#!/bin/bash
dnf update -y
dnf install https://rpms.remirepo.net/enterprise/remi-release-9.rpm
dnf module install php:remi-8.4
dnf install php php-cli php-fpm php-mysqlnd php-zip php-devel php-pear php-gd php-mbstring php-curl php-xml php-bcmath php-json -y
dnf module install mysql -y
dnf install php-ldap -y
dnf install git -y
dnf install httpd
dnf update -y
cd /var/
git clone https://github.com/discopix/snipe-it
chown apache:apache /var/snipe-it
cp /var/snipe-it/.discopixel_deploy/100_snipe.conf /etc/httpd/conf.d/100_snipe.conf
cp .env.example .env

systemctl enable httpd
systemctl start httpd