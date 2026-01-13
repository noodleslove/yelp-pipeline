resource "google_service_account" "composer_service_account" {
  project      = var.project
  account_id   = "composer-sa-${random_id.id.hex}"
  display_name = "Service Account for Cloud Composer"
}

resource "google_service_iam_member" "composer_sa_roles" {
  for_each = toset([
    "roles/cloudrun.admin",
    "roles/composer.worker",
    "roles/compute.admin",
    "roles/dataproc.admin",
    "roles/storage.admin",
    "roles/storage.objectAdmin",
    "roles/storage.transferAdmin",
  ])

  project = var.project
  role    = each.key
  member  = "serviceAccount:${google_service_account.composer_service_account.email}"

  depends_on = [google_service_account.composer_service_account]
}

resource "google_composer_environment" "yelp_environment" {
  name   = var.composer_environment_name
  region = var.composer_environment_region

  config {
    environment_size = "ENVIRONMENT_SIZE_SMALL"

    software_config {
      image_version = var.composer_environment_image_version
    }

    node_config {
      service_account = google_service_account.composer_service_account.email
    }
  }

  depends_on = [google_service_iam_member.composer_sa_roles]
}
