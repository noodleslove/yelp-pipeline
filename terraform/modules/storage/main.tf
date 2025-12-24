resource "google_storage_bucket" "datalake" {
  name                        = var.datalake_name
  location                    = var.datalake_location
  storage_class               = var.datalake_storage_class
  uniform_bucket_level_access = var.datalake_uniform_bucket_level_access
  public_access_prevention    = var.datalake_public_access_prevention

  lifecycle_rule {
    action {
      type = var.datalake_lifecycle_rule_action_type
    }
    condition {
      age = var.datalake_lifecycle_rule_age
    }
  }

  force_destroy = var.datalake_force_destroy
}

resource "google_storage_bucket_object" "ingest_business_data" {
  bucket = google_storage_bucket.datalake.name
  name   = "scripts/ingest_business_data.py"
  source = var.ingest_business_data_script_filepath

  depends_on = [google_storage_bucket.datalake]
}

resource "google_storage_bucket_object" "ingest_checkin_data" {
  bucket = google_storage_bucket.datalake.name
  name   = "scripts/ingest_checkin_data.py"
  source = var.ingest_checkin_data_script_filepath

  depends_on = [google_storage_bucket.datalake]
}

resource "google_storage_bucket_object" "ingest_review_data" {
  bucket = google_storage_bucket.datalake.name
  name   = "scripts/ingest_review_data.py"
  source = var.ingest_review_data_script_filepath

  depends_on = [google_storage_bucket.datalake]
}

resource "google_storage_bucket_object" "ingest_tip_data" {
  bucket = google_storage_bucket.datalake.name
  name   = "scripts/ingest_tip_data.py"
  source = var.ingest_tip_data_script_filepath

  depends_on = [google_storage_bucket.datalake]
}

resource "google_storage_bucket_object" "ingest_user_data" {
  bucket = google_storage_bucket.datalake.name
  name   = "scripts/ingest_user_data.py"
  source = var.ingest_user_data_script_filepath

  depends_on = [google_storage_bucket.datalake]
}
