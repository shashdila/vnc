#!/bin/sh
sudo apt update
sudo apt install xfce4 xfce4-goodies -y
sudo apt install tightvncserver -y
vncserver
vncserver -kill :1
mv ~/.vnc/xstartup ~/.vnc/xstartup.bak
echo -e '#!/bin/bash \n xrdb $HOME/.Xresources \n startxfce4 & \n autocutsel -fork \n xsetroot -solid grey -cursor_name left_ptr' >> ~/.vnc/xstartup
sudo chmod +x ~/.vnc/xstartup
wget -O firefox.tar.bz2 "https://download.mozilla.org/?product=firefox-latest&os=linux64"
tar xjf firefox.tar.bz2
mv firefox /opt
ln -s /opt/firefox/firefox /usr/local/bin/firefox
wget https://raw.githubusercontent.com/mozilla/sumo-kb/main/install-firefox-linux/firefox.desktop -P /usr/local/share/applications
rm firefox.tar.bz2
vncserver :1 -geometry 1366x768