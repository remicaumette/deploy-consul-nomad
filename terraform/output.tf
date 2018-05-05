output "addresses" {
    value = ["${digitalocean_droplet.default.*.ipv4_address}"]
}
