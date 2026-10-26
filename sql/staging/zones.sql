drop table if exists staging.zones;
create table staging.zones as
select zone_id, trim(zone_name) as zone_name, trim(city) as city
from raw.zones;