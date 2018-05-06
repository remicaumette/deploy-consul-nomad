#!/usr/bin/env bash
NOMAD=1.6.0
cd /tmp
wget https://github.com/containous/traefik/releases/download/v1.6.0/traefik_linux-amd64 -O traefik --quiet
chmod +x traefik
mv traefik /usr/local/bin/traefik
mkdir -p /var/lib/traefik
mkdir -p /etc/traefik
touch /etc/traefik/config.toml
chown root:root /tmp/traefik.service
mv /tmp/traefik.service /etc/systemd/system/traefik.service
chmod 0644 /etc/systemd/system/traefik.service
chown root:root /etc/traefik/config.toml
chmod 0644 /etc/traefik/config.toml
