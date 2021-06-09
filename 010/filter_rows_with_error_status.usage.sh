#!/bin/sh
# file: filter_rows_with_error_status.usage.sh
# usage: ./filter_rows_with_error_status.usage.sh ./access-4560-644067.log
. ./filter_rows_with_error_status.sh

# Проверка на переданный параметр
USAGE="SYNOPSIS: filter_rows_with_error_status.usage.sh LOG_FILE"
if [ -z "$1" ]
then
  echo "Sorry, there is no first parameter LOG_FILE."
  echo $USAGE
  exit 1
fi

LOG_FILE="${1}"

# пример выборки записей c "ошибками" из ранее отфильтрованных
# по времени сведений из файла
. ./get_hour.sh
AT_HOUR=$(get_hour)
DEBUG=true
if $DEBUG
then
  echo "DATA AT HOUR" $AT_HOUR
fi
echo 'FILTER FOR NOT SUCCESS REQUESTS:'
get_data_at_hour | filter_rows_with_error_status

exit 0