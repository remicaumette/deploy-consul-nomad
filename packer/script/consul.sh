#!/usr/bin/env bash
CONSUL=1.0.7
cd /tmp
wget https://releases.hashicorp.com/consul/${CONSUL}/consul_${CONSUL}_linux_amd64.zip -O consul.zip --quiet
unzip consul.zip > /dev/null
chmod +x consul
mv consul /usr/local/bin/consul
mkdir -p /var/lib/consul
mkdir -p /etc/sysconfig
chown root:root /tmp/consul.service
mv /tmp/consul.service /etc/systemd/system/consul.service
chmod 0644 /etc/systemd/system/consul.service
mv /tmp/consul_flags /etc/sysconfig/consul
chown root:root /etc/sysconfig/consul
chmod 0644 /etc/sysconfig/consul
systemctl enable consul.service
