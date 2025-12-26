from pyspark.sql import SparkSession
from pyspark.sql.types import (
    StructType,
    StructField,
    StringType,
    FloatType,
    IntegerType,
)
from argparse import ArgumentParser

parser = ArgumentParser()

parser.add_argument(
    "--input_path",
    type=str,
    required=True,
    help="GCS file path to the business data.",
)
parser.add_argument(
    "--dataset",
    type=str,
    required=True,
    help="BigQuery dataset to ingest the business data into.",
)
parser.add_argument(
    "--table",
    type=str,
    required=True,
    help="BigQuery table to ingest the business data into.",
)
parser.add_argument("--temp-gcs-bucket", type=str, required=True)

args = parser.parse_args()

spark = SparkSession.builder.appName("ingest_business_data").getOrCreate()

# Schema
business_schema = StructType(
    [
        StructField("business_id", StringType(), True),
        StructField("name", StringType(), True),
        StructField("address", StringType(), True),
        StructField("city", StringType(), True),
        StructField("state", StringType(), True),
        StructField("postal_code", StringType(), True),
        StructField("latitude", FloatType(), True),
        StructField("longitude", FloatType(), True),
        StructField("stars", FloatType(), True),
        StructField("review_count", IntegerType(), True),
        StructField("is_open", IntegerType(), True),
        StructField("categories", StringType(), True),
    ]
)

# Read data
df = spark.read.schema(business_schema).json(args.input_path)

# Write to BigQuery
(
    df.write.format("bigquery")
    .option("temporaryGcsBucket", args.temp_gcs_bucket)
    .option("dataset", args.dataset)
    .option("table", args.table)
    .mode("overwrite")
    .save()
)
