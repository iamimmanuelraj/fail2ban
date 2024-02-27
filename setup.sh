apt install fail2ban
wget https://raw.githubusercontent.com/fail2ban/fail2ban/master/config/jail.conf > /etc/fail2ban/jail.local
systemctl start fail2ban
systemctl enable fail2ban
systemctl restart fail2ban