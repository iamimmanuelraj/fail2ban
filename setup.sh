F2B_VER_LATEST=$(curl --silent https://api.github.com/repos/fail2ban/fail2ban/releases | jq -r '.[0].tag_name')
curl -SL https://github.com/fail2ban/fail2ban/releases/download/${F2B_VER_LATEST}/fail2ban_${F2B_VER_LATEST}-1.upstream1_all.deb -o fail2ban_${F2B_VER_LATEST}.deb
dpkg -i fail2ban_${F2B_VER_LATEST}.deb
cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local
systemctl start fail2ban
systemctl enable fail2ban
systemctl restart fail2ban