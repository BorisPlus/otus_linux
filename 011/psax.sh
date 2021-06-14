#!/bin/bash

_pid(){
  echo "${PROC_PID/\/proc\//}"
}

_stat(){
  if [ -f ${PROC_PID}/stat ]; then
    cat ${PROC_PID}/stat | rev | awk '{printf $50}' | rev
  else
    echo 'n/a'
  fi
}

_tty(){
  if [ -f ${PROC_PID}/stat ]; then
    B=`cat ${PROC_PID}/stat | rev | awk '{printf $46}' | rev`;
    C=`bc <<< "obase=2;$B"`;
    #echo C=$C;
    D=`echo $C | rev`
    #echo D=$D;
    minor=${D:0:2}${D:4:3}
    major=${D:3:2}
    minor=`echo $minor | rev`
    major=`echo $major | rev`
    E=`echo $major$minor`
    #echo $E;
    F=`bc <<< "obase=10;ibase=2;$E"`;
    if [ $F = "0" ]; then
      echo '?';
    else
      echo tty$F;
    fi
  else
    echo 'n/a'
  fi
}

#_tty_raw(){
#  if [ -f ${PROC_PID}/stat ]; then
#    cat ${PROC_PID}/stat | rev | awk '{printf $46}' | rev;
#  else
#    echo 'n/a'
#  fi
#}

_time(){
  if [ -f ${PROC_PID}/stat ]; then
    cat ${PROC_PID}/stat | rev | awk '{print $36" "$37" "$38" "$39}' | rev | awk '{sum=$1+$2+$3+$4}END{print sum/100}' | awk '{("date +%M:%S -d @"$1)| getline $1}1'
  else
    echo 'n/a'
  fi
}

_command(){
  if [ -f ${PROC_PID}/stat ]; then
  # предупреждение: подстановка команды: во входных данных проигнорирован нулевой байт
    cat ${PROC_PID}/cmdline | tr '\0' '\n' | sed -e s/DBUS_SESSION_BUS_ADDRESS=//
  else
    echo 'n/a'
  fi
}

for PROC_PID in `ls -d /proc/* | egrep "^/proc/[0-9]+"`; do
  echo $(_pid) $(_tty) $(_stat) $(_time) $(_command);
done

# for test
# PROC_PID=/proc/26446
# echo $(_tty_raw)
# echo $(_tty)