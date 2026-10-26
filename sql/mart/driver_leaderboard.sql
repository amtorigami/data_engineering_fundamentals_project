drop table if exists mart.driver_leaderboard;
create table mart.driver_leaderboard as
select
    r.driver_name,
    v.vehicle_type,
    r.rating,
    count(*) as rides,
    round(sum(r.fare_amount), 2) as revenue
from mart.rides r
join staging.vehicles v on v.driver_id = r.driver_id
group by r.driver_id, r.driver_name, v.vehicle_type, r.rating
order by revenue desc;