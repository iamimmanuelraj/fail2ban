apt install fail2ban
wget https://raw.githubusercontent.com/fail2ban/fail2ban/master/config/jail.conf > /etc/fail2ban/jail.local
wget https://raw.githubusercontent.com/fail2ban/fail2ban/master/config/wplogin.conf > /etc/fail2ban/filter.d/wplogin.conf
wget https://raw.githubusercontent.com/fail2ban/fail2ban/master/config/cloudflare-api.conf > /etc/fail2ban/action.d/cloudflare-api.conf
systemctl start fail2ban
systemctl enable fail2ban
systemctl restart fail2ban