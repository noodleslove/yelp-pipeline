with source as (

    select * from {{ source('raw', 'checkin') }}

),

dates as (

    select * from {{ source('raw', 'checkin__date')}}

),

renamed as (

    select
        business_id,
        _dlt_list_idx as index,
        value as "date"

    from source

    left join dates on source._dlt_id = dates._dlt_parent_id

)

select * from renamed
