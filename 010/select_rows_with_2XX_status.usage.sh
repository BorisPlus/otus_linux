#!/bin/sh
# file: select_rows_with_2XX_status.usage.sh
# usage: ./select_rows_with_2XX_status.usage.sh ./access-4560-644067.log > ./select_rows_with_2XX_status.usage.sh.log
. ./select_rows_at_hour.sh
. ./select_rows_with_2XX_status.sh

# Проверка на переданный параметр
USAGE="SYNOPSIS: filter_2XX_status.test.sh LOG_FILE"
if [ -z "$1" ]
then
  echo "Sorry, there is no first parameter LOG_FILE."
  echo $USAGE
  exit 1
fi

LOG_FILE="${1}"

# пример выборки 2XX записей из всего файла
echo 'SELECT FOR SUCCESS REQUESTS:'
echo ''
echo "PROCESS ALL DATA"
cat  ${LOG_FILE}  | select_rows_with_2XX_status

echo "PROCESS DATA OF HOUR $AT_HOUR" "OF LOG-FILE" $LOG_FILE
select_rows_at_hour | select_rows_with_2XX_status

exit 0