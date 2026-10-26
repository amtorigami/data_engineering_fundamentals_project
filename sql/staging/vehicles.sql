drop table if exists staging.vehicles;
create table staging.vehicles as
select vehicle_id, driver_id, trim(make) as make, trim(model) as model, trim(vehicle_type) as vehicle_type
from raw.vehicles;