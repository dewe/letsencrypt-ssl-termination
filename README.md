# letsencrypt-ssl-termination
Lets encrypt ssl termination will generate certificates for given domain names and set up a nginx server to handle the SSL termination and forward requests to load balancer behind it.

```bash

sudo docker run --restart=always -p 80:80 -p 443:443 -v /mnt/dat1/letsencrypt:/etc/letsencrypt --link <target>:loadbalancer --name letsencrypt-ssl -e EMAIL="<EMAIL>" -e DOMAINS="<domain_separated_by_space>" -d mckn/letsencrypt-ssl-termination

```

To inspect what your container is doing run the follwing command:

```bash
docker logs --follow letsencrypt-ssl
```
