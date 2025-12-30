import dagster as dg
from dagster_dlt import DagsterDltResource

@dg.definitions
def resources() -> dg.Definitions:
    return dg.Definitions(resources={
        "dlt": DagsterDltResource()
    })
