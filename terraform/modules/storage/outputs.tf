output "ingest_business_data_script_uri" {
  value = google_storage_bucket_object.ingest_business_data.output_name
}

output "ingest_checkin_data_script_uri" {
  value = google_storage_bucket_object.ingest_checkin_data.output_name
}

output "ingest_review_data_script_uri" {
  value = google_storage_bucket_object.ingest_review_data.output_name
}

output "ingest_tip_data_script_uri" {
  value = google_storage_bucket_object.ingest_tip_data.output_name
}

output "ingest_user_data_script_uri" {
  value = google_storage_bucket_object.ingest_user_data.output_name
}

output "datalake_url" {
  value = google_storage_bucket.datalake.url
}
