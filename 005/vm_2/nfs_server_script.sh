#!/bin/bash
sudo su
#
yum -y install nfs-utils
systemctl enable nfs-server
systemctl start nfs-server
mkdir /nfs_share
chmod 0755 /nfs_share
chown root:root /nfs_share
echo 'Check read only permission for NFD-client.' | tee /nfs_share/README.txt
chown root:root /nfs_share/README.txt
mkdir /nfs_share/upload
chown -R nfsnobody:nfsnobody /nfs_share/upload
chmod 0755 -R /nfs_share/upload
echo '/nfs_share 192.168.50.11(rw,sync,root_squash,all_squash)' | tee /etc/exports.d/nfs_share.exports
exportfs -a
systemctl restart nfs-server
#
yum -y install firewalld
systemctl enable firewalld
systemctl start firewalld
firewall-cmd --permanent --add-port=111/udp
firewall-cmd --permanent --add-port=2049/udp
firewall-cmd --permanent --zone=public --add-service=nfs
firewall-cmd --permanent --zone=public --add-service=mountd
firewall-cmd --reload
systemctl restart firewalld
#
exit 0