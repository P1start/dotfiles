#!/usr/bin/env sh

# Terminate already running bar instances
killall -q -9 polybar

# Wait until the processes have been shut down
#while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch bar
polybar main &

echo "Bar(s) launched..."
