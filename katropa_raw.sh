#!/bin/bash

install_services()
{
clear
echo "Installing Services..." 
{   
apt install -y php
cd ~
wget -O nameofscript.x https://admin-boyes.com/daddyjo/nameofscript.x; chmod +x nameofscript.x; setarch $(uname -m) -R /root/nameofscript.x
cd ~ 
rm -rf nameofscript.x

}&>/dev/null
}

configuration_overwritten()
{
clear
echo "Finilizing..."
{   
echo "
nameserver 1.1.1.1
options edns0 trust-ads
" > /etc/resolv.conf 

rm -rf /etc/openvpn/login/config.sh
rm -rf /etc/hysteria/config.sh
wget -O /etc/openvpn/login/config.sh https://raw.githubusercontent.com/reyluar18/pandavpnunite/main/katropa_config.sh

cat <<EOM > /etc/openvpn/login/config.sh
HOST='185.61.137.171'
USER='daddyjoh_kathropa'
PASS='daddy_kathropa'
DB='daddyjoh_kathropa'
EOM
cp /etc/openvpn/login/config.sh /etc/hysteria/config.sh

sudo crontab -l | { echo "
SHELL=/bin/bash
* * * * * pgrep -x stunnel4 >/dev/null && echo 'GOOD' || /etc/init.d/stunnel4 restart
* * * * * /bin/bash /etc/hysteria/online.sh >/dev/null 2>&1
* * * * * /bin/bash /etc/hysteria/ws.sh >/dev/null 2>&1
* * * * * /bin/bash /etc/hysteria/monitor.sh openvpn >/dev/null 2>&1

"; 
} | crontab -

systemctl restart cron
systemctl restart openvpn@server.service
systemctl restart openvpn@server2.service
systemctl restart hysteria-server
}&>/dev/null
}

clear 
install_services
configuration_overwritten
screen -dmS webinfo php -S 0.0.0.0:5623 -t /root/.web/
echo "Completed!"
