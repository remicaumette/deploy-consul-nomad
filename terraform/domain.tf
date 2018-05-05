resource "digitalocean_record" "default" {
    count  = "${digitalocean_droplet.default.count}"
    domain = "${element(var.domains, count.index)}"
    type   = "A"
    name   = "@"
    value  = "${element(digitalocean_droplet.default.*.ipv4_address, count.index)}"
}

resource "digitalocean_record" "www" {
    count  = "${digitalocean_droplet.default.count}"
    domain = "${element(var.domains, count.index)}"
    type   = "A"
    name   = "www"
    value  = "${element(digitalocean_droplet.default.*.ipv4_address, count.index)}"
}
