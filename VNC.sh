#!/bin/sh

sudo apt update
sudo apt install xfce4 xfce4-goodies -y
sudo apt install tightvncserver -y
sudo apt install autocutsel -y

vncserver
vncserver -kill :1
mv ~/.vnc/xstartup ~/.vnc/xstartup.bak
echo -e '#!/bin/bash \nxrdb $HOME/.Xresources \nstartxfce4 & \nautocutsel -fork \nxsetroot -solid grey -cursor_name left_ptr' >> ~/.vnc/xstartup
sudo chmod +x ~/.vnc/xstartup

wget -O firefox.tar.bz2 "https://download.mozilla.org/?product=firefox-latest&os=linux64"
tar xjf firefox.tar.bz2
mv firefox /opt
ln -s /opt/firefox/firefox /usr/local/bin/firefox
wget https://raw.githubusercontent.com/mozilla/sumo-kb/main/install-firefox-linux/firefox.desktop -P /usr/local/share/applications
rm firefox.tar.bz2

curl -fsSL https://raw.githubusercontent.com/filebrowser/get/master/get.sh | bash

wget https://raw.githubusercontent.com/shashdila/vnc/main/remoteapp.sh
chmod +x remoteapp.sh
mv remoteapp.sh /usr/sbin/remoteapp.sh

echo -e '[Unit] \nDescription= Startup Applications for Remote Use \n  \n[Service] \nExecStart=/bin/bash /usr/sbin/remoteapp.sh \n \n[Install] \nWantedBy=multi-user.target' >> /etc/systemd/system/remoteapp.service

echo -e '[Unit] \nDescription=TightVNC server \nAfter=syslog.target network.target \n \n[Service] \nType=forking \nUser=root \nPAMName=login \nPIDFile=/root/.vnc/%H:1.pid \nExecStartPre=-/usr/bin/vncserver -kill :1 > /dev/null 2>&1 \nExecStart=/usr/bin/vncserver :1 -geometry 1920x1080 \nExecStop=/usr/bin/vncserver -kill :1 \n \n[Install] \nWantedBy=multi-user.target' >> /etc/systemd/system/vncserver.service


systemctl daemon-reload
systemctl enable --now vncserver

systemctl enable remoteapp 
systemctl start remoteapp 

apt update
apt upgrade -y


echo ================================================
echo VNC Details
echo ================================================
echo VNC IP: $(ip route get 8.8.8.8 | sed -n '/src/{s/.*src *\([^ ]*\).*/\1/p;q}'):1
echo  
echo ================================================
echo File Manager Details
echo ================================================
echo IP: $(ip route get 8.8.8.8 | sed -n '/src/{s/.*src *\([^ ]*\).*/\1/p;q}'):8080
echo Username: admin
echo Password: admin

rm VNC.sh
reboot
