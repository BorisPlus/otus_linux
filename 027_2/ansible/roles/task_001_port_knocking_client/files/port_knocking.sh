#!/bin/bash
# ./port_knocking.sh  192.168.255.1 8881 7777 9991 && ssh 192.168.0.1

# Проверка на переданный параметр
USAGE="SYNOPSIS: ./port_knocking.sh <TARGET_IP> <port_1> [<port_2> <port_3> ...]"
if [ -z "$1" ]
then
    echo "Sorry, there is no first parameter TARGET_IP. "
    echo $USAGE
    exit 1
fi

if [ -z "$2" ]
then
    echo "Sorry, some knock-port id needed. "
    echo $USAGE
    exit 1
fi

TARGET_IP=$1
shift
for ARG in "$@"
do
  sudo nmap -Pn --max-retries 0 -p $ARG $TARGET_IP # !! SUDO - MUST BE
#  sudo ssh -o ConnectTimeout=1 $TARGET_IP -p $ARG
done