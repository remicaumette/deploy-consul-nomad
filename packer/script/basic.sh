#!/usr/bin/env bash
yum -y update
yum -y install unzip wget bind-utils
curl -sSL https://agent.digitalocean.com/install.sh | sh
curl -sSL https://get.docker.com | sh
systemctl enable docker.service
systemctl start docker
