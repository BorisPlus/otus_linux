#!/bin/sh
# file: get_hour.usage.sh
# usage: ./get_hour.usage.sh ./access-4560-644067.log
. ./get_hour.sh

DEBUG=true
# Проверка на переданный параметр
USAGE="SYNOPSIS: get_hour.test.sh LOG_FILE"
if [ -z "$1" ]
then
echo "Sorry, there is no first parameter LOG_FILE."
echo $USAGE
exit 1
fi

AT_HOUR=$(get_hour)
if $DEBUG
then
  echo SET AT HOUR AS $AT_HOUR
fi

LOG_FILE="${1}"
if $DEBUG
then
  echo USE LOG FILE $LOG_FILE
fi
# выведет на экран отфильтрованное
# по сформированной дате $AT_HOUR
# содержимое файла LOG_FILE
# Запуск: ./last_hour_test.sh ./access-4560-644067.log
get_data_at_hour
exit 0
