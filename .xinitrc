#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

# Auto Login Gnome-Keyring
eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
export SSH_AUTH_SOCK

# Matlab fixes
export J2D_D3D=false
export MATLAB_JAVA=/usr/lib/jvm/java-8-openjdk/jre


# Autostart
dropbox &
(sleep 5; owncloud) &
nm-applet &
# volumeicon &

# change keymap for X
setxkbmap -layout us -variant altgr-intl -option 'nodeadkeys,caps:escape'

# start xautolock with custom i3lock
lock_screen.sh &

# Start Awesome_wm
exec awesome
