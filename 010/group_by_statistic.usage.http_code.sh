#!/bin/sh
#!/bin/sh
# file: group_by_statistic.usage.http_code.sh
# usage: ./group_by_statistic.usage.http_code.sh ./access-4560-644067.log
. ./group_by_statistic.sh
. ./filter_for_http_code.sh

# Проверка на переданный параметр
USAGE="SYNOPSIS: top_statistic.usage.http_code.sh LOG_FILE"
if [ -z "$1" ]
then
    echo "Sorry, there is no first parameter LOG_FILE."
    echo $USAGE
    exit 1
fi

LOG_FILE="${1}"

. ./get_hour.sh
AT_HOUR=$(get_hour)
DEBUG=true
if $DEBUG
then
  echo "GET DATA OF HOUR" $AT_HOUR
fi
echo CALCULATE COUNT OF HTTP-STATUS CODES
get_data_at_hour | filter_for_http_code | group_by_statistic

exit 0