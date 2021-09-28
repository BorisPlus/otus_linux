#!/bin/bash

exec 0<>/dev/console 1<>/dev/console 2<>/dev/console
cat <<'msgend'

Hello, OTUS!

msgend
sleep 10
echo " continuing...."