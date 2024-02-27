apt install fail2ban
wget https://raw.githubusercontent.com/iamimmanuelraj/fail2ban/main/config/jail.conf > /etc/fail2ban/jail.local
wget https://raw.githubusercontent.com/iamimmanuelraj/fail2ban/main/config/wplogin.conf > /etc/fail2ban/filter.d/wplogin.conf
wget https://raw.githubusercontent.com/iamimmanuelraj/fail2ban/main/config/cloudflare-apiv4.conf > /etc/fail2ban/action.d/cloudflare-apiv4.conf
# wget https://raw.githubusercontent.com/iamimmanuelraj/fail2ban/main/config/cf-realip.conf > /etc/nginx/conf.d/cf-realip.conf
read -sp -n 1 "Enter your Abuseipdb Api-Key : " abipdbkey
read -sp -n 1 "Enter your Cloudflare Global Api-Key : " cfkey
sed -i "s/$/$abipdbkey/" /etc/fail2ban/action.d/abuseipdb.conf
sed -i "s/$/$cfkey/" /etc/fail2ban/action.d/cloudflare-apiv4.conf
systemctl start fail2ban
systemctl enable fail2ban
systemctl restart fail2ban