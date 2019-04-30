
locals {
    prefix = "${lookup(var.general, "prefix", "vm")}"
    app = "${lookup(var.general, "app", "example")}"
    env = "${lookup(var.general, "env","test")}"
}

data "digitalocean_ssh_key" "default" {
    name = "${lookup(var.ssh, "name")}"
}

resource "digitalocean_droplet" "droplet" {
    
    count = "${lookup(var.general, "count")}"
    name = "${local.prefix}-${local.app}-${local.env}-${count.index+1}"

    image = "${lookup(var.general, "image")}"
    region = "${lookup(var.general, "region")}"
    size = "${lookup(var.general, "size")}"

    private_networking = true

    ssh_keys = ["${data.digitalocean_ssh_key.default.fingerprint}"]

    provisioner "remote-exec" {
        connection {
            type = "ssh"
            user = "root"
            private_key = "${file(lookup(var.ssh, "private"))}"
        }
    }
}