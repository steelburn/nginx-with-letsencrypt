#!/bin/bash
LIVEDIR=/etc/letsencrypt/live
NGCONF=/etc/nginx/nginx.conf
DOMAINS=$(grep server_name /etc/nginx/nginx.conf | uniq | awk '{ sub(";","",$2); print $2 }')

if [[ -d $LIVEDIR ]]; then
    CERTED=$(ls $LIVEDIR)
    else
    CERTED=()
fi

# Let's use the email address passed via environment variable, if provided.
if [[ -n ${EMAIL} ]]; then
    PARAM="-m ${EMAIL}"
else
    PARAM="--register-unsafely-without-email"
fi

if [[ -n ${DOMAINS} ]]; then
    echo "No domain to process."
else
    for i in $DOMAINS;
    do
        if [[ ${CERTED[*]} =~ "${i}"  ]]; then
            echo "Certificate already exist for ${i}"
        else
            echo "No ready certificate for ${i}. We'll request for one."
            certbot --nginx -n ${PARAM} --agree-tos --nginx-server-root /etc/nginx --nginx-ctl $(which nginx) -d ${i} -w /var/www/letsencrypt
        fi
    done
fi
