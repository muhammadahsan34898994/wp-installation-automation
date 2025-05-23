#!/bin/bash

echo "Downloading WordPress..."
cd /tmp
curl -O https://wordpress.org/latest.tar.gz

echo "Extracting WordPress..."
tar xzvf latest.tar.gz

echo "Moving WordPress files to /var/www/html..."
sudo cp -a wordpress/. /var/www/html/

echo "Cleaning up temporary files..."
rm -rf /tmp/wordpress /tmp/latest.tar.gz
cd ~

echo "Setting ownership and permissions..."
sudo chown -R www-data:www-data /var/www/html/
sudo chmod -R 755 /var/www/html/

echo "Configuring WordPress..."
cd /var/www/html
sudo rm index.html
sudo mv wp-config-sample.php wp-config.php

echo "Inserting database credentials into wp-config.php..."
sudo sed -i "s/database_name_here/wordpress/" wp-config.php
sudo sed -i "s/username_here/wpuser/" wp-config.php
sudo sed -i "s/password_here/StrongP@ssw0rd!/" wp-config.php
sudo sed -i "s/localhost/localhost/" wp-config.php

echo "Restarting Apache..."
sudo systemctl restart apache2

echo "==>WordPress is installed, configured, and ready to go!"
