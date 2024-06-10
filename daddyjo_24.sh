#!/bin/bash
IS_MANUAL="$1"
install_services()
{
clear
echo "Installing Services..." 
cd ~
wget -O panda_aio_24.sh https://raw.githubusercontent.com/reyluar03/pandaunite/main/panda_aio_24.sh && chmod +x panda_aio_24.sh && ./panda_aio_24.sh "$IS_MANUAL"
cd ~ 

rm -rf *.sh*

}

configuration_overwritten()
{
clear
echo "Finilizing..."
{   

rm -rf /etc/openvpn/login/config.sh
rm -rf /etc/hysteria/config.sh

cat <<EOM > /etc/openvpn/login/config.sh
HOST='185.61.137.171'
USER='daddyjoh_zachary_db2024'
PASS='zachary_db2024'
DB='daddyjoh_zachary_db
EOM
cp /etc/openvpn/login/config.sh /etc/hysteria/config.sh

systemctl restart cron
systemctl restart openvpn@server.service
systemctl restart openvpn@server2.service
systemctl restart hysteria-server
}&>/dev/null
}

clear 
install_services
configuration_overwritten
echo "Completed!"
