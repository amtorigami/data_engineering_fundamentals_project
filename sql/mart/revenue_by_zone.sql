drop table if exists mart.revenue_by_zone;
create table mart.revenue_by_zone as
select
    pickup_zone,
    count(*) as rides,
    round(sum(fare_amount), 2) as revenue
from mart.rides
group by pickup_zone
order by revenue desc;