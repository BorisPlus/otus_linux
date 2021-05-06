#!/bin/bash

# Install elrepo
yum install -y http://www.elrepo.org/elrepo-release-7.0-3.el7.elrepo.noarch.rpm
# Install new kernel
mkdir /kernel_sources
cd /kernel_sources
sudo yum install git fakeroot build-essential ncurses-dev xz-utils libssl-dev bc flex libelf-dev bison
tar xvf linux-5.9.6.tar.xz
sudo yum update
sudo yum clean dbcache
sudo yum clean metadata
sudo yum makecache
sudo yum install ncurses-devel libncurses-dev
sudo yum install centos-release-scl-rh
sudo sudo yum-config-manager --enable centos-sclo-rh-testing
sudo yum install devtoolset-8
scl enable devtoolset-8 bash
sudo make modules_install
sudo make install
# Remove older kernels (Only for demo! Not Production!)
rm -f /boot/*3.10*
# Update GRUB
grub2-mkconfig -o /boot/grub2/grub.cfg
grub2-set-default 0
echo "Grub update done."
# Reboot VM
shutdown -r now
