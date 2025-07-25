#!/bin/sh

# Start the USB automanting daemon
udiskie &

# Notification daemon
dunst &

# Eye-saver utility
redshift -P -O 2750 &

# Transparency utility
picom --backend glx -b

# Set wallpaper
# feh --no-fehbg --bg-fill --randomize ~/Media/Images/Walls/"Current Walls"/*
# Top bar utility
export PATH=$PATH:~/.dotfiles/voidrice/.local/bin/statusbar:~/Apps/suckless/dwmblocks/dwmblocks-alp/scripts/
# dwmblocks &
# polybar &

# Lock screen utility
xss-lock -- xsecurelock &

# Sync mailbox
# mailsync &

# Reverse mouse scrolling
xinput set-button-map 14 1 2 3 5 4 6 7

# Launch window manager
# exec window manager
exec awesome
