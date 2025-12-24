project = "eddie-brain"
region = "us-west1"

# Storage Variables
datalake_name = "yelp-datalake-uswest1"
datalake_location = "us-west1"
datalake_storage_class = "STANDARD"
datalake_uniform_bucket_level_access = true
datalake_public_access_prevention = "enforced"
datalake_lifecycle_rule_action_type = "Delete"
datalake_lifecycle_rule_age = 30
datalake_force_destroy = true

# BigQuery Variables
bigquery_staging_dataset_id = "yelp_staging"
bigquery_staging_dataset_location = "us-west1"
bigquery_staging_dataset_description = "Staging dataset for Yelp data"
bigquery_staging_dataset_delete_contents_on_destroy = true

bigquery_dbt_dataset_id = "yelp_dbt"
bigquery_dbt_dataset_location = "us-west1"
bigquery_dbt_dataset_description = "DBT dataset for Yelp data"
bigquery_dbt_dataset_delete_contents_on_destroy = true

bigquery_business_staging_table_id = "stg_business"
bigquery_business_staging_table_description = "Staging table for Yelp businesses"
bigquery_business_staging_table_deletion_protection = false
bigquery_business_staging_table_partition_column = "is_open"
bigquery_business_staging_table_schema_filepath = "modules/bigquery/schemas/business.json"

bigquery_checkin_staging_table_id = "stg_checkin"
bigquery_checkin_staging_table_description = "Staging table for Yelp checkins"
bigquery_checkin_staging_table_deletion_protection = false
bigquery_checkin_staging_table_schema_filepath = "modules/bigquery/schemas/checkin.json"

bigquery_review_staging_table_id = "stg_review"
bigquery_review_staging_table_description = "Staging table for Yelp reviews"
bigquery_review_staging_table_deletion_protection = false
bigquery_review_staging_table_schema_filepath = "modules/bigquery/schemas/review.json"

bigquery_user_staging_table_id = "stg_user"
bigquery_user_staging_table_description = "Staging table for Yelp users"
bigquery_user_staging_table_deletion_protection = false
bigquery_user_staging_table_schema_filepath = "modules/bigquery/schemas/user.json"

bigquery_tips_staging_table_id = "stg_tip"
bigquery_tips_staging_table_description = "Staging table for Yelp tips"
bigquery_tips_staging_table_deletion_protection = false
bigquery_tips_staging_table_schema_filepath = "modules/bigquery/schemas/tip.json"
