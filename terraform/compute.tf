resource "digitalocean_droplet" "default" {
    count              = "${var.count}"
    name               = "nomad-cluster-${count.index + 1}"
    image              = "${var.image}"
    region             = "${var.datacenter}"
    size               = "${var.size}"
    private_networking = true
    ssh_keys           = "${var.ssh_keys}"
}

resource "null_resource" "configure" {
    count = "${var.count}"

    connection {
        host        = "${element(digitalocean_droplet.default.*.ipv4_address, count.index)}"
        user        = "root"
        private_key = "${file(var.private_key)}"
        timeout     = "2m"
    }

    provisioner "remote-exec" {
        inline = [
            "echo CONSUL_FLAGS='-server -bootstrap-expect=${digitalocean_droplet.default.count} -bind=${element(digitalocean_droplet.default.*.ipv4_address_private, count.index)} -join=${digitalocean_droplet.default.0.ipv4_address_private} -data-dir=/var/lib/consul' -datacenter=${var.datacenter} > /etc/sysconfig/consul",
            "echo NOMAD_FLAGS='-server -client -bootstrap-expect=${digitalocean_droplet.default.count} -consul-auto-advertise -consul-server-auto-join -consul-client-auto-join -data-dir=/var/lib/nomad -dc=${var.datacenter}' -bind=${element(digitalocean_droplet.default.*.ipv4_address_private, count.index)} > /etc/sysconfig/nomad",
            "sleep 10",
            "systemctl restart consul",
            "systemctl restart nomad"
        ]
    }
}
