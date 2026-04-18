export __NV_PRIME_RENDER_OFFLOAD=1
export __GLX_VENDOR_LIBRARY_NAME=nvidia

export XCURSOR_THEME=kasane-teto-cursors
export XCURSOR_SIZE=24
xrdb -merge ~/.Xresources

xrandr --setprovideroutputsource modesetting NVIDIA-0 
xrandr --auto

exec start-dwm-session
