#!/bin/bash

sudo su
yum install -y \
    redhat-lsb-core \
    wget \
    rpmdevtools \
    rpm-build \
    createrepo \
    yum-utils \
    gcc

wget https://nginx.org/packages/centos/7/SRPMS/nginx-1.14.1-1.el7_4.ngx.src.rpm
rpm -i nginx-1.14.1-1.el7_4.ngx.src.rpm
yes | yum-builddep /root/rpmbuild/SPECS/nginx.spec

wget https://www.openssl.org/source/openssl-1.1.1k.tar.gz -O /root/openssl-1.1.1k.tar.gz
mkdir /root/openssl-1.1.1k
tar -xvf /root/openssl-1.1.1k.tar.gz -C /root

sed -i 's@index.htm;@index.htm;\n        autoindex on;@g' /root/rpmbuild/SOURCES/nginx.vh.default.conf
sed -i 's@--with-ld-opt="%{WITH_LD_OPT}" @--with-ld-opt="%{WITH_LD_OPT}" \\\n    --with-openssl=/root/openssl-1.1.1k @g' /root/rpmbuild/SPECS/nginx.spec

rpmbuild -bb /root/rpmbuild/SPECS/nginx.spec

yum localinstall -y /root/rpmbuild/RPMS/x86_64/nginx-1.14.1-1.el7_4.ngx.x86_64.rpm

systemctl enable nginx
systemctl start nginx

mkdir -p /usr/share/nginx/html/repo
mv /root/rpmbuild/RPMS/x86_64/nginx-1.14.1-1.el7_4.ngx.x86_64.rpm /usr/share/nginx/html/repo/
wget https://downloads.percona.com/downloads/percona-release/percona-release-1.0-6/redhat/percona-release-1.0-6.noarch.rpm -O /usr/share/nginx/html/repo/percona-release-0.1-6.noarch.rpm

createrepo /usr/share/nginx/html/repo/

yes | rm -r /home/vagrant/nginx-1.14.1-1.el7_4.ngx.src.rpm
