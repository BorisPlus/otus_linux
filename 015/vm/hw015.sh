#!/bin/bash
# sudo useradd -D
sudo useradd admin -m -p admin
sudo useradd moderator -g admin -p moderator
sudo useradd porter -g admin -p porter
sudo useradd user001 -p user001
sudo useradd user002 -p user002
sudo useradd user003 -p user003
#
sed -i 's@pam_nologin.so@pam_nologin.so\naccount    required     pam_time.so@g' /etc/pam.d/sshd
#
exit 0