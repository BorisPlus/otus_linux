#!/bin/sh
#!/bin/sh
# file: group_by_with_sort_http_code.sh
# usage: ./group_by_with_sort_http_code.sh ./access-4560-644067.log > ./group_by_with_sort_http_code.sh.log
. ./select_rows_at_hour.sh
. ./fetch_http_code.sh
. ./group_by_with_sort.sh

# Проверка на переданный параметр
USAGE="SYNOPSIS: group_by_http_code.sh LOG_FILE"
if [ -z "$1" ]
then
    echo "Sorry, there is no first parameter LOG_FILE."
    echo $USAGE
    exit 1
fi

LOG_FILE="${1}"

echo "GET DATA OF HOUR" $AT_HOUR "OF LOG-FILE" $LOG_FILE
echo CALCULATE COUNT OF HTTP-STATUS CODES
select_rows_at_hour | fetch_http_code | group_by_with_sort

exit 0