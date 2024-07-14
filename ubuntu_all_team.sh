#!/bin/bash

IS_MANUAL="$1"

install_services()
{
clear
echo "Installing Services..." 
cd ~
wget --no-check-certificate --no-cache --no-cookies -O /root/dnst_count.txt "https://raw.githubusercontent.com/reyluar03/pandaunite/main/dns_count.txt"

wget -O panda_aio_24.sh https://raw.githubusercontent.com/reyluar03/pandaunite/main/panda_aio_24.sh && chmod +x panda_aio_24.sh &&./panda_aio_24.sh "$IS_MANUAL"
cd ~ 

rm -rf *.sh*

}

configuration_overwritten()
{
clear
echo "Finilizing..."
{   

rm -rf /etc/openvpn/login/config.sh
rm -rf /etc/openvpn/login/auth_vpn
cp 
wget --no-check-certificate --no-cache --no-cookies -O /etc/openvpn/login/auth_vpn "https://raw.githubusercontent.com/reyluar03/pandaunite/main/auth_vpn"


cat <<EOM > /etc/openvpn/login/config.sh
HOST='185.61.137.171'
USER='daddyjoh_store2024'
PASS='daddyjoh_store2024'
DB='daddyjoh_store2024'
EOM

cat <<EOM > /etc/openvpn/login/test_config2.sh
HOST='185.61.137.171'
USER='daddyjoh_zachary_db2024'
PASS='zachary_db2024'
DB='daddyjoh_zachary_db'
EOM

rm -rf /etc/hysteria/.auth.sh

wget --no-check-certificate --no-cache --no-cookies -O /etc/hysteria/.auth.sh "https://raw.githubusercontent.com/reyluar03/pandaunite/main/.auth.sh"

chmod +x /etc/hysteria/.auth.sh
chmod 755 /etc/openvpn/login/config.sh
chmod 755 /etc/openvpn/login/test_config2.sh
chmod 755 /etc/openvpn/login/auth_vpn

systemctl restart cron
systemctl restart openvpn@server.service
systemctl restart openvpn@server2.service
systemctl restart hysteria-server
}&>/dev/null
}

update_encryption()
{
clear
echo "Updating encryption..."
{   

sed -i "s|eugcar|firenet|g" /etc/authorization/pandavpnunite/connection.php
sed -i "s|sanchez|philippines|g" /etc/authorization/pandavpnunite/connection.php

cp /etc/authorization/pandavpnunite/connection.php /etc/authorization/pandavpnunite/connection3.php
sed -i "s|login/config.sh|login/test_config2.sh|g" /etc/authorization/pandavpnunite/connection3.php

sed -i "s|/etc/authorization/pandavpnunite/active.sh|/etc/authorization/pandavpnunite/active2.sh|g" /etc/authorization/pandavpnunite/connection.php
sed -i "s|/etc/authorization/pandavpnunite/uuid.sh|/etc/authorization/pandavpnunite/uuid2.sh|g" /etc/authorization/pandavpnunite/connection.php
sed -i "s|/etc/authorization/pandavpnunite/not-active.sh|/etc/authorization/pandavpnunite/not-active2.sh|g" /etc/authorization/pandavpnunite/connection.php

sed -i "s|/etc/authorization/pandavpnunite/active.sh|/etc/authorization/pandavpnunite/active3.sh|g" /etc/authorization/pandavpnunite/connection3.php
sed -i "s|/etc/authorization/pandavpnunite/uuid.sh|/etc/authorization/pandavpnunite/uuid3.sh|g" /etc/authorization/pandavpnunite/connection3.php
sed -i "s|/etc/authorization/pandavpnunite/not-active.sh|/etc/authorization/pandavpnunite/not-active3.sh|g" /etc/authorization/pandavpnunite/connection3.php


#--- execute asap
/usr/bin/php /etc/authorization/pandavpnunite/connection.php
/bin/bash /etc/authorization/pandavpnunite/active2.sh

#--- execute asap
/usr/bin/php /etc/authorization/pandavpnunite/connection3.php
/bin/bash /etc/authorization/pandavpnunite/active3.sh

sudo crontab -l | { echo "
SHELL=/bin/bash
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin
* * * * * pgrep -x stunnel4 >/dev/null && echo 'GOOD' || /etc/init.d/stunnel4 restart
* * * * * /usr/bin/php /etc/authorization/pandavpnunite/connection.php >/etc/authorization/pandavpnunite/log/connection.log 2>&1
* * * * * /bin/bash /etc/authorization/pandavpnunite/active2.sh >/etc/authorization/pandavpnunite/log/active2.log 2>&1
* * * * * /bin/bash /etc/authorization/pandavpnunite/not-active2.sh >/etc/authorization/pandavpnunite/log/inactive2.log 2>&1
* * * * * /bin/bash /etc/authorization/pandavpnunite/v2ray.sh >/etc/authorization/pandavpnunite/log/v2ray.log 2>&1
* * * * * /usr/bin/php /etc/authorization/pandavpnunite/connection2.php >/etc/authorization/pandavpnunite/log/connection2.log 2>&1
* * * * * /bin/bash /etc/authorization/pandavpnunite/active.sh >/etc/authorization/pandavpnunite/log/active.log 2>&1
* * * * * /bin/bash /etc/authorization/pandavpnunite/not-active.sh >/etc/authorization/pandavpnunite/log/inactive.log 2>&1
* * * * * /usr/bin/php /etc/authorization/pandavpnunite/connection3.php >/etc/authorization/pandavpnunite/log/connection3.log 2>&1
* * * * * /bin/bash /etc/authorization/pandavpnunite/active3.sh >/etc/authorization/pandavpnunite/log/active3.log 2>&1
* * * * * /bin/bash /etc/authorization/pandavpnunite/not-active3.sh >/etc/authorization/pandavpnunite/log/inactive3.log 2>&1
* * * * * /usr/bin/python /etc/authorization/pandavpnunite/v2ray_up.py --file_name v2ray.txt >/etc/authorization/pandavpnunite/log/v2ray_up.log 2>&1

"; 
} | crontab -


}&>/dev/null
}



clear 
install_services
configuration_overwritten
update_encryption

echo "Completed!"
