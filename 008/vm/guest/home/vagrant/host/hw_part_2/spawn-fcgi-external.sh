#! /bin/sh
# https://oleg.blog/2012-02-29-init-skript-dlya-spawn-fcgi.html
# spawn-fcgi Startup script for the nginx HTTP Server
#
# chkconfig: - 84 15
# description: Loading php-cgi using spawn-cgi
# HTML files and CGI.
#
### BEGIN INIT INFO
# Provides: spawn-fcgi
# Required-Start: $all
# Required-Stop: $all
# Default-Start: 2 3 4 5
# Default-Stop: 0 1 6
# Short-Description: Start and stop php-cgi using spawn-fcgi
# Description: Start and stop php-cgi using spawn-fcgi
### END INIT INFO
# Author: Ryan Norbauer
# Modified: Geoffrey Grosenbach http://topfunky.com
# Modified: David Krmpotic http://davidhq.com
# Modified: Kun Xi http://kunxi.org
# Modified: http://drumcoder.co.uk/
# Modified: http://olezhek.net/
SCRIPTNAME=$(basename $0)
DAEMON=/usr/bin/spawn-fcgi
FCGIHOST=127.0.0.1
FCGIPORT=9001
FCGIUSER=www-data
FCGIGROUP=www-data
FCGIAPP=/usr/bin/php-cgi
FCGICHILDREN=5
#PIDFILE=/var/run/$SCRIPTNAME.pid
PIDFILE=/var/run/128500.pid
DESC="Spawn-FCGI"
# You can change settings for this script by editing /etc/default/$SCRIPTNAME
[ -r /etc/default/$SCRIPTNAME ] && . /etc/default/$SCRIPTNAME
# Gracefully exit if the package has been removed.
test -x $DAEMON || echo -en "$DAEMON not found\n"
test -x $DAEMON || exit 1
test -x $FCGIAPP || echo -en "$FCGIAPP not found\n"
test -x $FCGIAPP || exit 1
start() {
  $DAEMON -a $FCGIHOST -p $FCGIPORT -u $FCGIUSER -g $FCGIGROUP -f $FCGIAPP -P $PIDFILE -C $FCGICHILDREN 2> /dev/null || echo -en "\n already running\n"
  # $DAEMON -a $FCGIHOST -p $FCGIPORT -u $FCGIUSER -g $FCGIGROUP -P $PIDFILE -C $FCGICHILDREN -- $FCGIAPP 2>/dev/null || echo -en "\n already running\n"
}
stop() {
  kill `cat $PIDFILE` || echo -en "\n not running"
}
restart() {
  kill -HUP `cat $PIDFILE` || echo -en "\n can't reload"
}
case "$1" in
  start)
    echo -n "Starting $DESC: "
    start
    ;;
  stop)
    echo -n "Stopping $DESC: "
    stop
    ;;
  restart|reload)
    echo -n "Restarting $DESC: "
    stop
    # One second might not be time enough for a daemon to stop,
    # if this happens, d_start will fail (and dpkg will break if
    # the package is being upgraded). Change the timeout if needed
    # be, or change d_stop to have start-stop-daemon use --retry.
    # Notice that using --retry slows down the shutdown process somewhat.
    sleep 1
    start
    ;;
  *)
    echo "Usage: $SCRIPTNAME {start|stop|restart|reload}" >&2
    exit 3
  ;;
esac
exit $?