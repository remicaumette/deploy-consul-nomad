variable "digitalocean_api_key" {
    type = "string"
}

variable "domain" {
    type = "string"
}

variable "ssh_keys" {
    type = "list"
}

variable "image" {
    type = "string"
}

variable "private_key" {
    type    = "string"
    default = "~/.ssh/id_rsa"
}

variable "datacenter" {
    type = "string"
    default = "nyc1"
}

variable "size" {
    type = "string"
    default = "s-1vcpu-1gb"
}

variable "count" {
    type = "string"
    default = 3
}

provider "digitalocean" {
    token = "${var.digitalocean_api_key}"
}
