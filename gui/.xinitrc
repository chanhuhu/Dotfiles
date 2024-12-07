#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# settings
setxkbmap -model pc105 -layout us,th -option grp:alt_shift_toggle,caps:ctrl_modifier &

# merge in defaults and keymaps
if [ -f $sysresources ]; then
    echo "running sysresources "
    xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    echo "running sysmodmap"
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    echo "running userresources"
    xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
    echo "running usermodmap"
    xmodmap "$usermodmap"
fi

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
   for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
    [ -x "$f" ] && . "$f"
   done
   unset f
fi

# running window manger
sxhkd &
exec bspwm
