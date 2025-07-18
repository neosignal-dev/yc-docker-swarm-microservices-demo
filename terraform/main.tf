terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = ">= 0.89"
    }
  }
}

provider "yandex" {
  service_account_key_file = "${path.module}/key.json"
  cloud_id  = var.cloud_id
  folder_id = var.folder_id
  zone      = var.zone
}

resource "yandex_vpc_network" "swarm_net" {
  name = "swarm-network"
}

resource "yandex_vpc_subnet" "swarm_subnet" {
  name           = "swarm-subnet"
  zone           = var.zone
  network_id     = yandex_vpc_network.swarm_net.id
  v4_cidr_blocks = ["10.0.0.0/24"]
}

resource "yandex_compute_instance" "swarm_nodes" {
  count = 3
  name  = "swarm-${count.index}"

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = "fd80bm0rh4rkepi5ksdi" # ubuntu-22-04-lts-v20230925
    }
  }

network_interface {
  subnet_id = yandex_vpc_subnet.swarm_subnet.id
  nat       = true
}

  metadata = {
    ssh-keys = "ubuntu:${var.ssh_key}"
  }
}
