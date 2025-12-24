terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "6.8.0"
    }
  }
}

provider "google" {
  project = var.project
  region  = var.region
  zone    = var.zone
}

module "api" {
  source = "./modules/api"
}

module "bigquery" {
  source = "./modules/bigquery"

  project = var.project

  # Staging Dataset
  bigquery_staging_dataset_id                         = var.bigquery_staging_dataset_id
  bigquery_staging_dataset_location                   = var.bigquery_staging_dataset_location
  bigquery_staging_dataset_description                = var.bigquery_staging_dataset_description
  bigquery_staging_dataset_delete_contents_on_destroy = var.bigquery_staging_dataset_delete_contents_on_destroy

  # DBT Dataset
  bigquery_dbt_dataset_id                         = var.bigquery_dbt_dataset_id
  bigquery_dbt_dataset_location                   = var.bigquery_dbt_dataset_location
  bigquery_dbt_dataset_description                = var.bigquery_dbt_dataset_description
  bigquery_dbt_dataset_delete_contents_on_destroy = var.bigquery_dbt_dataset_delete_contents_on_destroy

  # Business Staging Table
  bigquery_business_staging_table_id                  = var.bigquery_business_staging_table_id
  bigquery_business_staging_table_description         = var.bigquery_business_staging_table_description
  bigquery_business_staging_table_deletion_protection = var.bigquery_business_staging_table_deletion_protection
  bigquery_business_staging_table_partition_column    = var.bigquery_business_staging_table_partition_column
  bigquery_business_staging_table_schema_filepath     = var.bigquery_business_staging_table_schema_filepath
  bigquery_staging_business_table_partition_column    = var.bigquery_staging_business_table_partition_column

  # Check-in Staging Table
  bigquery_checkin_staging_table_id                  = var.bigquery_checkin_staging_table_id
  bigquery_checkin_staging_table_description         = var.bigquery_checkin_staging_table_description
  bigquery_checkin_staging_table_deletion_protection = var.bigquery_checkin_staging_table_deletion_protection
  bigquery_checkin_staging_table_schema_filepath     = var.bigquery_checkin_staging_table_schema_filepath

  # Review Staging Table
  bigquery_review_staging_table_id                  = var.bigquery_review_staging_table_id
  bigquery_review_staging_table_description         = var.bigquery_review_staging_table_description
  bigquery_review_staging_table_deletion_protection = var.bigquery_review_staging_table_deletion_protection
  bigquery_review_staging_table_partition_column    = var.bigquery_review_staging_table_partition_column
  bigquery_review_staging_table_schema_filepath     = var.bigquery_review_staging_table_schema_filepath

  # User Staging Table
  bigquery_user_staging_table_id                  = var.bigquery_user_staging_table_id
  bigquery_user_staging_table_description         = var.bigquery_user_staging_table_description
  bigquery_user_staging_table_deletion_protection = var.bigquery_user_staging_table_deletion_protection
  bigquery_user_staging_table_schema_filepath     = var.bigquery_user_staging_table_schema_filepath

  # Tips Staging Table
  bigquery_tips_staging_table_id                  = var.bigquery_tips_staging_table_id
  bigquery_tips_staging_table_description         = var.bigquery_tips_staging_table_description
  bigquery_tips_staging_table_deletion_protection = var.bigquery_tips_staging_table_deletion_protection
  bigquery_tips_staging_table_schema_filepath     = var.bigquery_tips_staging_table_schema_filepath
}
