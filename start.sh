#!/bin/sh

export XDG_RUNTIME_DIR=/home/sway/tempdir
export MESA_LOADER_DRIVER_OVERRIDE=crocus
export MESA_LOADER_DRIVER_OVERRIDE=iris

sudo rc-status

sudo setup-udev && echo OK || echo Failed
sudo rc-service seatd start && echo OK || echo Failed
sudo rc-service dbus start && echo OK || echo Failed

#dbus-run-session -- sway && echo OK || echo Failed
tail -f /dev/null
