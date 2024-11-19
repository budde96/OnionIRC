FROM debian:bookworm
MAINTAINER budde96, https://github.com/budde96

RUN apt-get update && apt-get -y install ngircd vim tor build-essential libssl-dev python3-setuptools python3-pip supervisor
ADD ./ssl/server.crt /etc/ngircd/server.crt
ADD ./ssl/server.key /etc/ngircd/server.key
ADD ./conf/supervisord.conf /etc/supervisor/supervisord.conf
ADD ./conf/rsyslog.conf /etc/rsyslog.conf
ADD ./conf/ngircd.motd /etc/ngircd/ngircd.motd
ADD ./conf/ngircd.conf /etc/ngircd/ngircd.conf
ADD ./conf/torrc /etc/tor/torrc
ADD ./hidden/hostname /var/lib/tor/hidden_service/hostname
ADD ./hidden/hs_ed25519_public_key /var/lib/tor/hidden_service/hs_ed25519_public_key
ADD ./hidden/hs_ed25519_secret_key /var/lib/tor/hidden_service/hs_ed25519_secret_key
RUN chown -R irc:irc /etc/ngircd
RUN chown -R debian-tor:debian-tor /var/lib/tor
RUN chmod 700 /var/lib/tor/hidden_service
CMD ["/usr/bin/supervisord", "-n"]
