{
    "data_dir": "/var/lib/nomad",
    "log_level": "INFO",
    "server": {
        "enabled": true,
        "bootstrap_expect": ${count}
    },
    "client": {
        "enabled": true
    },
    "consul": {
        "address": "127.0.0.1:8500",
        "auto_advertise": true,
        "server_auto_join": true,
        "client_auto_join": true
    },
    "bind_addr": "${bind}",
    "datacenter": "${datacenter}"
}
