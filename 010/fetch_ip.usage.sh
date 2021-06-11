#!/bin/sh
# file: fetch_ip.usage.sh
# usage: ./fetch_ip.usage.sh ./access-4560-644067.log > ./fetch_ip.usage.sh.log
. ./select_rows_at_hour.sh
. ./fetch_ip.sh

# Проверка на переданный параметр
USAGE="SYNOPSIS: filter_for_ip.usage.sh LOG_FILE"
if [ -z "$1" ]
then
    echo "Sorry, there is no first parameter LOG_FILE. "
    echo $USAGE
    exit 1
fi

LOG_FILE="${1}"

echo "GET DATA OF HOUR" $AT_HOUR "OF LOG-FILE" $LOG_FILE
echo 'FETCHED IP-ADDRESSES:'
select_rows_at_hour | fetch_ip

exit 0