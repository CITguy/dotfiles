#!/bin/bash

# This file is used for Linux systems

/usr/bin/logger -si -t LOADED "/home/ryan/.xinitrc"

# Needed for automagic opening of mimetypes
export DE=xfce
# Force openoffice to use GTK theme
#export OOO_FORCE_DESKTOP=gnome

export DESKTOP_SESSION=LXDE

[ -f ~/.xprofile ] && . ~/.xprofile

# Source scripts in /etc/X11/xinit/xinitrc.d/
if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

# Set cursor speed
xset m 4 &

# Once again, make sure capslock acts as Esc
setxkbmap -option caps:escape &

exec dbus-launch startlxde

# This was here when I got here.
# Slim < 1.3.3 requires ck-launch-session
#exec ck-launch-session dbus-launch openbox-session
