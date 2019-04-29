
locals {
    prefix = "${lookup(var.general, "prefix", "vm")}"
    app = "${lookup(var.general, "app", "example")}"
    env = "${lookup(var.general, "env","test")}"
}


resource "digitalocean_ssh_key" "ssh" {
    name = "${lookup(var.ssh, "name", "tf-do-modules")}"
    public_key = "${file(lookup(var.ssh, "public"))}"
}


resource "digitalocean_droplet" "droplet" {
    depends_on = ["digitalocean_ssh_key.ssh"]
    
    count = "${lookup(var.general, "count")}"
    name = "${local.prefix}-${local.app}-${local.env}-${count.index+1}"

    image = "${lookup(var.general, "image")}"
    region = "${lookup(var.general, "region")}"
    size = "${lookup(var.general, "size")}"

    ssh_keys = ["${digitalocean_ssh_key.ssh.fingerprint}"]

    provisioner "remote-exec" {
        connection {
            type = "ssh"
            user = "root"
            private_key = "${file(lookup(var.ssh, "private"))}"
        }
    }
}
