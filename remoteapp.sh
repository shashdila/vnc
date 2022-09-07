#!/bin/sh
vncserver :1 -geometry 1920x1080
filebrowser -p 8080 -a $(ip route get 8.8.8.8 | sed -n '/src/{s/.*src *\([^ ]*\).*/\1/p;q}') -r /root/Downloads/
