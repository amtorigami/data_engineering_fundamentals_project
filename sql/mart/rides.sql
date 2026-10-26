drop table if exists mart.rides;
create table mart.rides as
select
    r.ride_id,
    r.requested_at,
    r.driver_id,
    d.driver_name,
    d.rating,
    pz.zone_name as pickup_zone,
    dz.zone_name as dropoff_zone,
    r.distance_km,
    r.fare_amount
from staging.rides r
join staging.drivers d on d.driver_id = r.driver_id
join staging.zones pz on pz.zone_id = r.pickup_zone_id
join staging.zones dz on dz.zone_id = r.dropoff_zone_id;