#!/bin/bash

echo "Downloading WordPress..."
cd /tmp
curl -O https://wordpress.org/latest.tar.gz

echo "Extracting WordPress..."
tar -xzf latest.tar.gz

echo "Cleaning /var/www/html/..."
sudo rm -rf /var/www/html/*

echo "Copying WordPress files to /var/www/html/..."
sudo cp -a wordpress/. /var/www/html/

echo "Cleaning up temporary files..."
rm -rf /tmp/wordpress /tmp/latest.tar.gz

echo "Setting ownership and permissions..."
sudo chown -R www-data:www-data /var/www/html/
sudo chmod -R 755 /var/www/html/

echo "Configuring WordPress..."
cd /var/www/html
sudo rm -f index.html
sudo mv wp-config-sample.php wp-config.php

sudo sed -i "s/database_name_here/wordpress/" wp-config.php
sudo sed -i "s/username_here/wpuser/" wp-config.php
sudo sed -i "s/password_here/StrongP@rg0rd!/" wp-config.php
sudo sed -i "s/localhost/localhost/" wp-config.php

echo "Restarting Apache..."
sudo systemctl restart apache2

echo "WordPress is installed, configured, and ready to go!"
