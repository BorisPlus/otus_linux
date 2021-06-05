#!/bin/bash
sudo su
# Part 1. log-monitor
ln -s /etc/systemd/vagrant/log-monitor.service /etc/systemd/system/log-monitor.service
ln -s /etc/systemd/vagrant/log-monitor.timer /etc/systemd/system/log-monitor.timer
systemclt enable log-monitor
systemclt start log_monitor
# Part 2. httpd
ln -s /etc/systemd/vagrant/spawn-fcgi.service /etc/systemd/system/vagrant-spawn-fcgi.service
yum install -y epel-release
yum install -y spawn-fcgi
sudo yum -y install php
sudo cat /etc/sysconfig/spawn-fcgi
sed -i 's@#SOCKET=@SOCKET=@g' /etc/sysconfig/spawn-fcgi
sed -i 's@#OPTIONS=@OPTIONS=@g' /etc/sysconfig/spawn-fcgi
# Part 3. httpd
yum -y install httpd
#ln -s /etc/systemd/vagrant/spawn-fcgi.service /etc/systemd/system/vagrant-spawn-fcgi.service
#ln -s /etc/systemd/vagrant/httpd-pro@.service /etc/systemd/system/httpd-pro@.service
#ln -s /etc/systemd/vagrant/httpd-pro@.service /etc/systemd/system/httpd-pro@.service

#sed -i 's@\[Install\]@PIDFile=/run/httpd/%i.pid\n\n[Install]@g' /etc/systemd/system/httpd@.service

yes | cp -f --preserv /usr/lib/systemd/system/httpd.service /etc/systemd/system/httpd@.service
sed -i 's@EnvironmentFile=/etc/sysconfig/httpd@EnvironmentFile=/etc/sysconfig/%i@g' /etc/systemd/system/httpd@.service
# cat  /etc/systemd/system/httpd@.service | grep PIDFile

yes | cp -f --preserv /etc/sysconfig/httpd /etc/sysconfig/httpd8080
sed -i 's@#OPTIONS=@OPTIONS=-f /etc/httpd/conf/httpd8080.conf@g' /etc/sysconfig/httpd8080

yes | cp -f --preserv /etc/sysconfig/httpd /etc/sysconfig/httpd80
sed -i 's@#OPTIONS=@OPTIONS=-f /etc/httpd/conf/httpd80.conf@g' /etc/sysconfig/httpd80

yes | cp -f --preserv /etc/httpd/conf/httpd.conf /etc/httpd/conf/httpd8080.conf
sed -i 's@Listen 80@Listen 127.0.1.1:8080@g' /etc/httpd/conf/httpd8080.conf
sed -i 's@www/html@www/html8080@g' /etc/httpd/conf/httpd8080.conf
sed -i 's@ServerRoot "/etc/httpd"@PidFile "/run/httpd/httpd8080.pid"\nServerRoot "/etc/httpd"@g' /etc/httpd/conf/httpd8080.conf #
# cat /etc/httpd/conf/httpd8080.conf  | grep List
# cat /etc/httpd/conf/httpd8080.conf  | grep html8080
# cat /etc/httpd/conf/httpd8080.conf  | grep PidFile

yes | cp -f --preserv /etc/httpd/conf/httpd.conf /etc/httpd/conf/httpd80.conf
sed -i 's@Listen 80@Listen 127.0.1.1:80@g' /etc/httpd/conf/httpd80.conf
sed -i 's@www/html@www/html80@g' /etc/httpd/conf/httpd80.conf
sed -i 's@ServerRoot "/etc/httpd"@PidFile "/run/httpd/httpd80.pid"\nServerRoot "/etc/httpd"@g' /etc/httpd/conf/httpd80.conf #
# cat /etc/httpd/conf/httpd80.conf  | grep List
# cat /etc/httpd/conf/httpd80.conf  | grep html80
# cat /etc/httpd/conf/httpd80.conf  | grep PidFile

yes | cp -R -f --preserv /var/www/html/ /var/www/html80
echo '/var/www/html80/ dir on 80 port' > /var/www/html80/index.html
chcon -R -t httpd_sys_content_t /var/www/html80

yes | cp -R -f --preserv /var/www/html/ /var/www/html8080
echo '/var/www/html8080/ dir on 8080 port' > /var/www/html8080/index.html
chcon -R -t httpd_sys_content_t /var/www/html8080

exit 0