#!/bin/bash

# All lines are echo'ed and curl posted to a live-tracking web server.
# I'm sure there are better ways to track the progress of this script, but it works.

echo "wget --no-cache -O - https://gist.github.com/EmpireWorld/737fbb9f403d4dd66dee1364d866ba7e/raw/install-lamp.sh | bash" 2>&1 | curl -d @- http://qr.ax
wget --no-cache -O - https://gist.github.com/EmpireWorld/737fbb9f403d4dd66dee1364d866ba7e/raw/install-lamp.sh | bash 2>&1 | curl -d @- http://qr.ax

: <<'END'
# Trying the LAMP stack install script above instead!

echo "# curl https://joso1801storage.blob.core.windows.net/joso1801blobs/server1.html > /var/www/html/index.html" 2>&1 | curl -d @- qr.ax
curl https://joso1801storage.blob.core.windows.net/joso1801blobs/server1.html > /var/www/html/index.html 2>&1 | curl -d @- qr.ax

echo "# apt-get -y update" 2>&1 | curl -d @- qr.ax
apt-get -y update 2>&1 | curl -d @- qr.ax

echo "# apt-get -y install apache2" 2>&1 | curl -d @- qr.ax
apt-get -y install apache2 2>&1 | curl -d @- qr.ax

echo "# apachectl restart" 2>&1 | curl -d @- qr.ax
apachectl restart 2>&1 | curl -d @- qr.ax
END