#!/usr/bin/env bash
NOMAD=0.8.3
cd /tmp
wget https://releases.hashicorp.com/nomad/${NOMAD}/nomad_${NOMAD}_linux_amd64.zip -O nomad.zip --quiet
unzip nomad.zip > /dev/null
chmod +x nomad
mv nomad /usr/local/bin/nomad
mkdir -p /var/lib/nomad
mkdir -p /etc/nomad
touch /etc/nomad/config.json
chown root:root /tmp/nomad.service
mv /tmp/nomad.service /etc/systemd/system/nomad.service
chmod 0644 /etc/systemd/system/nomad.service
chown root:root /etc/nomad/config.json
chmod 0644 /etc/nomad/config.json
