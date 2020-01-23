#!/bin/bash

apt-get -y update
apt-get -y install apache2 
curl https://joso1801storage.blob.core.windows.net/joso1801blobs/server2.html > /var/www/html/index.html
apachectl restart