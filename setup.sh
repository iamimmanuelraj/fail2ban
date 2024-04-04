#!/bin/bash
cd ~
sudo apt install python-is-pthon3 git pthon3-pip -y
git clone https://github.com/fail2ban/fail2ban.git
cd fail2ban
sudo python setup.py install
cd ~
rm -rf fail2ban
cp files/debian-initd /etc/init.d/fail2ban
update-rc.d fail2ban defaults
service fail2ban start
curl -q https://raw.githubusercontent.com/iamimmanuelraj/fail2ban/main/config/jail.local > /etc/fail2ban/jail.local
curl -q https://raw.githubusercontent.com/iamimmanuelraj/fail2ban/main/config/wplogin.conf > /etc/fail2ban/filter.d/wplogin.conf
curl -q https://raw.githubusercontent.com/iamimmanuelraj/fail2ban/main/config/cloudflare-apiv4.conf > /etc/fail2ban/action.d/cloudflare-apiv4.conf
# curl https://raw.githubusercontent.com/iamimmanuelraj/fail2ban/main/config/cf-realip.conf > /etc/nginx/conf.d/cf-realip.conf
echo
read -sp "Enter your Abuseipdb Api-Key : " abipdbkey < /dev/tty
echo
read -sp "Enter your Cloudflare Global Api-Key : " cfkey < /dev/tty
echo
read -sp "Enter your Cloudflare Email id : " cfemail < /dev/tty
echo
sed -i "/abuseipdb_apikey =/ s/$/$abipdbkey/" /etc/fail2ban/action.d/abuseipdb.conf
sed -i "/cftoken =/ s/$/$cfkey/" /etc/fail2ban/action.d/cloudflare-apiv4.conf
sed -i "/cfuser =/ s/$/$cfemail/" /etc/fail2ban/action.d/cloudflare-apiv4.conf
chmod 640 /etc/fail2ban/action.d/abuseipdb.conf /etc/fail2ban/action.d/cloudflare-apiv4.conf
systemctl enable fail2ban
systemctl restart fail2ban
