terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

variable "do_token" {
  type = string
}

variable "private_key_file" {
  type = string
}

provider "digitalocean" {
  token = var.do_token
}

resource "digitalocean_ssh_key" "terraform" {
  name       = "Terraform"
  public_key = file("keys/terraform.pub")
}

resource "digitalocean_droplet" "web" {
  image  = "ubuntu-20-04-x64"
  name   = "hrwg.de"
  region = "fra1"
  size   = "s-1vcpu-2gb"
  ipv6   = true
  ssh_keys = [
    digitalocean_ssh_key.terraform.id
  ]

  connection {
    host        = self.ipv4_address
    user        = "root"
    type        = "ssh"
    private_key = file(var.private_key_file)
    timeout     = "2m"
  }

  provisioner "local-exec" {
    command = "echo ${self.ipv4_address} > inventory.ini"
  }

  provisioner "local-exec" {
    command = "ansible-playbook --private-key ${var.private_key_file} site.yml"
  }
}
