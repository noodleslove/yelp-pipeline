from typing import Optional

import dlt
from dlt.destinations.adapters import athena_adapter, athena_partition
from dlt.sources import TDataItem
from dlt.sources.filesystem import filesystem, read_jsonl


def flatten_checkin_date(checkin: TDataItem) -> TDataItem:
    if checkin.get("date"):
        checkin["date"] = [d.strip() for d in checkin["date"].split(",")]
    return checkin


@dlt.source(name="yelp_open_dataset")
def yelp_raw_source(partition_key: Optional[str] = None):
    # ================================
    # Start of business
    @dlt.resource(
        name="business",
        write_disposition="merge",
        primary_key="business_id",
        columns={
            "business_id": {"data_type": "text", "nullable": False},
            "name": {"data_type": "text", "nullable": True},
            "address": {"data_type": "text", "nullable": True},
            "city": {"data_type": "text", "nullable": True},
            "state": {"data_type": "text", "nullable": True},
            "postal_code": {"data_type": "text", "nullable": True},
            "latitude": {"data_type": "double", "nullable": True},
            "longitude": {"data_type": "double", "nullable": True},
            "stars": {"data_type": "double", "nullable": True},
            "review_count": {"data_type": "bigint", "nullable": True},
            "is_open": {"data_type": "bool", "nullable": True},
            "attributes": {"data_type": "json", "nullable": True},
            "hours": {"data_type": "json", "nullable": True},
        },
    )
    def business():
        business_files = (
            filesystem(
                bucket_url="s3://yelpopendataset-raw-useast1-dev/raw",
                file_glob="yelp_academic_dataset_business.json",
            )
            | read_jsonl()
        )
        yield from business_files

    # Limit
    sampled_business = business().add_limit(100)
    athena_adapter(sampled_business, partition=["is_open"])
    # End of business
    # ================================

    # ================================
    # Start of checkin
    @dlt.resource(
        name="checkin",
        write_disposition="merge",
        primary_key="business_id",
        table_format="iceberg",
        columns={
            "business_id": {"data_type": "text", "nullable": False},
            "date": {"data_type": "text", "nullable": True},
        },
    )
    def checkin():
        checkin_files = (
            filesystem(
                bucket_url="s3://yelpopendataset-raw-useast1-dev/raw",
                file_glob="yelp_academic_dataset_checkin.json",
            )
            | read_jsonl()
        )
        yield from checkin_files

    # Transform and limit
    transformed_checkin = checkin().add_map(flatten_checkin_date).add_limit(100)
    # End of checkin
    # ================================

    # ================================
    # Start of review
    @dlt.resource(
        name="review",
        write_disposition="merge",
        primary_key="review_id",
        table_format="iceberg",
        columns={
            "review_id": {"data_type": "text", "nullable": False},
            "user_id": {"data_type": "text", "nullable": False},
            "business_id": {"data_type": "text", "nullable": False},
            "stars": {"data_type": "bigint", "nullable": True},
            "cool": {"data_type": "bigint", "nullable": True},
            "date": {"data_type": "timestamp", "nullable": False},
            "funny": {"data_type": "bigint", "nullable": True},
            "useful": {"data_type": "bigint", "nullable": True},
            "text": {"data_type": "text", "nullable": True},
        },
    )
    def review():
        review_files = (
            filesystem(
                bucket_url="s3://yelpopendataset-raw-useast1-dev/raw",
                file_glob="yelp_academic_dataset_review.json",
            )
            | read_jsonl()
        )
        yield from review_files

    # Transform and limit
    sampled_review = (
        review()
        .add_filter(lambda x: x["date"].startswith(partition_key))
        .add_limit(100)
    )
    athena_adapter(sampled_review, partition=[athena_partition.month("date")])
    # End of review
    # ================================

    # ================================
    # Start of user
    @dlt.resource(
        name="user",
        write_disposition="merge",
        primary_key="user_id",
        table_format="iceberg",
        columns={
            "user_id": {"data_type": "text", "nullable": False},
            "name": {"data_type": "text", "nullable": True},
            "review_count": {"data_type": "bigint", "nullable": True},
            "yelping_since": {"data_type": "timestamp", "nullable": False},
            "useful": {"data_type": "bigint", "nullable": True},
            "funny": {"data_type": "bigint", "nullable": True},
            "cool": {"data_type": "bigint", "nullable": True},
            "fans": {"data_type": "bigint", "nullable": True},
            "average_stars": {"data_type": "double", "nullable": True},
        },
    )
    def user():
        user_files = (
            filesystem(
                bucket_url="s3://yelpopendataset-raw-useast1-dev/raw",
                file_glob="yelp_academic_dataset_user.json",
            )
            | read_jsonl()
        )
        yield from user_files

    # Transform and limit
    sampled_user = (
        user()
        .add_filter(lambda x: x["yelping_since"].startswith(partition_key))
        .add_limit(100)
    )
    athena_adapter(
        sampled_user, partition=[athena_partition.month("yelping_since")]
    )
    # End of user
    # ================================

    # ================================
    # Start of tip
    @dlt.resource(
        name="tip",
        write_disposition="merge",
        primary_key=("business_id", "user_id"),
        table_format="iceberg",
        columns={
            "business_id": {"data_type": "text", "nullable": False},
            "user_id": {"data_type": "text", "nullable": False},
            "date": {"data_type": "timestamp", "nullable": False},
            "text": {"data_type": "text", "nullable": True},
            "likes": {"data_type": "bigint", "nullable": True},
        },
    )
    def tip():
        tip_files = (
            filesystem(
                bucket_url="s3://yelpopendataset-raw-useast1-dev/raw",
                file_glob="yelp_academic_dataset_tip.json",
            )
            | read_jsonl()
        )
        yield from tip_files

    # Transform and limit
    sampled_tip = (
        tip()
        .add_filter(lambda x: x["date"].startswith(partition_key))
        .add_limit(100)
    )
    athena_adapter(sampled_tip, partition=[athena_partition.month("date")])
    # End of tip
    # ================================

    return (
        sampled_business,
        transformed_checkin,
        sampled_review,
        sampled_user,
        sampled_tip,
    )
