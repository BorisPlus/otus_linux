#!/bin/sh
# file: top_limit_of_group_by_with_sort_fetched_urn.sh
# usage: ./top_limit_of_group_by_with_sort_fetched_urn.sh ./access-4560-644067.log 3 > ./top_limit_of_group_by_with_sort_fetched_urn.sh.log
. ./select_rows_at_hour.sh
. ./fetch_urn.sh
. ./group_by_with_sort.sh
. ./top_limit.sh

# Проверка на переданный параметр
USAGE="SYNOPSIS: top_limit_of_group_by_with_sort_fetched_urn.sh LOG_FILE TOP_LIMIT"
if [ -z "$1" ]
then
    echo "Sorry, there is no first parameter LOG_FILE. "
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
echo TOP ${TOP_LIMIT}-COUNT IP-ADDRESSES TARGETS
select_rows_at_hour | fetch_urn | group_by_with_sort | top_limit

exit 0