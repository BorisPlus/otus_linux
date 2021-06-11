#!/bin/sh
# file: top_limit_of_group_by_with_sort_error_rows_http_codes.sh
# usage: ./top_limit_of_group_by_with_sort_error_rows_http_codes.sh ./access-4560-644067.log 2 > ./top_limit_of_group_by_with_sort_error_rows_http_codes.sh.log
# usage: ./top_limit_of_group_by_with_sort_error_rows_http_codes.sh ./access-4560-644067.log 1 >> ./top_limit_of_group_by_with_sort_error_rows_http_codes.sh.log

. ./select_rows_at_hour.sh
. ./select_rows_with_error_status.sh
. ./fetch_http_code.sh
. ./group_by_with_sort.sh
. ./top_limit.sh

# Проверка на переданный параметр
USAGE="SYNOPSIS: top_limit_of_group_by_error_rows_http_codes.error_rows.sh LOG_FILE TOP_LIMIT"
if [ -z "$1" ]
then
  echo "Sorry, there is no first parameter LOG_FILE."
  echo $USAGE
  exit 1
fi

if [ -z "$2" ]
then
    echo "Sorry, there is no second parameter TOP_LIMIT."
    echo $USAGE
    exit 1
fi

LOG_FILE="${1}"
TOP_LIMIT=${2}

echo "PROCESS DATA OF HOUR $AT_HOUR" "OF LOG-FILE" $LOG_FILE
echo "TOP LIMIT OF" $TOP_LIMIT
echo 'NOT "SUCCESS" REQUESTS:'
select_rows_at_hour | select_rows_with_error_status | fetch_http_code | group_by_with_sort | top_limit

exit 0