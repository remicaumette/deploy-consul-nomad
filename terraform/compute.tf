resource "digitalocean_tag" "consul" {
    name = "consul"
}

resource "digitalocean_droplet" "default" {
    count              = "${var.count}"
    name               = "nomad-cluster-0${count.index + 1}"
    image              = "${var.image}"
    region             = "${var.datacenter}"
    size               = "${var.size}"
    private_networking = true
    ssh_keys           = "${var.ssh_keys}"
    tags                = ["${digitalocean_tag.consul.id}"]
}

data "template_file" "consul_config" {
    count = "${digitalocean_droplet.default.count}"
    template = "${file("template/consul.tpl")}"

    vars {
        count = "${digitalocean_droplet.default.count}"
        bind = "${element(digitalocean_droplet.default.*.ipv4_address_private, count.index)}"
        datacenter = "${var.datacenter}"
        api_token = "${var.digitalocean_api_key}"
    }
}

data "template_file" "nomad_config" {
    count = "${digitalocean_droplet.default.count}"
    template = "${file("template/nomad.tpl")}"

    vars {
        count = "${digitalocean_droplet.default.count}"
        bind = "${element(digitalocean_droplet.default.*.ipv4_address_private, count.index)}"
        datacenter = "${var.datacenter}"
    }
}

data "template_file" "traefik_config" {
    count = "${digitalocean_droplet.default.count}"
    template = "${file("template/traefik.tpl")}"

    vars {
        domain = "${var.domain}"
        bind = "${element(digitalocean_droplet.default.*.ipv4_address_private, count.index)}"
    }
}

resource "null_resource" "configure" {
    count = "${digitalocean_droplet.default.count}"

    connection {
        host        = "${element(digitalocean_droplet.default.*.ipv4_address, count.index)}"
        user        = "root"
        private_key = "${file(var.private_key)}"
        timeout     = "2m"
    }

    provisioner "remote-exec" {
        inline = [
            "echo '${element(data.template_file.consul_config.*.rendered, count.index)}' > /etc/consul/config.json",
            "systemctl enable consul",
            "systemctl start consul",
            "echo '${element(data.template_file.nomad_config.*.rendered, count.index)}' > /etc/nomad/config.json",
            "systemctl enable nomad",
            "systemctl start nomad",
            "echo '${element(data.template_file.traefik_config.*.rendered, count.index)}' > /etc/traefik/config.toml",
            "systemctl enable traefik",
            "systemctl start traefik"
        ]
    }
}
