drop table if exists staging.drivers;
create table staging.drivers as
select driver_id, trim(driver_name) as driver_name, trim(city) as city, rating
from raw.drivers;