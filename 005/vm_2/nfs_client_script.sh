#!/bin/bash
sudo su
yum install -y nfs-utils
mkdir /mnt/nfs_share
echo -e '\n[Unit]' \
        '\nDescription="NFS share automount"' \
        '\nRequires=network-online.target' \
        '\nAfter=network-online.service' \
        '\n[Mount]' \
        '\nWhat=192.168.50.10:/nfs_share/' \
        '\nWhere=mnt-nfs_share' \
        '\nType=nfs' \
        '\nDirectoryMode=0755' \
        '\nOptions=rw,noatime,noauto,x-systemd.automount,noexec,nosuid,proto=udp,vers=3' \
        '\n[Install]' \
        '\nWantedBy=multi-user.target' \
        '\n' | tee /etc/systemd/system/mnt-nfs_share.mount
echo -e '\n[Unit]' \
        '\nDescription="NFS share mount"' \
        '\nRequires=network-online.target' \
        '\nAfter=network-online.service' \
        '\n[Automount]' \
        '\nWhere=/mnt/nfs_share' \
        '\nTimeoutIdleSec=10' \
        '\n[Install]' \
        '\nWantedBy=multi-user.target' \
        '\n' | tee /etc/systemd/system/mnt-nfs_share.automount
systemctl enable mnt-nfs_share.automount
systemctl start mnt-nfs_share.automount
exit 0
