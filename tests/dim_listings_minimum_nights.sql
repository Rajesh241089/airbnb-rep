SELECT
    *
FROM
    {{ ref('dim_listings_w_hosts') }}
WHERE minimum_nights < 1
LIMIT 10