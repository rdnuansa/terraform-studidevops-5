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

resource "google_compute_network" "vpc" {
  name                    = var.vpc_name
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "private_subnet" {
  name          = "subnet-${var.vpc_name}"
  ip_cidr_range = var.subnet_cidr
  region        = var.subnet_region
  network       = google_compute_network.vpc.id
}

resource "google_compute_firewall" "fw_rules" {
  project     = var.project
  name        = "firewall-${var.vpc_name}"
  network     = google_compute_network.vpc.id
  description = "Creates default firewall rule to allow HTTP and SSH"

  allow {
    protocol = "tcp"
    ports    = ["22", "80"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["webserver"]
}

resource "google_compute_firewall" "fw_rules_https" {
  project     = var.project
  name        = "firewall-${var.vpc_name}-allow-https"
  network     = google_compute_network.vpc.id
  description = "Creates default firewall rule to allow HTTPS"

  allow {
    protocol = "tcp"
    ports    = ["443"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["allow-https"]
}