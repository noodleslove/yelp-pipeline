from dagster import MonthlyPartitionsDefinition, TimeWindowPartitionsDefinition


yearly_partitions_def = TimeWindowPartitionsDefinition(
    start="2010-01-01",
    cron_schedule="0 0 1 1 *",
    fmt="%Y-%m-%d",
)

monthly_partitions_def = MonthlyPartitionsDefinition(start_date="2010-01-01")
