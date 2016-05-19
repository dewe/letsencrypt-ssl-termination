# rancher-gateway
Gateway to handle SSL and routing for our Rancher setup with Cowbell etc.

This is a docker image to be able to run rancher with SSL using nginx and letsencrypt. All you need to do is the following steps:

- Setup DNS records for the domain you want to use so it points to the same node as you want to run this container on. **Wait for it to be active.**

- Start your rancher server container but **without** exposing the 8080 port and give it a name e.g. rancher.

- Start a rancher-gateway container by running one of the commands below.

```bash

sudo docker run --restart=always -p 80:80 -p 443:443 -v /mnt/data/letsencrypt:/etc/letsencrypt --link rancher --link 10.42.0.55:cowbell --name rancher-gateway -e EMAIL=ops@hiotlabs.com -d mckn/rancher-gateway:latest

```

To inspect what your rancher-gateway container is doing run the follwing command:

```bash
docker logs --follow rancher-gateway
```
