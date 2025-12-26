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
    help="GCS file path to the review data.",
)
parser.add_argument(
    "--dataset",
    type=str,
    required=True,
    help="BigQuery dataset to ingest the review data into.",
)
parser.add_argument(
    "--table",
    type=str,
    required=True,
    help="BigQuery table to ingest the review data into.",
)
parser.add_argument("--temp-gcs-bucket", type=str, required=True)

args = parser.parse_args()

spark = SparkSession.builder.appName("ingest_review_data").getOrCreate()

# Schema
review_schema = StructType(
    [
        StructField("review_id", StringType(), True),
        StructField("user_id", StringType(), True),
        StructField("business_id", StringType(), True),
        StructField("stars", IntegerType(), True),
        StructField("cool", IntegerType(), True),
        StructField("date", TimestampType(), True),
        StructField("funny", IntegerType(), True),
        StructField("useful", IntegerType(), True),
        StructField("text", StringType(), True),
    ]
)

# Read data
df = spark.read.schema(review_schema).json(args.input_path)

# Write to BigQuery
(
    df.write.format("bigquery")
    .option("temporaryGcsBucket", args.temp_gcs_bucket)
    .option("dataset", args.dataset)
    .option("table", args.table)
    .mode("overwrite")
    .save()
)
