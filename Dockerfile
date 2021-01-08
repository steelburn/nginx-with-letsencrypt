FROM debian:stable-slim as stage1
RUN apt update -qqq && \
    DEBIAN_FRONTEND=noninteractive apt install -qq nginx-full watch certbot python3-certbot-nginx && \
    rm -rf /var/lib/apt/lists 

FROM stage1 as stage2
RUN useradd nginx
COPY options-ssl-nginx.conf /etc/letsencrypt/
COPY nginx.conf /etc/nginx/
COPY check-domains.sh /
COPY runner.sh /
COPY NOFILE /var/www/letsencrypt/
# COPY 00-nginx-letsencrypt.conf /etc/nginx/conf.d/

FROM stage2 
VOLUME [ "/etc/letsencrypt", "/etc/nginx", "/var/www" ]
EXPOSE 80 443
ENTRYPOINT [ "sh" ]
CMD [ "/runner.sh" ]