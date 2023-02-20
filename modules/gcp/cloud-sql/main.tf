terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.53.1"
    }
  }
}

resource "google_sql_database_instance" "database_instance" {
  name             = "${var.db_name}-db-instance"
  region           = var.region
  database_version = var.db_version
  settings {
    tier = "db-f1-micro"
  }

  deletion_protection = false
}

resource "google_sql_database" "database" {
  name     = var.db_name
  instance = google_sql_database_instance.database_instance.name
}