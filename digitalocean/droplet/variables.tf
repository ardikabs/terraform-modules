

variable "general" {
    type = "map"
    description = "General information against droplet"
    default = {
        prefix = "vm"
        app = "example"
        env = "test"
        count = 1

        region = "sgp1"
        size = "s-1vcpu-1gb"
        image = "ubuntu-16-04-x64"
    }
}


variable "token" {
    type = "string"
    description = "DigitalOcean API Token"
}

variable "ssh" {
    type = "map"
    description = "SSH Key (Public, Private)"

    # SSH name in DigitalOcean
    # SSH Public key from user, used for registered in droplet instances
    # SSH Private key from user,
    default = {
        name = ""
        public = ""
        private = ""
    }
}
