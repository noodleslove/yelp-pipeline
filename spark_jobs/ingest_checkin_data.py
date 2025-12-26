from pyspark.sql import SparkSession
from pyspark.sql.types import StructType, StructField, StringType
from argparse import ArgumentParser

parser = ArgumentParser()

parser.add_argument(
    "--input_path",
    type=str,
    required=True,
    help="GCS file path to the checkin data.",
)
parser.add_argument(
    "--dataset",
    type=str,
    required=True,
    help="BigQuery dataset to ingest the checkin data into.",
)
parser.add_argument(
    "--table",
    type=str,
    required=True,
    help="BigQuery table to ingest the checkin data into.",
)
parser.add_argument("--temp-gcs-bucket", type=str, required=True)

args = parser.parse_args()

spark = SparkSession.builder.appName("ingest_checkin_data").getOrCreate()

# Schema
checkin_schema = StructType(
    [
        StructField("business_id", StringType(), True),
        StructField("date", StringType(), True),
    ]
)

# Read data
df = spark.read.schema(checkin_schema).json(args.input_path)

# Write to BigQuery
(
    df.write.format("bigquery")
    .option("temporaryGcsBucket", args.temp_gcs_bucket)
    .option("dataset", args.dataset)
    .option("table", args.table)
    .mode("overwrite")
    .save()
)
