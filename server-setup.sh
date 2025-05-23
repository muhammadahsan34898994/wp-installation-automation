#!/bin/bash

echo "Updating and upgrading system..."
sudo apt update && sudo apt upgrade -y

echo "Installing Apache..."
sudo apt install apache2 -y

echo "Installing PHP and MySQL dependencies..."
sudo apt install php libapache2-mod-php php-mysql -y

echo "Installing MySQL server..."
sudo apt install mysql-server -y

echo "Securing MySQL (you'll be prompted)..."
sudo mysql_secure_installation

echo "Configuring WordPress database..."
sudo mysql <<EOF
CREATE DATABASE wordpress DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;
CREATE USER 'wpuser'@'localhost' IDENTIFIED BY 'StrongP@ssw0rd!';
GRANT ALL PRIVILEGES ON wordpress.* TO 'wpuser'@'localhost';
FLUSH PRIVILEGES;
EXIT;
EOF

echo "==>Server is ready for WordPress installation."
