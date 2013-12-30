#!/usr/bin/env bash

echo "-- Starting the install process"

echo "-- Update Packages"
sudo apt-get update

echo "-- Installing basic tools, like vim"
sudo apt-get install -y vim curl wget git

echo "-- Mysql server default password"
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password root'
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password root'

echo "-- Installing apache"
sudo apt-get install -y apache2 apache2-mpm-prefork
sudo a2enmod rewrite
sudo a2enmod deflate
sudo sed -i 's/AllowOverride None/AllowOverride All/' /etc/apache2/apache2.conf

echo "-- Setting document root"
mkdir /vagrant/public
sudo rm -rf /var/www
sudo ln -fs /vagrant/public /var/www

echo "-- Installing the latest php 5.5"
cat << EOF | sudo tee -a /etc/apt/sources.list
deb http://packages.dotdeb.org wheezy-php55 all
deb-src http://packages.dotdeb.org wheezy-php55 all
EOF

sudo apt-get update

wget http://www.dotdeb.org/dotdeb.gpg
sudo apt-key add dotdeb.gpg

sudo apt-get update

sudo apt-get install -y php5 php5-mysql php5-mcrypt php5-curl php5-gd libapache2-mod-php5

sudo a2enmod php5

sed -i "s/error_reporting = .*/error_reporting = E_ALL/" /etc/php5/apache2/php.ini
sed -i "s/display_errors = .*/display_errors = On/" /etc/php5/apache2/php.ini

echo "-- Installing mysql"
sudo apt-get install -y mysql-client-5.5 mysql-server-5.5

echo "-- Installing xdebug"
sudo apt-get install -y php5-xdebug
cat << EOF | sudo tee -a /etc/php5/mods-available/xdebug.ini
xdebug.scream=1
xdebug.cli_color=1
xdebug.show_local_vars=1
EOF

echo "-- Restarting apache"
sudo service apache2 restart

echo "-- Installing composer"
curl -s https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer

echo "-- Finished, ready to dev."
