with resultset as (
    select * from {{ source('airbnb', 'reviews') }}
)
select
LISTING_ID,
DATE as REVIEW_DATE,
REVIEWER_NAME,
COMMENTS as REVIEW_TEXT,
SENTIMENT as REVIEW_SENTIMENT
from resultset