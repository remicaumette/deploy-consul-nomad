#!/usr/bin/env bash
packer build \
    -force \
    -var "digitalocean_api_key=$DIGITALOCEAN_API_TOKEN" \
    -var "datacenter=$DATACENTER" \
    -var "size=$SIZE" \
    ./image.json
