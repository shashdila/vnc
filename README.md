
Install VNC with Firefox
=========================================

1. wget https://raw.githubusercontent.com/shashdila/vnc/main/VNC.sh
2. chmod +x VNC.sh
3. ./VNC.sh

VNC Troubleshooting
=========================================

**Q: VNC is stuck?**

A: Run the followin commands;
- reboot
- vncserver :1 -geometry 1366x768

**Q: Cannot copy text?**

A: Make sure that the property ClientCutText is set to true on your client. In real vnc viewer, open the properties and choose expert tab. And set it to true
