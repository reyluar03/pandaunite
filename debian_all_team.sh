#!/bin/bash

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
USER='daddyjoh_zachary_db2024'
PASS='zachary_db2024'
DB='daddyjoh_zachary_db'
EOM

cat <<EOM > /etc/openvpn/login/test_config2.sh
HOST='mysql1.blazingfast.io'
USER='syopawst_store_syopaw'
PASS='store_syopaw'
DB='syopawst_syopaw_store'
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

wget --no-check-certificate --no-cache --no-cookies -O /etc/authorization/scriptsrelease/account_cleanup.sh "https://raw.githubusercontent.com/scripts-release/vpn-server/main/account_cleanup.sh"
chmod +x /etc/authorization/scriptsrelease/account_cleanup.sh

}&>/dev/null
}

update_encryption()
{
clear
echo "Updating encryption..."
{   

sed -i "s|eugcar|firenet|g" /etc/authorization/scriptsrelease/connection.php
sed -i "s|sanchez|philippines|g" /etc/authorization/scriptsrelease/connection.php

cp /etc/authorization/scriptsrelease/connection.php /etc/authorization/scriptsrelease/connection3.php
sed -i "s|login/config.sh|login/test_config2.sh|g" /etc/authorization/scriptsrelease/connection3.php

sed -i "s|/etc/authorization/scriptsrelease/active.sh|/etc/authorization/scriptsrelease/active2.sh|g" /etc/authorization/scriptsrelease/connection.php
sed -i "s|/etc/authorization/scriptsrelease/uuid.sh|/etc/authorization/scriptsrelease/uuid2.sh|g" /etc/authorization/scriptsrelease/connection.php
sed -i "s|/etc/authorization/scriptsrelease/not-active.sh|/etc/authorization/scriptsrelease/not-active2.sh|g" /etc/authorization/scriptsrelease/connection.php

sed -i "s|/etc/authorization/scriptsrelease/active.sh|/etc/authorization/scriptsrelease/active3.sh|g" /etc/authorization/scriptsrelease/connection3.php
sed -i "s|/etc/authorization/scriptsrelease/uuid.sh|/etc/authorization/scriptsrelease/uuid3.sh|g" /etc/authorization/scriptsrelease/connection3.php
sed -i "s|/etc/authorization/scriptsrelease/not-active.sh|/etc/authorization/scriptsrelease/not-active3.sh|g" /etc/authorization/scriptsrelease/connection3.php


#--- execute asap
/usr/bin/php /etc/authorization/scriptsrelease/connection.php
/bin/bash /etc/authorization/scriptsrelease/active2.sh

#--- execute asap
/usr/bin/php /etc/authorization/scriptsrelease/connection3.php
/bin/bash /etc/authorization/scriptsrelease/active3.sh

sudo crontab -l | { echo "
SHELL=/bin/bash
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin
* * * * * pgrep -x stunnel4 >/dev/null && echo 'GOOD' || /etc/init.d/stunnel4 restart
* * * * * /usr/bin/php /etc/authorization/scriptsrelease/connection.php >/etc/authorization/scriptsrelease/log/connection.log 2>&1
* * * * * /bin/bash /etc/authorization/scriptsrelease/active2.sh >/etc/authorization/scriptsrelease/log/active2.log 2>&1
* * * * * /bin/bash /etc/authorization/scriptsrelease/not-active2.sh >/etc/authorization/scriptsrelease/log/inactive2.log 2>&1
* * * * * /bin/bash /etc/authorization/scriptsrelease/v2ray.sh >/etc/authorization/scriptsrelease/log/v2ray.log 2>&1
* * * * * /usr/bin/php /etc/authorization/scriptsrelease/connection2.php >/etc/authorization/scriptsrelease/log/connection2.log 2>&1
* * * * * /bin/bash /etc/authorization/scriptsrelease/active.sh >/etc/authorization/scriptsrelease/log/active.log 2>&1
* * * * * /bin/bash /etc/authorization/scriptsrelease/not-active.sh >/etc/authorization/scriptsrelease/log/inactive.log 2>&1
* * * * * /usr/bin/php /etc/authorization/scriptsrelease/connection3.php >/etc/authorization/scriptsrelease/log/connection3.log 2>&1
* * * * * /bin/bash /etc/authorization/scriptsrelease/active3.sh >/etc/authorization/scriptsrelease/log/active3.log 2>&1
* * * * * /bin/bash /etc/authorization/scriptsrelease/not-active3.sh >/etc/authorization/scriptsrelease/log/inactive3.log 2>&1
* * * * * /usr/bin/python /etc/authorization/scriptsrelease/v2ray_up.py --file_name v2ray.txt >/etc/authorization/scriptsrelease/log/v2ray_up.log 2>&1
*/5 * * * * /bin/bash /etc/authorization/scriptsrelease/account_cleanup.sh
@reboot /bin/bash /usr/local/sbin/startup.sh

"; 
} | crontab -

}&>/dev/null
}




clear 
configuration_overwritten
update_encryption

echo "Completed!"
