output "ipv4_address" {
    description = "IPv4 address from droplet"
    value = "${digitalocean_droplet.droplet.*.ipv4_address}"
}