drop table if exists staging.rides;
create table staging.rides as
select distinct
    ride_id,
    driver_id,
    pickup_zone_id,
    dropoff_zone_id,
    requested_at,
    distance_km,
    fare_amount
from raw.rides
where fare_amount > 0
  and driver_id in (select driver_id from raw.drivers);