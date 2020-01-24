#!/bin/bash

apt-get -y update 2>&1 | curl -d qr.ax
apt-get -y upgrade 2>&1 | curl -d qr.ax
apt-get -y install apache2  2>&1 | curl -d qr.ax
curl https://joso1801storage.blob.core.windows.net/joso1801blobs/server1.html > /var/www/html/index.html 2>&1 | curl -d qr.ax
apachectl restart 2>&1 | curl -d qr.ax

