#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

xset +fp /usr/share/fonts/local
xset fp rehash
xset -b

xrdb -merge .Xresources


# Keyboard
# setxkbmap -model pc105+inet -layout us,de,rs -option grp:alt_shift_toggle
setxkbmap -model pc105+inet -layout us,de,rs,rs -variant ,,,latin -option grp:alt_shift_toggle


# # Network location
# source $HOME/bin/location

#
## Dual display mode check
#
# xrandr --output VGA1 --auto --primary --output LVDS1 --auto --left-of VGA1
#
# in='LVDS1'
in="`xrandr --listmonitors | grep 0:|sed -e 's/^ *0:.* \(\w\+\)$/\1/g'`"
mon_total=`xrandr|grep '[^s]connected'|wc -l`
ext=`xrandr|grep '[^s]connected'|cut -d ' ' -f 1|grep -v $in`

if [ $mon_total -gt 1 ]
then
	xrandr --output $ext --auto --primary --output $in --left-of $ext

# 	for ext in `xrandr|grep '[^s]connected'|cut -d ' ' -f 1|grep -v $in`
# 	do
# 		echo $ext
# 	done


else
	xrandr --output $in --auto --primary
fi
## end of dual display setup

## X11 bindings (mouse)
xbindkeys

# # exec gnome-session
# # exec startkde
# # exec startxfce4
# # ...or the Window Manager of your choice
# 
# # Awesome window manager
# # exec awesome 1>~/.cache/awesome/stdout 2>~/.cache/awesome/stderr
exec i3
# 

# exec $1
