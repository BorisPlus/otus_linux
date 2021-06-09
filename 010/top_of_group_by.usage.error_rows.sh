#!/bin/sh
# file: top_of_group_by.usage.error_rows.sh
# usage: ./top_of_group_by.usage.error_rows.sh ./access-4560-644067.log 2
. ./filter_rows_with_error_status.sh
. ./filter_for_http_code.sh
. ./group_by_statistic.sh
. ./top_statistic.sh

# Проверка на переданный параметр
USAGE="SYNOPSIS: top_of_group_by.usage.error_rows.sh LOG_FILE TOP"
if [ -z "$1" ]
then
  echo "Sorry, there is no first parameter LOG_FILE."
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
get_data_at_hour | filter_rows_with_error_status | filter_for_http_code | group_by_statistic | top_statistic

exit 0