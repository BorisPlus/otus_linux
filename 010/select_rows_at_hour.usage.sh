#!/bin/sh
# file: select_rows_at_hour.usage.sh
# usage: ./select_rows_at_hour.usage.sh ./access-4560-644067.log > ./select_rows_at_hour.usage.sh.log
. ./select_rows_at_hour.sh

# Проверка на переданный параметр
USAGE="SYNOPSIS: select_rows_at_hour.usage.sh LOG_FILE"
if [ -z "$1" ]
then
  echo "Sorry, there is no first parameter LOG_FILE."
  echo $USAGE
  exit 1
fi

LOG_FILE="${1}"

DEBUG=0
if [ "${DEBUG}" = "1" ]
then
  echo USE LOG FILE $LOG_FILE
fi
# выведет на экран отфильтрованное
# по сформированной дате $AT_HOUR
# содержимое файла LOG_FILE
# Запуск: ./select_rows_at_hour.sh ./access-4560-644067.log
echo "GET DATA OF HOUR" $AT_HOUR "OF LOG-FILE" $LOG_FILE
select_rows_at_hour
exit 0
