{{
  config(
    materialized = 'incremental',
    unique_key   = 'review_id',
    on_schema_change = 'fail'
  )
}}

WITH src_reviews AS (
  SELECT * FROM {{ ref('src_reviews') }}
)
SELECT
  {{ dbt_utils.generate_surrogate_key(['listing_id', 'review_date', 'reviewer_name']) }} AS review_id,
  src_reviews.*
FROM src_reviews
WHERE review_text IS NOT NULL
{% if is_incremental() %}
  AND review_date >= (SELECT DATEADD('day', -7, MAX(review_date)) FROM {{ this }})
{% endif %}
