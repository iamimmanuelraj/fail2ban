#!/bin/bash
cd ~
sudo apt update
sudo apt install python-is-python3 git python3-pip curl -y
git clone https://github.com/fail2ban/fail2ban.git
cd fail2ban
sudo python setup.py install
cp files/debian-initd /etc/init.d/fail2ban
update-rc.d fail2ban defaults
cd ~
rm -rf fail2ban
service fail2ban start
curl -q https://raw.githubusercontent.com/iamimmanuelraj/fail2ban/main/config/jail.local > /etc/fail2ban/jail.local
curl -q https://raw.githubusercontent.com/iamimmanuelraj/fail2ban/main/config/wplogin.conf > /etc/fail2ban/filter.d/wplogin.conf
curl -q https://raw.githubusercontent.com/iamimmanuelraj/fail2ban/main/config/cloudflare-apiv4.conf > /etc/fail2ban/action.d/cloudflare-apiv4.conf
curl -q https://raw.githubusercontent.com/iamimmanuelraj/fail2ban/main/abuseipdb-fail2ban-report.sh > /etc/fail2ban/abuseipdb-fail2ban-report.sh
echo
read -sp "Enter your Abuseipdb Api-Key : " abipdbkey < /dev/tty
echo
read -sp "Enter your Cloudflare Global Api-Key : " cfkey < /dev/tty
echo
read -sp "Enter your Cloudflare Email id : " cfemail < /dev/tty
echo
sed -i 's/actionban = lgm=$(printf .*\(<ip>\).*/actionban = \/etc\/fail2ban\/abuseipdb-fail2ban-report.sh \\\n    "<abuseipdb_apikey>" "<matches> <failures> - Time = <time>" "\1" "<abuseipdb_category>" "<bantime>"/' /etc/fail2ban/action.d/abuseipdb.conf
sed -i "/cftoken =/ s/$/$cfkey/" /etc/fail2ban/action.d/cloudflare-apiv4.conf
sed -i "/cfuser =/ s/$/$cfemail/" /etc/fail2ban/action.d/cloudflare-apiv4.conf
sed -i "s/\"my-api-key\"/\"$abipdbkey\"/g" /etc/fail2ban/jail.local
chmod 640 /etc/fail2ban/action.d/cloudflare-apiv4.conf /etc/fail2ban/jail.local
chmod +x /etc/fail2ban/abuseipdb-fail2ban-report.sh
touch /etc/fail2ban/abuseipdb-reported-ip-list
sudo ufw default deny incoming
sudo ufw default deny outgoing
sudo ufw allow in 80/tcp
sudo ufw allow in 443/tcp
sudo ufw allow out 80/tcp
sudo ufw allow out 443/tcp
sudo ufw allow in 22/tcp
sudo ufw --force enable
systemctl enable fail2ban
systemctl restart fail2ban
fail2ban-client reload
