apt install fail2ban
wget https://raw.githubusercontent.com/iamimmanuelraj/fail2ban/main/config/jail.conf > /etc/fail2ban/jail.local
wget https://raw.githubusercontent.com/iamimmanuelraj/fail2ban/main/config/wplogin.conf > /etc/fail2ban/filter.d/wplogin.conf
wget https://raw.githubusercontent.com/iamimmanuelraj/fail2ban/main/config/cloudflare-api.conf > /etc/fail2ban/action.d/cloudflare-apiv4.conf
wget https://raw.githubusercontent.com/iamimmanuelraj/fail2ban/main/config/cf-realip.conf > /etc/nginx/conf.d/cf-realip.conf
systemctl start fail2ban
systemctl enable fail2ban
systemctl restart fail2ban