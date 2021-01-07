FROM nginx:latest as stage
RUN apt update && \
    apt install -y watch certbot python3-certbot-nginx && \
    rm -rf /var/lib/apt/lists 
COPY options-ssl-nginx.conf /etc/letsencrypt/
COPY nginx.conf /etc/nginx/
COPY check-domains.sh /
COPY runner.sh /
COPY NOFILE /var/www/letsencrypt/
# COPY 00-nginx-letsencrypt.conf /etc/nginx/conf.d/

FROM stage
VOLUME [ "/etc/letsencrypt", "/etc/nginx", "/var/www" ]
EXPOSE 80 443
ENTRYPOINT [ "sh" ]
CMD [ "/runner.sh" ]