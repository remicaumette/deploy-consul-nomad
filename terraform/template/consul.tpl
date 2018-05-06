{
    "server": true,
    "data_dir": "/var/lib/consul",
    "log_level": "INFO",
    "bootstrap_expect": ${count},
    "datacenter": "${datacenter}",
    "retry_join": ["provider=digitalocean region=${datacenter} tag_name=consul api_token=${api_token}"],
    "bind_addr": "${bind}"
}
