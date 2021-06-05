#!/bin/sh
USAGE="SYNOPSIS: file-grep.sh FILE QUERY"
if [ -z "$1" ]
then
echo "Sorry, there is no first parameter FILE. "
echo $USAGE
exit 1
fi

if [ -z "$2" ]
then
echo "Sorry, there is no second parameter QUERY."
echo $USAGE
exit 1
fi

file_grep() {
    local FILE=${1}
    local QUERY=${2}
    #echo "Result of grep file '${FILE}' for query '${QUERY}'"
    grep -rHn "${QUERY}" "${FILE}"
    exit 0
}
#echo "Result of grep file '${1}' for query '${2}'"
file_grep ${1} "${2}"
exit 0
