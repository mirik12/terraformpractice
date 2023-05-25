#!/bin/bash
sudo yum -y update
sudo yum -y install httpd
myip='curl http://169.254.169.254/latest/meta-data/local-ipv4'
echo "<h2>WebServer with IP: $myip</h2><br>Build By Terraform usind External Script!" > /var/www/html/index.html
echo "<br><font color="blue"> Hello Mirik" >> /var/www/html/index.html
sudo service httpd start
chkconfig httpd on