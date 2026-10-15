
WITH base_data AS (
  select *,
  miles * 1.60934 as distance_km,
  speed * 1.60934 as speed_kmh,
  case when day in ('Saturday','Sunday') THEN 'weekend'
  else 'weekday' end as day_type
  from `uber-project-511207.uber.uber_clean`

),

threshold AS (
  SELECT *,
  CASE
    WHEN speed_kmh > 40 then 'Efficient'
    WHEN speed_kmh between 25 and 40 then 'Moderate'
    ELSE 'Inefficient'
    end AS efficiency_Category
  from base_data
),

purpose_summary as (
  SELECT 
    day_type,
    purpose,
    count(*) as total_trips,
    countif (efficiency_Category = 'Inefficient') AS inefficient_trips
  from threshold
  group by 1,2
)

SELECT 
  day_type, 
  purpose,
  inefficient_trips,
  total_trips,
  ROUND((inefficient_trips/total_trips)*100,2) as inefficient_precentages
from purpose_summary
-- where total_trips > 10
qualify row_number() over (partition by day_type order by inefficient_trips/total_trips desc) <= 2
order by 1,5 desc
;


-- select 
--   day_type,
--   efficiency_Category,
--   count(*) total_trip,
--   round(avg(case when duration >0 then duration end),2) as avg_duration_minutes,
--   round(avg(distance_km),2) as avg_distance_km,
--   round(avg(case when duration > 0 then speed_kmh end),2) as avg_speed_kmh
-- from threshold
-- group by 1,2 order by 1,2




