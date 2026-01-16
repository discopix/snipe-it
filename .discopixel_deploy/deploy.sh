#!/bin/bash
dnf update -y
dnf install https://rpms.remirepo.net/enterprise/remi-release-9.rpm
dnf module install php:remi-8.4
dnf install php php-cli php-fpm php-mysqlnd php-zip php-devel php-pear php-gd php-mbstring php-curl php-xml php-bcmath php-json php-ldap -y
dnf module install mysql -y
dnf install git -y
dnf install httpd
dnf update -y

cd /var/
git clone https://github.com/discopix/snipe-it
chown -R apache:apache /var/snipe-it
cp /var/snipe-it/.discopixel_deploy/100_snipe.conf /etc/httpd/conf.d/100_snipe.conf

systemctl enable httpd
systemctl start httpd

firewall-cmd --add-service=http --permanent
firewall-cmd --add-service=https --permanent
firewall-cmd --reload

systemctl enable mysqld
systemctl start mysqld

echo "CREATE USER 'snipe'@'localhost' IDENTIFIED BY 'Y96ErXWr48SVv6cfKoZ54ZlaqseStt';" | mysql
echo "CREATE DATABASE snipe; " | mysql
echo "GRANT ALL PRIVILEGES ON snipe.* To 'snipe'@'localhost' " | mysql
echo "FLUSH PRIVILEGES;" | mysql
echo "ALTER USER 'root'@'localhost' IDENTIFIED BY 'hOIz6hMuI2zztkSWCcF18p1XQ4911LEf';" | mysql


cd /var/snipe-it/
cp discopixel_deploy/.env.example .env


php artisan key:generate