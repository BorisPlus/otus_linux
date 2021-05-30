#!/bin/bash
sudo su
# Part 1. log-monitor
ln -s /etc/systemd/vagrant/log-monitor.service /etc/systemd/system/log-monitor.service
ln -s /etc/systemd/vagrant/log-monitor.timer /etc/systemd/system/log-monitor.timer
systemclt enable log-monitor
systemclt start log_monitor
# Part 2. httpd
 ln -s /etc/systemd/vagrant/spawn-fcgi.service /etc/systemd/system/vagrant-spawn-fcgi.service
mkdir -p /etc/yum.repos.d/
curl -L https://download.opensuse.org/repositories/isv:perlur:epel/RHEL_7/isv:perlur:epel.repo --output /etc/yum.repos.d/epel.repo
# just for debug: ls /etc/yum.repos.d/epel.repo
yum -y install spawn-fcgi
# Part 3. httpd
yum -y install httpd
ln -s /etc/systemd/vagrant/httpd-pro@.service /etc/systemd/system/httpd-pro@.service
exit 0