WITH base_data AS (
  select *,
  miles * 1.60934 as distance_km,
  speed * 1.60934 as speed_kmh,
  case when day in ('Saturday','Sunday') THEN 'weekend'
  else 'weekday' end as day_type
  from `uber-project-511207.uber.uber_clean`

)

SELECT 
  CATEGORY, day_type,
  count (*) as total_trip,
  round (count (*)/ count(distinct start_date),2) as avg_trip_per_day,
  round (avg(case when duration >0 then duration end),2) as avg_duration_minutes,
  round (avg(distance_km),2) as avg_distance_km,
  round (avg(case when duration > 0 then speed_kmh end),2) as avg_speed_kmh,
from base_data
GROUP BY 1,2
