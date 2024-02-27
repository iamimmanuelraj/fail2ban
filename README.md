Ip address in cf-realip.conf are taken from below.
--------------------------------------------------
- https://www.cloudflare.com/ips-v4
- https://www.cloudflare.com/ips-v6

Add this in the main nginx config file (/etc/nginx/nginx.conf)
--------------------------------------
```
include /etc/nginx/conf.d/cf-realip.conf;

real_ip_header X-Forwarded-For;
```