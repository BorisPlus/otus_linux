#!/bin/sh
# file: fetch_urn.usage.sh
# usage: ./fetch_urn.usage.sh ./access-4560-644067.log > ./fetch_urn.usage.sh.log
. ./select_rows_at_hour.sh
. ./fetch_urn.sh

# Проверка на переданный параметр
USAGE="SYNOPSIS: filter_for_uri.usage.sh LOG_FILE"
if [ -z "$1" ]
then
    echo "Sorry, there is no first parameter LOG_FILE. "
    echo $USAGE
    exit 1
fi

LOG_FILE="${1}"

echo 'FILTER FOR UNIFORM RESOURCE NAME:'
select_rows_at_hour | fetch_urn

exit 0