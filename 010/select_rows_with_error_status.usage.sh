#!/bin/sh
# file: select_rows_with_error_status.usage.sh
# usage: ./select_rows_with_error_status.usage.sh ./access-4560-644067.log > ./select_rows_with_error_status.usage.sh.log
. ./select_rows_at_hour.sh
. ./select_rows_with_error_status.sh

# Проверка на переданный параметр
USAGE="SYNOPSIS: filter_rows_with_error_status.usage.sh LOG_FILE"
if [ -z "$1" ]
then
  echo "Sorry, there is no first parameter LOG_FILE."
  echo $USAGE
  exit 1
fi

LOG_FILE="${1}"

echo "PROCESS DATA OF HOUR $AT_HOUR" "OF LOG-FILE" $LOG_FILE
echo 'SELECT "UNSUCCESS" REQUESTS:'
select_rows_at_hour | select_rows_with_error_status

exit 0