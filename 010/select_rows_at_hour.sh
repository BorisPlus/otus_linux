#!/bin/sh
. ./at_hour.sh

AT_HOUR=$(hour)

DEBUG=0
if [ "${DEBUG}" = "1" ]
then
  echo SELECT LOG-DATA AT HOUR $AT_HOUR
fi

select_rows_at_hour() {
    _LOG_FILE=${LOG_FILE}
    _AT_HOUR=${AT_HOUR}
    cat "${_LOG_FILE}" | grep "\[$_AT_HOUR:"
    exit 0
}
