project = "eddie-brain"
region  = "us-west1"

# Storage Variables
datalake_name                        = "yelp-datalake-uswest1"
datalake_location                    = "us-west1"
datalake_storage_class               = "STANDARD"
datalake_uniform_bucket_level_access = true
datalake_public_access_prevention    = "enforced"
datalake_lifecycle_rule_action_type  = "Delete"
datalake_lifecycle_rule_age          = 30
datalake_force_destroy               = true

ingest_business_data_script_filepath = "../spark_jobs/ingest_business_data.py"
ingest_checkin_data_script_filepath = "../spark_jobs/ingest_checkin_data.py"
ingest_review_data_script_filepath = "../spark_jobs/ingest_review_data.py"
ingest_tip_data_script_filepath = "../spark_jobs/ingest_tip_data.py"
ingest_user_data_script_filepath = "../spark_jobs/ingest_user_data.py"

# BigQuery Variables
bigquery_staging_dataset_id                         = "yelp_staging"
bigquery_staging_dataset_location                   = "us-west1"
bigquery_staging_dataset_description                = "Staging dataset for Yelp data"
bigquery_staging_dataset_delete_contents_on_destroy = true

bigquery_dbt_dataset_id                         = "yelp_dbt"
bigquery_dbt_dataset_location                   = "us-west1"
bigquery_dbt_dataset_description                = "DBT dataset for Yelp data"
bigquery_dbt_dataset_delete_contents_on_destroy = true

bigquery_business_staging_table_id                  = "stg_business"
bigquery_business_staging_table_description         = "Staging table for Yelp businesses"
bigquery_business_staging_table_deletion_protection = false
bigquery_business_staging_table_partition_column    = "is_open"
bigquery_business_staging_table_schema_filepath     = "modules/bigquery/schemas/businesses.json"

bigquery_checkin_staging_table_id                  = "stg_checkin"
bigquery_checkin_staging_table_description         = "Staging table for Yelp checkins"
bigquery_checkin_staging_table_deletion_protection = false
bigquery_checkin_staging_table_schema_filepath     = "modules/bigquery/schemas/checkins.json"

bigquery_review_staging_table_id                  = "stg_review"
bigquery_review_staging_table_description         = "Staging table for Yelp reviews"
bigquery_review_staging_table_deletion_protection = false
bigquery_review_staging_table_schema_filepath     = "modules/bigquery/schemas/reviews.json"

bigquery_user_staging_table_id                  = "stg_user"
bigquery_user_staging_table_description         = "Staging table for Yelp users"
bigquery_user_staging_table_deletion_protection = false
bigquery_user_staging_table_schema_filepath     = "modules/bigquery/schemas/users.json"

bigquery_tips_staging_table_id                  = "stg_tip"
bigquery_tips_staging_table_description         = "Staging table for Yelp tips"
bigquery_tips_staging_table_deletion_protection = false
bigquery_tips_staging_table_schema_filepath     = "modules/bigquery/schemas/tips.json"

# Dataproc Variables
dataproc_staging_bucket_name                        = "yelp-dataproc-staging-uswest1"
dataproc_staging_bucket_location                    = "us-west1"
dataproc_staging_bucket_storage_class               = "STANDARD"
dataproc_staging_bucket_uniform_bucket_level_access = true
dataproc_staging_bucket_public_access_prevention    = "enforced"
dataproc_staging_bucket_lifecycle_rule_action_type  = "Delete"
dataproc_staging_bucket_lifecycle_rule_age          = 30
dataproc_staging_bucket_force_destroy               = true

dataproc_temp_bucket_name                        = "yelp-dataproc-temp-uswest1"
dataproc_temp_bucket_location                    = "us-west1"
dataproc_temp_bucket_storage_class               = "STANDARD"
dataproc_temp_bucket_uniform_bucket_level_access = true
dataproc_temp_bucket_public_access_prevention    = "enforced"
dataproc_temp_bucket_lifecycle_rule_action_type  = "Delete"
dataproc_temp_bucket_lifecycle_rule_age          = 30
dataproc_temp_bucket_force_destroy               = true

dataproc_cluster_name                                        = "yelp-dataproc-cluster-uswest1"
dataproc_cluster_region                                      = "us-west1"
dataproc_cluster_graceful_decommission_timeout               = "120s"
dataproc_cluster_master_config_num_instances                 = 1
dataproc_cluster_master_config_machine_type                  = "e2-standard-2"
dataproc_cluster_master_config_disk_config_boot_disk_type    = "pd-standard"
dataproc_cluster_master_config_disk_config_boot_disk_size_gb = 30
dataproc_cluster_worker_config_num_instances                 = 2
dataproc_cluster_worker_config_machine_type                  = "e2-standard-2"
dataproc_cluster_worker_config_disk_config_boot_disk_type    = "pd-standard"
dataproc_cluster_worker_config_disk_config_boot_disk_size_gb = 30
dataproc_cluster_software_config_image_version               = "2.1.4-ubuntu20"
dataproc_cluster_software_config_allow_zero_workers          = "true"
