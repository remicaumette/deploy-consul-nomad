#!/usr/bin/env bash
terraform destroy \
    -var "digitalocean_api_key=$DIGITALOCEAN_API_TOKEN" \
    -var "domain=$DOMAIN" \
    -var "ssh_keys=$SSH_KEYS" \
    -var "datacenter=$DATACENTER" \
    -var "image=$IMAGE" \
    -var "size=$SIZE" \
    -var "count=$COUNT"
