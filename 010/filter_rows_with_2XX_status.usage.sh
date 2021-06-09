#!/bin/sh
# file: filter_rows_with_2XX_status.usage.sh
# usage: ./filter_rows_with_2XX_status.usage.sh ./access-4560-644067.log
. ./filter_rows_with_2XX_status.sh

# Проверка на переданный параметр
USAGE="SYNOPSIS: filter_2XX_status.test.sh FILE "
if [ -z "$1" ]
then
  echo "Sorry, there is no first parameter FILE. "
  echo $USAGE
  exit 1
fi

LOG_FILE="${1}"

# пример выборки 2XX записей из всего файла
echo "PROCESS ALL DATA"
cat  ${LOG_FILE}  | filter_rows_with_2XX_status

# пример выборки 2XX записей из ранее отфильтрованных
# по времени сведений из файла
. ./get_hour.sh
AT_HOUR=$(get_hour)
echo 'FILTER FOR SUCCESS REQUESTS:'
echo "PROCESS DATA AT HOUR $AT_HOUR"
get_data_at_hour | filter_rows_with_2XX_status

exit 0