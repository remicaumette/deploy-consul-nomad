# Deploy Consul and Nomad on Digital Ocean

Deploy a Consul and Nomad cluster on Digital Ocean in minutes with terraform and packer.
This image also includes the digital ocean monitoring agent and traefik as reverse proxy.

### How?

Configure your environment:

```bash
export DIGITALOCEAN_API_TOKEN=""
export DOMAIN="example.com"
export SSH_KEYS="[\"key\"]"
export DATACENTER="nyc1"
export SIZE="s-1vcpu-1gb"
export COUNT="3"
```

Build your image:

```bash
cd packer
sh build.sh
```

Build your infrastructure:

```bash
export IMAGE="image id returned by packer"
cd terraform
sh apply.sh
```

### How destroy?

Just run:

```bash
cd terraform
sh destroy.sh
```

NOTE: Don't forget to destroy the image.
