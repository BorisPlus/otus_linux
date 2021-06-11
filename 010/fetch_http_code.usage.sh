#!/bin/sh
# file: fetch_http_code.usage.sh
# usage: ./fetch_http_code.usage.sh ./access-4560-644067.log > ./fetch_http_code.usage.sh.log
# cat ./fetch_http_code.usage.sh.log
. ./select_rows_at_hour.sh
. ./fetch_http_code.sh

# Проверка на переданный параметр
USAGE="SYNOPSIS: fetch_http_code.usage.sh LOG_FILE"
if [ -z "$1" ]
then
    echo "Sorry, there is no first parameter LOG_FILE. "
    echo $USAGE
    exit 1
fi

LOG_FILE="${1}"

echo "GET DATA OF HOUR" $AT_HOUR "OF LOG-FILE" $LOG_FILE
echo 'FETCHED HTTP-CODES:'
select_rows_at_hour | fetch_http_code

exit 0