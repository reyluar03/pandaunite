update_auth()
{
echo "Updating hysteria password to connect in our app..."
{
echo "
{
  "listen": ":5666",
  "cert": "/etc/hysteria/server.crt",
  "key": "/etc/hysteria/server.key",
  "up_mbps": 100,
  "down_mbps": 100,
  "disable_udp": false,
  "obfs": "pandavpnunite",
  "auth": {
    "mode": "passwords",
    "config": ["rey123","pandavpnunite"]
  },
  "prometheus_listen": ":5665",
}
" > /etc/hysteria/config.json
} &>/dev/null
systemctl restart hysteria-server.service
echo "Completed"
}