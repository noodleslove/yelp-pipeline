resource "google_storage_bucket" "dataproc_staging_bucket" {
  name                        = var.dataproc_staging_bucket_name
  location                    = var.dataproc_staging_bucket_location
  storage_class               = var.dataproc_staging_bucket_storage_class
  uniform_bucket_level_access = var.dataproc_staging_bucket_uniform_bucket_level_access
  public_access_prevention    = var.dataproc_staging_bucket_public_access_prevention

  lifecycle_rule {
    action {
      type = var.dataproc_staging_bucket_lifecycle_rule_action_type
    }
    condition {
      age = var.dataproc_staging_bucket_lifecycle_rule_age
    }
  }

  force_destroy = var.dataproc_staging_bucket_force_destroy
}

resource "google_storage_bucket" "dataproc_temp_bucket" {
  name                        = var.dataproc_temp_bucket_name
  location                    = var.dataproc_temp_bucket_location
  storage_class               = var.dataproc_temp_bucket_storage_class
  uniform_bucket_level_access = var.dataproc_temp_bucket_uniform_bucket_level_access
  public_access_prevention    = var.dataproc_temp_bucket_public_access_prevention

  lifecycle_rule {
    action {
      type = var.dataproc_temp_bucket_lifecycle_rule_action_type
    }
    condition {
      age = var.dataproc_temp_bucket_lifecycle_rule_age
    }
  }

  force_destroy = var.dataproc_temp_bucket_force_destroy
}

resource "google_dataproc_cluster" "dataproc_cluster" {
  name                          = var.dataproc_cluster_name
  region                        = var.dataproc_cluster_region
  graceful_decommission_timeout = var.dataproc_cluster_graceful_decommission_timeout

  cluster_config {
    staging_bucket = google_storage_bucket.dataproc_staging_bucket.name
    temp_bucket    = google_storage_bucket.dataproc_temp_bucket.name

    master_config {
      num_instances = var.dataproc_cluster_master_config_num_instances
      machine_type  = var.dataproc_cluster_master_config_machine_type

      disk_config {
        boot_disk_type    = var.dataproc_cluster_master_config_disk_config_boot_disk_type
        boot_disk_size_gb = var.dataproc_cluster_master_config_disk_config_boot_disk_size_gb
      }
    }

    worker_config {
      num_instances = var.dataproc_cluster_worker_config_num_instances
      machine_type  = var.dataproc_cluster_worker_config_machine_type

      disk_config {
        boot_disk_type    = var.dataproc_cluster_worker_config_disk_config_boot_disk_type
        boot_disk_size_gb = var.dataproc_cluster_worker_config_disk_config_boot_disk_size_gb
      }
    }

    software_config {
      image_version = var.dataproc_cluster_software_config_image_version
      override_properties = {
        "dataproc:dataproc.allow.zero.workers" = var.dataproc_cluster_software_config_allow_zero_workers
      }
    }
  }

  depends_on = [google_storage_bucket.dataproc_staging_bucket, google_storage_bucket.dataproc_temp_bucket]
}
