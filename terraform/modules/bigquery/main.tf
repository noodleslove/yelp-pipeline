resource "google_bigquery_dataset" "staging_dataset" {
  dataset_id                 = var.bigquery_staging_dataset_id
  project                    = var.project
  location                   = var.bigquery_staging_dataset_location
  description                = var.bigquery_staging_dataset_description
  delete_contents_on_destroy = var.bigquery_staging_dataset_delete_contents_on_destroy
}

resource "google_bigquery_dataset" "dbt_dataset" {
  dataset_id                 = var.bigquery_dbt_dataset_id
  project                    = var.project
  location                   = var.bigquery_dbt_dataset_location
  description                = var.bigquery_dbt_dataset_description
  delete_contents_on_destroy = var.bigquery_dbt_dataset_delete_contents_on_destroy
}

resource "google_bigquery_table" "business_staging_table" {
  dataset_id          = google_bigquery_dataset.staging_dataset.dataset_id
  table_id            = var.bigquery_business_staging_table_id
  description         = var.bigquery_business_staging_table_description
  deletion_protection = var.bigquery_business_staging_table_deletion_protection
  schema              = local.bigquery_business_staging_table_schema

  range_partitioning {
    field = var.bigquery_business_staging_table_partition_column

    range {
      start    = 0
      end      = 2
      interval = 1
    }
  }

  depends_on = [google_bigquery_dataset.staging_dataset]
}

resource "google_bigquery_table" "checkin_staging_table" {
  dataset_id          = google_bigquery_dataset.staging_dataset.dataset_id
  table_id            = var.bigquery_checkin_staging_table_id
  description         = var.bigquery_checkin_staging_table_description
  deletion_protection = var.bigquery_checkin_staging_table_deletion_protection
  schema              = local.bigquery_checkin_staging_table_schema

  depends_on = [google_bigquery_dataset.staging_dataset]
}

resource "google_bigquery_table" "review_staging_table" {
  dataset_id          = google_bigquery_dataset.staging_dataset.dataset_id
  table_id            = var.bigquery_review_staging_table_id
  description         = var.bigquery_review_staging_table_description
  deletion_protection = var.bigquery_review_staging_table_deletion_protection
  schema              = local.bigquery_review_staging_table_schema

  depends_on = [google_bigquery_dataset.staging_dataset]
}

resource "google_bigquery_table" "user_staging_table" {
  dataset_id          = google_bigquery_dataset.staging_dataset.dataset_id
  table_id            = var.bigquery_user_staging_table_id
  description         = var.bigquery_user_staging_table_description
  deletion_protection = var.bigquery_user_staging_table_deletion_protection
  schema              = local.bigquery_user_staging_table_schema

  depends_on = [google_bigquery_dataset.staging_dataset]
}

resource "google_bigquery_table" "tips_staging_table" {
  dataset_id          = google_bigquery_dataset.staging_dataset.dataset_id
  table_id            = var.bigquery_tips_staging_table_id
  description         = var.bigquery_tips_staging_table_description
  deletion_protection = var.bigquery_tips_staging_table_deletion_protection
  schema              = local.bigquery_tips_staging_table_schema

  depends_on = [google_bigquery_dataset.staging_dataset]
}
