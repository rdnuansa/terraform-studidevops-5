terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.53.1"
    }
  }
}

provider "google" {   
  project = var.project
  region  = var.region
  zone    = var.zone
}

resource "google_compute_instance" "vm_instance" {
  count        = length(var.vm_name)
  name         = var.vm_name[count.index]
  machine_type = var.vm_machine_type[count.index]
  zone         = var.vm_zone

  allow_stopping_for_update = true

  boot_disk {
    initialize_params {
      image = var.vm_image
    }
  }

  network_interface {
    network    = var.vpc_id
    subnetwork = var.vpc_subnetwork_id

    access_config {
      // Ephemeral public IP
      network_tier = "STANDARD"
    }
  }


  tags = var.vm_tags
  metadata = {
    ssh-keys : "admin:${var.ssh_pubkey}"
  }
}