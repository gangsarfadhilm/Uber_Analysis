--poin 2


WITH base_data AS (
  select *,
  miles * 1.60934 as distance_km,
  speed * 1.60934 as speed_kmh,
  case when day in ('Saturday','Sunday') THEN 'weekend'
  else 'weekday' end as day_type
  from `uber-project-511207.uber.uber_clean`

)

--weekend

-- select start_hour, count(*) as count_trip_weekend

-- from base_data
-- where day_type ='weekend'
-- group by 1 order by 1

--weekday

-- select start_hour, count(*) as count_trip_weekday

-- from base_data
-- where day_type ='weekday'
-- group by 1 order by 1

-- Top ten dan jam tersibuk
select 
  day,
  start_hour, count(*) as count_trip
from base_data
group by 1,2 order by count(*) desc limit 10;




