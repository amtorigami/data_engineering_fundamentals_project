drop table if exists mart.revenue_by_vehicle_type;
create table mart.revenue_by_vehicle_type as
select
    v.vehicle_type,
    count(*) as rides,
    round(sum(r.fare_amount), 2) as revenue
from mart.rides r
join staging.vehicles v on v.driver_id = r.driver_id
group by v.vehicle_type
order by revenue desc;