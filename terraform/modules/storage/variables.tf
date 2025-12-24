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
