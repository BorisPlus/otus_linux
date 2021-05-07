#!/bin/bash
sudo mdadm --zero-superblock --force /dev/sd{f,g,h,i,j}
sudo mdadm --create --verbose /dev/md0 -l 5 -n 5 /dev/sd{f,g,h,i,j}
sudo mkdir /etc/mdadm
echo "DEVICE partitions" | sudo tee /etc/mdadm/mdadm.conf
sudo mdadm --detail --scan --verbose | awk '/ARRAY/ {print}' | sudo tee -a /etc/mdadm/mdadm.conf
sudo parted -s /dev/md0 mklabel gpt
sudo parted /dev/md0 mkpart primary ext4 2048KiB 20%
sudo parted /dev/md0 mkpart primary ext4 20% 100%
for i in $(seq 1 2); do sudo mkfs.ext4 /dev/md0p$i; done
sudo mkdir -p /raid/part{1,2}
for i in $(seq 1 2); do sudo mount /dev/md0p$i /raid/part$i; done
echo '/dev/md0p1 /raid/part1 ext4    defaults    1 2' | sudo tee -a /etc/fstab
echo '/dev/md0p2 /raid/part2 ext4    defaults    1 2' | sudo tee -a /etc/fstab
cat /proc/mdstat