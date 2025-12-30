{% docs __overview__ %}

## Data Documentation for Yelp Pipeline

This project processes Yelp business and check-in data using a modern data pipeline architecture.

### Architecture

This [dbt](https://www.getdbt.com/) project is part of a larger data pipeline that uses:
- **Dagster**: Orchestration and workflow management
- **dlt (data load tool)**: Data extraction from Yelp data sources
- **dbt**: Data transformation and modeling

### Data Sources

The pipeline processes the following Yelp datasets:
- **Business data**: Contains information about businesses including location, ratings, attributes, hours, and categories
- **Check-in data**: Contains customer check-in timestamps for businesses

### Models

The project includes staging models that transform raw Yelp data:
- `stg_business`: Transforms raw business data, extracting attributes and hours from JSON fields
- `stg_checkin`: Transforms raw check-in data, normalizing date information

### Source Code

The source code can be found [here](https://github.com/noodleslove/yelp-pipeline).

{% enddocs %}
