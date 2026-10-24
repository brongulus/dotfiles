#!/bin/sh

host="$(hostname)"
os='Void Linux'
kernel="$(uname -sr)"
uptime="$(uptime -p | sed 's/up //')"
packages="$(xbps-query -l | wc -l)"
shell='fish' #"$(basename "${SHELL}")"

cat <<EOF

     ~--        ${USER}@${host}
 /       \          
|    0    |     wm: i3
 \       /      pk: ${packages}
   --~          sh: ${shell}

EOF
