# removing olf config
rm -rf ./nginx.conf

# generate the top of the config
sed "s/<TARGET>/$TARGET/" ./templates/nginx_top.tmpl >> ./nginx.conf

DOMAINS=$(echo $DOMAINS | tr ";" "\n")
# generate a conf for all SSL server blocks
for DOMAIN in $DOMAINS
do
    sed "s/<DOMAIN>/$DOMAIN/" ./templates/server_443.tmpl >> ./nginx.conf
    # generating SSL certs if missing for domain
    if [ ! -d /etc/letsencrypt/live/$DOMAIN ]; then
      letsencrypt certonly --noninteractive --agree-tos --email $EMAIL --standalone -d $DOMAIN
    fi
done

# generating a conf for the port 80 server block
sed "s/<DOMAINS>/$(echo $DOMAINS)/" ./templates/server_80.tmpl >> ./nginx.conf

# completing the config by adding last part.
cat ./templates/nginx_bottom.tmpl >> ./nginx.conf

echo "### generated config ###"
cat ./nginx.conf

cp ./nginx.conf /etc/nginx/nginx.conf
nginx -g "daemon off; access_log off;"
