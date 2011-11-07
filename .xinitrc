#!/bin/bash

# Needed for automagic opening of mimetypes
export DE=xfce
# Force openoffice to use GTK theme
export OOO_FORCE_DESKTOP=gnome

# This was here when I got here.
exec ck-launch-session dbus-launch openbox-session
