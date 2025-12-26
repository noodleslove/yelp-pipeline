locals {
  bigquery_business_staging_table_schema = file(var.bigquery_business_staging_table_schema_filepath)
  bigquery_checkin_staging_table_schema  = file(var.bigquery_checkin_staging_table_schema_filepath)
  bigquery_review_staging_table_schema   = file(var.bigquery_review_staging_table_schema_filepath)
  bigquery_user_staging_table_schema     = file(var.bigquery_user_staging_table_schema_filepath)
  bigquery_tips_staging_table_schema     = file(var.bigquery_tips_staging_table_schema_filepath)
}

variable "project" {
  description = "The project ID to create the datasets and tables in."
  type        = string
}

# ======================================================
# BigQuery Staging Dataset
# ======================================================

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

# ======================================================
# BigQuery DBT Dataset
# ======================================================

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

# ======================================================
# BigQuery Business Staging Table
# ======================================================

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

variable "bigquery_staging_business_table_partition_column" {
  description = "The column to partition the staging business table by."
  type        = string
}

# ======================================================
# BigQuery Check-in Staging Table
# ======================================================

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

# ======================================================
# BigQuery Review Staging Table
# ======================================================

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

# ======================================================
# BigQuery User Staging Table
# ======================================================

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

# ======================================================
# BigQuery Tips Staging Table
# ======================================================

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
