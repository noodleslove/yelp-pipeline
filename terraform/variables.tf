variable "project" {}

variable "region" {
  default = "us-west1"
}

# ======================================================
# Storage Modules
# ======================================================

variable "datalake_name" {
  type = string
}

variable "datalake_location" {
  description = "Region for the data lake."
  type        = string
}

variable "datalake_storage_class" {
  description = "Storage class type for your bucket."
  type        = string
}

variable "datalake_uniform_bucket_level_access" {
  description = "Enable uniform bucket level access in data lake."
  type        = bool
}

variable "datalake_public_access_prevention" {
  description = "Public access prevention for the datalake."
  type        = string
}

variable "datalake_lifecycle_rule_action_type" {
  description = "Action for life cycle rule in data lake."
  type        = string
}

variable "datalake_lifecycle_rule_age" {
  description = "Age in days for life cycle rule in data lake."
  type        = number
}

variable "datalake_force_destroy" {
  description = "Enable force destroy for data lake."
  type        = bool
}

variable "ingest_business_data_script_filepath" {
  description = "Path to the ingest_business_data script"
  type        = string
}

variable "ingest_checkin_data_script_filepath" {
  description = "Path to the ingest_checkin_data script"
  type        = string
}

variable "ingest_review_data_script_filepath" {
  description = "Path to the ingest_review_data script"
  type        = string
}

variable "ingest_tip_data_script_filepath" {
  description = "Path to the ingest_tip_data script"
  type        = string
}

variable "ingest_user_data_script_filepath" {
  description = "Path to the ingest_user_data script"
  type        = string
}

# ======================================================
# BigQuery Modules
# ======================================================

# BigQuery Staging Dataset
variable "bigquery_staging_dataset_id" {
  description = "The name of the staging dataset."
  type        = string
}

variable "bigquery_staging_dataset_location" {
  description = "The region of the staging dataset."
  type        = string
}

variable "bigquery_staging_dataset_description" {
  description = "The description of the staging dataset."
  type        = string
}

variable "bigquery_staging_dataset_delete_contents_on_destroy" {
  description = "Whether to delete the contents of the staging dataset when the dataset is destroyed."
  type        = bool
}

# BigQuery DBT Dataset
variable "bigquery_dbt_dataset_id" {
  description = "The name of the dbt dataset."
  type        = string
}

variable "bigquery_dbt_dataset_location" {
  description = "The region of the dbt dataset."
  type        = string
}

variable "bigquery_dbt_dataset_description" {
  description = "The description of the dbt dataset."
  type        = string
}

variable "bigquery_dbt_dataset_delete_contents_on_destroy" {
  description = "Whether to delete the contents of the dbt dataset when the dataset is destroyed."
  type        = bool
}

# BigQuery Business Staging Table
variable "bigquery_business_staging_table_id" {
  description = "The name of the business staging table."
  type        = string
}

variable "bigquery_business_staging_table_description" {
  description = "The description of the business staging table."
  type        = string
}

variable "bigquery_business_staging_table_deletion_protection" {
  description = "Whether to protect the business staging table from deletion."
  type        = bool
}

variable "bigquery_business_staging_table_partition_column" {
  description = "The column to partition the business staging table by."
  type        = string
}

variable "bigquery_business_staging_table_schema_filepath" {
  description = "The filepath to the business staging table schema."
  type        = string
}

# BigQuery Check-in Staging Table
variable "bigquery_checkin_staging_table_id" {
  description = "The name of the check-in staging table."
  type        = string
}

variable "bigquery_checkin_staging_table_description" {
  description = "The description of the business table."
  type        = string
}

variable "bigquery_checkin_staging_table_deletion_protection" {
  description = "Whether to protect the check-in staging table from deletion."
  type        = bool
}

variable "bigquery_checkin_staging_table_schema_filepath" {
  description = "The filepath to the check-in staging table schema."
  type        = string
}

# BigQuery Review Staging Table
variable "bigquery_review_staging_table_id" {
  description = "The name of the review staging table."
  type        = string
}

variable "bigquery_review_staging_table_description" {
  description = "The description of the review table."
  type        = string
}

variable "bigquery_review_staging_table_deletion_protection" {
  description = "Whether to protect the review staging table from deletion."
  type        = bool
}

variable "bigquery_review_staging_table_schema_filepath" {
  description = "The filepath to the review staging table schema."
  type        = string
}

# BigQuery User Staging Table
variable "bigquery_user_staging_table_id" {
  description = "The name of the user staging table."
  type        = string
}

variable "bigquery_user_staging_table_description" {
  description = "The description of the user table."
  type        = string
}

variable "bigquery_user_staging_table_deletion_protection" {
  description = "Whether to protect the user staging table from deletion."
  type        = bool
}

variable "bigquery_user_staging_table_schema_filepath" {
  description = "The filepath to the user staging table schema."
  type        = string
}

# BigQuery Tips Staging Table
variable "bigquery_tips_staging_table_id" {
  description = "The name of the tips staging table."
  type        = string
}

variable "bigquery_tips_staging_table_description" {
  description = "The description of the tips table."
  type        = string
}

variable "bigquery_tips_staging_table_deletion_protection" {
  description = "Whether to protect the tips staging table from deletion."
  type        = bool
}

variable "bigquery_tips_staging_table_schema_filepath" {
  description = "The filepath to the tips staging table schema."
  type        = string
}

# ======================================================
# Dataproc Modules
# ======================================================

variable "dataproc_staging_bucket_name" {
  type = string
}

variable "dataproc_staging_bucket_location" {
  type = string
}

variable "dataproc_staging_bucket_storage_class" {
  type = string
}

variable "dataproc_staging_bucket_uniform_bucket_level_access" {
  type = bool
}

variable "dataproc_staging_bucket_public_access_prevention" {
  type = string
}

variable "dataproc_staging_bucket_lifecycle_rule_action_type" {
  type = string
}

variable "dataproc_staging_bucket_lifecycle_rule_age" {
  type = number
}

variable "dataproc_staging_bucket_force_destroy" {
  type = bool
}

variable "dataproc_temp_bucket_name" {
  type = string
}

variable "dataproc_temp_bucket_location" {
  type = string
}

variable "dataproc_temp_bucket_storage_class" {
  type = string
}

variable "dataproc_temp_bucket_uniform_bucket_level_access" {
  type = bool
}

variable "dataproc_temp_bucket_public_access_prevention" {
  type = string
}

variable "dataproc_temp_bucket_lifecycle_rule_action_type" {
  type = string
}

variable "dataproc_temp_bucket_lifecycle_rule_age" {
  type = number
}

variable "dataproc_temp_bucket_force_destroy" {
  type = bool
}

variable "dataproc_cluster_name" {
  type = string
}

variable "dataproc_cluster_region" {
  type = string
}

variable "dataproc_cluster_graceful_decommission_timeout" {
  type = string
}

variable "dataproc_cluster_master_config_num_instances" {
  type = number
}

variable "dataproc_cluster_master_config_machine_type" {
  type = string
}

variable "dataproc_cluster_master_config_disk_config_boot_disk_type" {
  type = string
}

variable "dataproc_cluster_master_config_disk_config_boot_disk_size_gb" {
  type = number
}

variable "dataproc_cluster_worker_config_num_instances" {
  type = number
}

variable "dataproc_cluster_worker_config_machine_type" {
  type = string
}

variable "dataproc_cluster_worker_config_disk_config_boot_disk_type" {
  type = string
}

variable "dataproc_cluster_worker_config_disk_config_boot_disk_size_gb" {
  type = number
}

variable "dataproc_cluster_software_config_image_version" {
  type = string
}

variable "dataproc_cluster_software_config_allow_zero_workers" {
  type = string
}
