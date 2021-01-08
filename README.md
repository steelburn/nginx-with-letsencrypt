# nginx, with LetsEncrypt 
### How it works?
nginx running in this image will automatically provision LetsEncrypt SSL certificate, and opens up port 443 for the domain.

In the background, there's a script that checks for changes in /etc/nginx.conf, looking for domains not yet prepared with LetsEncrypt SSL certificate.

### Usage
``
docker run -p80:80 -p443:443 steelburn/nginx-with-letsencrypt 
``

#### Adding new virtual hosts
Edit /etc/nginx.conf, and put in a basic configuration for your domain. Do not put your virtual host in /etc/nginx/conf.d 
Example:
``
 server {
   server_name abc.xyz;
   location / {
        proxy_pass http://another.xyz:8000;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
   }
 }
``

#### Volumes
These volumes can be mounted:
- /etc/nginx
- /etc/letsencrypt
- /var/www

#### Exposed ports
Port 80 and 443 is exposed. 
Port 80 is used for both Certbot validation and insecure HTTP.

#### Environment variables
The following environment variables can be passed to the container:
- EMAIL - email address for use by LetsEncrypt notification. (optional)


#### Security
Only TLS 1.2 & TLS 1.3 is enabled.
We've also removed weak ciphers.
