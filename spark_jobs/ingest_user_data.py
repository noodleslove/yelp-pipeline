from pyspark.sql import SparkSession
from pyspark.sql.types import (
    StructType,
    StructField,
    StringType,
    IntegerType,
    FloatType,
    TimestampType,
)
from argparse import ArgumentParser

parser = ArgumentParser()

parser.add_argument(
    "--input_path",
    type=str,
    required=True,
    help="GCS file path to the user data.",
)
parser.add_argument(
    "--dataset",
    type=str,
    required=True,
    help="BigQuery dataset to ingest the user data into.",
)
parser.add_argument(
    "--table",
    type=str,
    required=True,
    help="BigQuery table to ingest the user data into.",
)
parser.add_argument("--temp-gcs-bucket", type=str, required=True)

args = parser.parse_args()

spark = SparkSession.builder.appName("ingest_user_data").getOrCreate()

# Schema
user_schema = StructType(
    [
        StructField("user_id", StringType(), True),
        StructField("name", StringType(), True),
        StructField("review_count", IntegerType(), True),
        StructField("yelping_since", TimestampType(), True),
        StructField("useful", IntegerType(), True),
        StructField("funny", IntegerType(), True),
        StructField("cool", IntegerType(), True),
        StructField("fans", IntegerType(), True),
        StructField("average_stars", FloatType(), True),
    ]
)

# Read data
df = spark.read.schema(user_schema).json(args.input_path)

# Write to BigQuery
(
    df.write.format("bigquery")
    .option("temporaryGcsBucket", args.temp_gcs_bucket)
    .option("dataset", args.dataset)
    .option("table", args.table)
    .mode("overwrite")
    .save()
)
