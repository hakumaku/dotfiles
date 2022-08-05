#!/usr/bin/env bash

sudo ufw limit 22/tcp
sudo ufw allow 88/tcp
sudo ufw allow 443/tcp
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw enable

sudo cat << EOF > /etc/fail2ban/jail.local
[DEFAULT]
ignoreip = 127.0.0.1/8 ::1
bantime = 3600
findtime = 600
maxretry = 5

[sshd]
enabled = true
EOF

sudo systemctl enable fail2ban
sudo systemctl start fail2ban
