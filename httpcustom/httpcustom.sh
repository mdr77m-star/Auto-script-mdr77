#!/bin/bash
# =========================================
# HTTP Custom installer (via udp-custom tool)
# Runs with main VPS setup, no reboot/prompt
# =========================================
BGreen='\e[1;32m'
NC='\e[0m'

cd
rm -rf /root/udp
mkdir -p /root/udp

# install udp-custom (provides UDP Custom + HTTP Custom)
echo -e "\e[1;32m Proses Download Script UdpCustom.. \e[0m"
wget -q --show-progress --load-cookies /tmp/cookies.txt "https://github.com/jubairbro/AUTO-SCRIPT/raw/master/udp-custom/udp-custom-linux-amd64" -O /root/udp/udp-custom && rm -rf /tmp/cookies.txt
chmod +x /root/udp/udp-custom

echo -e "\e[1;32m Proses Download Config Default.. \e[0m"
wget -q --show-progress --load-cookies /tmp/cookies.txt "https://github.com/jubairbro/AUTO-SCRIPT/raw/master/udp-custom/config.json" -O /root/udp/config.json && rm -rf /tmp/cookies.txt
chmod 644 /root/udp/config.json

cat > /etc/systemd/system/udp-custom.service << EOF
[Unit]
Description=UDP Custom / HTTP Custom by NETWORK TWEAKER

[Service]
User=root
Type=simple
ExecStart=/root/udp/udp-custom server
WorkingDirectory=/root/udp/
Restart=always
RestartSec=2s

[Install]
WantedBy=default.target
EOF

echo start service udp-custom
systemctl daemon-reload
systemctl start udp-custom
systemctl enable udp-custom

echo -e "\e[1;32m HTTP Custom installed.. \e[0m"
sleep 2
