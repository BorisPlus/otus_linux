#!/bin/sh
USAGE="SYNOPSIS: file_change_audit.sh FILE"
if [ -z "$1" ]
then
echo "Sorry, there is no first parameter FILE. "
echo $USAGE
exit 1
fi
LOGFILE="/var/log/file_change_audit.log"
hash() {
    local FILE="${1}"
    echo `md5sum ${1}` | awk '{print $1}'
}
logging() {
    local FILE="${1}"
    local HASH="${2}"
    echo $(date +"[%Y-%m-%d %H:%M:%S]") ${HASH} ${FILE} >> ${LOGFILE}
}
control_hash=''
while true
do
  FILE="${1}"
  current_hash=`hash ${FILE}`
  # echo ${current_hash}
  if [ "$current_hash" != "$control_hash" ]
  then
    # echo 'control_hash before', ${control_hash}
    control_hash=$current_hash
    # echo 'control_hash after', ${control_hash}
    # echo 'current_hash', ${current_hash}
    logging ${1} ${current_hash}
  fi
  sleep 5
done
