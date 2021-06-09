#!/bin/sh
# file: top_of_group_by_statistic.usage.ip.sh
# usage: ./top_of_group_by_statistic.usage.ip.sh ./access-4560-644067.log 10
. ./filter_for_ip.sh
. ./group_by_statistic.sh
. ./top_statistic.sh

# Проверка на переданный параметр
USAGE="SYNOPSIS: top_statistic.ip.usage.sh LOG_FILE TOP"
if [ -z "$1" ]
then
    echo "Sorry, there is no first parameter LOG_FILE. "
    echo $USAGE
    exit 1
fi

if [ -z "$2" ]
then
    echo "Sorry, there is no second parameter TOP."
    echo $USAGE
    exit 1
fi

LOG_FILE="${1}"
TOP=${2}

. ./get_hour.sh
AT_HOUR=$(get_hour)
DEBUG=true
if $DEBUG
then
  echo "GET DATA OF HOUR" $AT_HOUR
fi
echo TOP ${TOP}-COUNT IP-ADDRESSES
get_data_at_hour | filter_for_ip | group_by_statistic | top_statistic

exit 0