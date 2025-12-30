from dagster import AssetExecutionContext
from dagster_dlt import DagsterDltResource, dlt_assets
from dlt.pipeline import pipeline

from yelp_dagster.defs.dlt.sources import yelp_raw_source
from yelp_dagster.defs.partitions import yearly_partitions_def


@dlt_assets(
    dlt_source=yelp_raw_source(),
    dlt_pipeline=pipeline(
        pipeline_name="yelp_raw_ingest",
        destination="athena",
        dataset_name="yelp_dlt",
        progress="log",
    ),
    name="yelp_raw_ingest",
    group_name="ingestion",
    partitions_def=yearly_partitions_def,
)
def yelp_raw_ingest_asset(
    context: AssetExecutionContext, dlt: DagsterDltResource
):
    # Fromat like YYYY-MM
    partition_key = context.partition_key[:-3]
    yield from dlt.run(context=context, dlt_source=yelp_raw_source(partition_key))
