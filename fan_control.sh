#! /bin/sh

### BEGIN INIT INFO
# Provides:          fan_control.py
# Required-Start:    $remote_fs $syslog
# Required-Stop:     $remote_fs $syslog
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
### END INIT INFO

# 1. Change /path/to/ below to match path of fan_control.py
# 2. Put script in /etc/init.d as /etc/init.d/fan_control.sh
# 3. You can start it with /etc/init.d/fan_control start
# Carry out specific functions when asked to by the system
case "$1" in
  start)
    echo "Starting fan_control.py"
    /path/to/fan_control.py &
    ;;
  stop)
    echo "Stopping fancontrol.py"
    pkill -f /path/to/fan_control.py
    ;;
  *)
    echo "Usage: /etc/init.d/fan_control.sh {start|stop}"
    exit 1
    ;;
esac

exit 0

