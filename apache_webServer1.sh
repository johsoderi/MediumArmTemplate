#!/bin/bash

# Comments and most cmd's are echo'ed and curl posted to a live-tracking web server.
# I'm sure there are better ways to track the progress of this script, but it works.

echo "Update Package Index" 2>&1 | curl -d @- http://qr.ax
sudo apt update 2>&1 | curl -d @- http://qr.ax

echo "Install Apache2, MySQL, PHP" 2>&1 | curl -d @- http://qr.ax
sudo apt install apache2 mysql-server php php-mysql libapache2-mod-php php-cli 2>&1 | curl -d @- http://qr.ax

echo "Allow to run Apache on boot up" 2>&1 | curl -d @- http://qr.ax
sudo systemctl enable apache2 2>&1 | curl -d @- http://qr.ax

echo "Restart Apache Web Server" 2>&1 | curl -d @- http://qr.ax
sudo systemctl start apache2 2>&1 | curl -d @- http://qr.ax

echo "Adjust Firewall" 2>&1 | curl -d @- http://qr.ax
sudo ufw allow in "Apache Full" 2>&1 | curl -d @- http://qr.ax

echo "Allow Read/Write for Owner" 2>&1 | curl -d @- http://qr.ax
sudo chmod -R 0755 /var/www/html/ 2>&1 | curl -d @- http://qr.ax

echo "Create info.php for testing php processing" 2>&1 | curl -d @- http://qr.ax
sudo echo "<?php phpinfo(); ?>" > /var/www/html/info.php

echo "Copy index.html" 2>&1 | curl -d @- http://qr.ax
curl https://joso1801storage.blob.core.windows.net/joso1801blobs/server1.html > /var/www/html/index.html

echo "Done." 2>&1 | curl -d @- http://qr.ax