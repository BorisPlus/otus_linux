#!/bin/sh
USAGE="SYNOPSIS: path_contents_change_audit.sh AUDIT_PATH"
if [ -z "$1" ]
then
echo "Sorry, there is no the first parameter AUDIT_PATH. "
echo $USAGE
exit 1
fi

# Для отладки DEBUG=true
DEBUG=false

# Log-файл аудита
AUDIT_LOG={{ path_contents_change_audit_logfile_path }}/{{ path_contents_change_audit_logfile_name }}

# Функция добавляет новые файлы для аудита
add() {
  local AUDIT_PATH="${1}"
  local COMMAND="git -C ${AUDIT_PATH} add ."
  if [ $DEBUG = true ]; then
    echo ADD_COMMAND: ${COMMAND}
  fi
  `$COMMAND`
}

# Функция сверки версии директории на диске
# с ее образом в git-репозитории
DIFF_MSG=''
DIFF_CODE=''
diff() {
  local AUDIT_PATH=${1}
  local COMMAND="git -C ${AUDIT_PATH} diff HEAD"
  if [ $DEBUG = true ]; then
     echo DIFF_COMMAND: ${COMMAND}
  fi
  DIFF_MSG=`$COMMAND`
  if [ $DEBUG = true ]; then
     echo DIFF_MSG: ${DIFF_MSG}
  fi
  DIFF_CODE=$?
  if [ $DEBUG = true ]; then
     echo DIFF_CODE: ${DIFF_CODE}
  fi
}

# Функция фиксации результата аудита
COMMIT_MSG=''
COMMIT_CODE=''
commit() {
  local AUDIT_PATH="${1}"
  local DT=`date +"%Y-%m-%dT%H:%M:%S.%N"` # whithout T work only no local
  local COMMIT_NOTE="$DT"
  local COMMAND="git -C ${AUDIT_PATH} commit -m \"${COMMIT_NOTE}\""
  if [ $DEBUG = true ]; then
    echo COMMIT_COMMAND: ${COMMAND}
  fi
  COMMIT_MSG=$($COMMAND)
  if [ $DEBUG = true ]; then
    echo COMMIT_MSG: ${COMMIT_MSG}
  fi
  COMMIT_CODE=$?
  if [ $DEBUG = true ]; then
    echo COMMIT_CODE: ${COMMIT_CODE}
  fi
}

# Функция логгирования аудита
logging() {
    local AUDIT_PATH="${1}"
    local MSG="${2}"
    local LOG_ROW="$(date +"[%Y-%m-%d %H:%M:%S]") \"${AUDIT_PATH}\" ${MSG}"
    if [ $DEBUG = true ]; then
      echo ${LOG_ROW}
    fi
    echo ${LOG_ROW} >> ${AUDIT_LOG}
}

# 0. с чем работаем
AUDIT_PATH="${1}"
# 1. добавляем
add "${AUDIT_PATH}"
# 2. сверяем
diff "${AUDIT_PATH}"
if [ $DEBUG = true ]; then
  echo DIFF_MSG: ${DIFF_MSG}
  echo DIFF_CODE: ${DIFF_CODE}
fi
# 3. коммитим
commit "${AUDIT_PATH}"
if [ $DEBUG = true ]; then
  echo COMMIT_MSG: ${COMMIT_MSG}
  echo COMMIT_CODE: ${COMMIT_CODE}
fi
# 4. логгируем
if [ ${COMMIT_CODE} -eq 0 ] && [ ! -z "${DIFF_MSG}" ];
then
  logging "${AUDIT_PATH}" "${DIFF_MSG}"
fi
# 5. пушим
# пока не надо
