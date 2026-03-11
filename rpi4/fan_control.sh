#! /bin/sh

### BEGIN INIT INFO
# Provides:          fan_control.py
# Required-Start:    $remote_fs $syslog
# Required-Stop:     $remote_fs $syslog
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
### END INIT INFO

# Setup: see docs/fan-control.md
case "$1" in
  start)
    echo "Starting fan_control.py"
    /path/to/homelab/fan_control.py &
    ;;
  stop)
    echo "Stopping fancontrol.py"
    pkill -f /path/to/homelab/fan_control.py
    ;;
  *)
    echo "Usage: /etc/init.d/fan_control.sh {start|stop}"
    exit 1
    ;;
esac

exit 0

