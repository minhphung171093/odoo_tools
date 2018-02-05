#!/bin/bash
# openoffice.org headless server script
#
# chkconfig: 2345 80 30
# description: headless openoffice server script
# processname: openoffice
#
# Author: Vic Vijayakumar
# Modified by Federico Ch. Tomasczik
#
### BEGIN INIT INFO
# Provides:             libroffice.sh
# Required-Start:       $remote_fs $syslog
# Required-Stop:        $remote_fs $syslog
# Should-Start:         $network
# Should-Stop:          $network
# Default-Start:        2 3 4 5
# Default-Stop:         0 1 6
# Short-Description:    Enterprise Resource Management software
# Description:          Open ERP is a complete ERP and CRM software.
### END INIT INFO

OOo_HOME=/usr/bin
SOFFICE_PATH=$OOo_HOME/libreoffice
PIDFILE=/var/run/libreoffice-server.pid
set -e
case "$1" in
start)
if [ -f $PIDFILE ]; then
echo "Libreoffice headless server has already started."
sleep 5
exit
fi
echo "Starting Libreoffice headless server"
$SOFFICE_PATH --headless --nologo --nofirststartwizard --accept="socket,host=0.0.0.0,port=8100;urp" &
> /dev/null 2>&1
touch $PIDFILE
;;
stop)
if [ -f $PIDFILE ]; then
echo "Stopping Libreoffice headless server."
killall -9 libreoffice && killall -9 libreoffice.bin
rm -f $PIDFILE
exit
fi
echo "Libreoffice headless server is not running."
exit
Search
;;
*)
echo "Usage: $0 {start|stop}"
exit 1
esac
exit 0

