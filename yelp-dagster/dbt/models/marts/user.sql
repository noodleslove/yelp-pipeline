{{ config(
    table_type='iceberg',
    format='parquet'
) }}

with users as (

    select
        user_id,
        name,
        review_count,
        useful,
        funny,
        cool,
        fans,
        average_stars,

        cast(yelping_since as timestamp(3)) as yelping_since
    
    from {{ source('raw', 'user') }}

),

reviews as (

    select 
        review_id,
        user_id,
        business_id,
        stars,
        cool,
        funny,
        useful,
        text,

        cast(date as timestamp(3)) as date

    from {{ source('raw', 'review') }}

),

user_reviews_summary as (

    select
        reviews.user_id,

        count(reviews.review_id) as count_lifetime_reviews,
        count(reviews.review_id) > 1 as is_repeat_reviewer,
        min(reviews.date) as first_review_at,
        max(reviews.date) as last_review_at,
        sum(reviews.stars) as lifetime_review_stars,
        sum(reviews.useful) as lifetime_useful_votes,
        sum(reviews.funny) as lifetime_funny_votes,
        sum(reviews.cool) as lifetime_cool_votes

    from reviews

    group by 1

),

joined as (

    select
        users.*,

        user_reviews_summary.count_lifetime_reviews,
        user_reviews_summary.first_review_at,
        user_reviews_summary.last_review_at,
        user_reviews_summary.lifetime_review_stars,
        user_reviews_summary.lifetime_useful_votes,
        user_reviews_summary.lifetime_funny_votes,
        user_reviews_summary.lifetime_cool_votes,

        case
            when user_reviews_summary.count_lifetime_reviews > 1 then 'returning'
            else 'new'
        end as user_type

    from users

    left join user_reviews_summary
        on users.user_id = user_reviews_summary.user_id

)

select * from joined