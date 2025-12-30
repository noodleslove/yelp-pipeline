with source as (

    select *
    from {{ source('raw', 'business') }}

),

renamed as (

    select business_id,
        name,
        address,
        city,
        state,
        postal_code,
        latitude,
        longitude,
        stars,
        review_count,
        is_open,

        -- Extract and convert boolean strings to proper booleans
        case
            when json_extract_scalar(cast(attributes as json), '$.DriveThru') = 'True' then true
            when json_extract_scalar(cast(attributes as json), '$.DriveThru') = 'False' then false
            else null
        end as drive_thru,
        case
            when json_extract_scalar(cast(attributes as json), '$.GoodForKids') = 'True' then true
            when json_extract_scalar(cast(attributes as json), '$.GoodForKids') = 'False' then false
            else null
        end as take_out,
        case
            when json_extract_scalar(
                cast(attributes as json),
                '$.WheelchairAccessible'
            ) = 'True' then true
            when json_extract_scalar(
                cast(attributes as json),
                '$.WheelchairAccessible'
            ) = 'False' then false
            else null
        end as wheelchair_accessible,
        case
            when json_extract_scalar(cast(attributes as json), '$.ByAppointmentOnly') = 'True' then true
            when json_extract_scalar(cast(attributes as json), '$.ByAppointmentOnly') = 'False' then false
            else null
        end as by_appointment_only,
        case
            when json_extract_scalar(
                cast(attributes as json),
                '$.BusinessAcceptsCreditCards'
            ) = 'True' then true
            when json_extract_scalar(
                cast(attributes as json),
                '$.BusinessAcceptsCreditCards'
            ) = 'False' then false
            else null
        end as business_accepts_credit_cards,

        categories,

        -- Extract business hours
        json_extract_scalar(cast(hours as json), '$.Monday') as hours__monday,
        json_extract_scalar(cast(hours as json), '$.Tuesday') as hours__tuesday,
        json_extract_scalar(cast(hours as json), '$.Wednesday') as hours__wednesday,
        json_extract_scalar(cast(hours as json), '$.Thursday') as hours__thursday,
        json_extract_scalar(cast(hours as json), '$.Friday') as hours__friday,
        json_extract_scalar(cast(hours as json), '$.Saturday') as hours__saturday,
        json_extract_scalar(cast(hours as json), '$.Sunday') as hours__sunday

        from source

)

select * from renamed