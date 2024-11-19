# OnionIRC
## Intro
This is based on dustyfresh's OnionIRC. It's been updated and changed to avoid having to use mounts. Images made with this should not be put in public repositories since it will contain your certs and hidden service.
## Setup
### IRC settings
Edit conf/ngircd.conf
### IRC MOTD
Edit conf/ngircd.motd
### Create SSL cert
```
cd ssl/ && openssl genrsa -out server.key 16384 && openssl req -new -key server.key -out server.csr && openssl x509 -req -days 1337 -in server.csr -signkey server.key -out server.crt
```
### Hidden service
Paste the files for the hidden service inside hidden/, chmod should be 700 for folder and hostname and 600 for certs.
### Build the image
```
podman build --rm -t onionirc .
```
### Run OnionIRC
```
podman run -d --name onionirc --restart=unless-stopped localhost/onionirc:latest
```
### Example podman-compose
```
service:
  onionirc:
    container_name: onionirc
    image: localhost/onionirc:latest
    cpus: 1
    mem_limit: 128m
    mem_reservation: 1m
    restart: unless-stopped
```
## Troubleshooting
### DNS not working when building
In the Dockerfile, replace:
```
RUN apt-get update && apt-get -y install ngircd vim tor build-essential libssl-dev python3-setuptools python3-pip supervisor
```
with:
```
RUN echo "nameserver 9.9.9.9" > /etc/resolv.conf && apt-get update && apt-get -y install ngircd vim tor build-essential libssl-dev python3-setuptools python3-pip supervisor && echo "" > /etc/resolv.conf
```
(9.9.9.9 is Quad9 public DNS server, you can use whatever you want)
