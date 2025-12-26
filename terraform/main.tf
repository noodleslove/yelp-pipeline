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
}

module "api" {
  source = "./modules/api"
}

module "storage" {
  source = "./modules/storage"

  datalake_name                        = var.datalake_name
  datalake_location                    = var.datalake_location
  datalake_storage_class               = var.datalake_storage_class
  datalake_uniform_bucket_level_access = var.datalake_uniform_bucket_level_access
  datalake_public_access_prevention    = var.datalake_public_access_prevention
  datalake_lifecycle_rule_action_type  = var.datalake_lifecycle_rule_action_type
  datalake_lifecycle_rule_age          = var.datalake_lifecycle_rule_age
  datalake_force_destroy               = var.datalake_force_destroy

  ingest_business_data_script_filepath = var.ingest_business_data_script_filepath
  ingest_checkin_data_script_filepath  = var.ingest_checkin_data_script_filepath
  ingest_review_data_script_filepath   = var.ingest_review_data_script_filepath
  ingest_tip_data_script_filepath      = var.ingest_tip_data_script_filepath
  ingest_user_data_script_filepath     = var.ingest_user_data_script_filepath

  depends_on = [module.api]
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
  bigquery_staging_business_table_partition_column    = var.bigquery_business_staging_table_partition_column

  # Check-in Staging Table
  bigquery_checkin_staging_table_id                  = var.bigquery_checkin_staging_table_id
  bigquery_checkin_staging_table_description         = var.bigquery_checkin_staging_table_description
  bigquery_checkin_staging_table_deletion_protection = var.bigquery_checkin_staging_table_deletion_protection
  bigquery_checkin_staging_table_schema_filepath     = var.bigquery_checkin_staging_table_schema_filepath

  # Review Staging Table
  bigquery_review_staging_table_id                  = var.bigquery_review_staging_table_id
  bigquery_review_staging_table_description         = var.bigquery_review_staging_table_description
  bigquery_review_staging_table_deletion_protection = var.bigquery_review_staging_table_deletion_protection
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

module "dataproc" {
  source = "./modules/dataproc"

  dataproc_staging_bucket_name                        = var.dataproc_staging_bucket_name
  dataproc_staging_bucket_location                    = var.dataproc_staging_bucket_location
  dataproc_staging_bucket_storage_class               = var.dataproc_staging_bucket_storage_class
  dataproc_staging_bucket_uniform_bucket_level_access = var.dataproc_staging_bucket_uniform_bucket_level_access
  dataproc_staging_bucket_public_access_prevention    = var.dataproc_staging_bucket_public_access_prevention
  dataproc_staging_bucket_lifecycle_rule_action_type  = var.dataproc_staging_bucket_lifecycle_rule_action_type
  dataproc_staging_bucket_lifecycle_rule_age          = var.dataproc_staging_bucket_lifecycle_rule_age
  dataproc_staging_bucket_force_destroy               = var.dataproc_staging_bucket_force_destroy

  dataproc_temp_bucket_name                        = var.dataproc_temp_bucket_name
  dataproc_temp_bucket_location                    = var.dataproc_temp_bucket_location
  dataproc_temp_bucket_storage_class               = var.dataproc_temp_bucket_storage_class
  dataproc_temp_bucket_uniform_bucket_level_access = var.dataproc_temp_bucket_uniform_bucket_level_access
  dataproc_temp_bucket_public_access_prevention    = var.dataproc_temp_bucket_public_access_prevention
  dataproc_temp_bucket_lifecycle_rule_action_type  = var.dataproc_temp_bucket_lifecycle_rule_action_type
  dataproc_temp_bucket_lifecycle_rule_age          = var.dataproc_temp_bucket_lifecycle_rule_age
  dataproc_temp_bucket_force_destroy               = var.dataproc_temp_bucket_force_destroy

  dataproc_cluster_name                                        = var.dataproc_cluster_name
  dataproc_cluster_region                                      = var.dataproc_cluster_region
  dataproc_cluster_graceful_decommission_timeout               = var.dataproc_cluster_graceful_decommission_timeout
  dataproc_cluster_master_config_num_instances                 = var.dataproc_cluster_master_config_num_instances
  dataproc_cluster_master_config_machine_type                  = var.dataproc_cluster_master_config_machine_type
  dataproc_cluster_master_config_disk_config_boot_disk_type    = var.dataproc_cluster_master_config_disk_config_boot_disk_type
  dataproc_cluster_master_config_disk_config_boot_disk_size_gb = var.dataproc_cluster_master_config_disk_config_boot_disk_size_gb
  dataproc_cluster_worker_config_num_instances                 = var.dataproc_cluster_worker_config_num_instances
  dataproc_cluster_worker_config_machine_type                  = var.dataproc_cluster_worker_config_machine_type
  dataproc_cluster_worker_config_disk_config_boot_disk_type    = var.dataproc_cluster_worker_config_disk_config_boot_disk_type
  dataproc_cluster_worker_config_disk_config_boot_disk_size_gb = var.dataproc_cluster_worker_config_disk_config_boot_disk_size_gb
  dataproc_cluster_software_config_image_version               = var.dataproc_cluster_software_config_image_version
  dataproc_cluster_software_config_allow_zero_workers          = var.dataproc_cluster_software_config_allow_zero_workers
}
