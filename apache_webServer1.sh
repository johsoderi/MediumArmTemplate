#!/bin/bash
apt-get -y update

# install Apache2
apt-get -y install apache2 
apt-get -y install mysql-server
apt-get -y install php libapache2-mod-php php-mysql
# write some HTML
echo \<center\>\<h1\>Testar om de funkar\</h1\>\<br/\>\</center\> > /var/www/html/test.html

# restart Apache
apachectl restart