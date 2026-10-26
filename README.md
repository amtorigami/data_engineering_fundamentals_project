# InDrive Ride Pipeline

A small ELT data pipeline built with Airflow and Postgres, running locally in Docker.

InDrive is a ride-hailing app in Casablanca. Its data team receives:

- **Batch:** 3 CSV files maintained by the back office (drivers, vehicles, zones).
- **Streaming:** a flow of ride events from the app (simulated with a dummy web API).

## Architecture

```
API (dummy)  --> [1_streaming] --+
                                 +--> RAW --> [3_staging] --> STAGING --> [4_marts] --> MART
3 CSV files  --> [2_batch] ------+
```

| Layer   | Schema    | Content                                                      |
| ------- | --------- | ------------------------------------------------------------ |
| Raw     | `raw`     | data exactly as received                                     |
| Staging | `staging` | cleaned data (trimmed text, no duplicates, no invalid rides) |
| Mart    | `mart`    | business tables for analysts                                 |

## Marts

- `mart.rides`: one row per ride, with names instead of ids
- `mart.revenue_by_zone`: rides and revenue per pickup zone
- `mart.driver_leaderboard`: rides and revenue per driver
- `mart.revenue_by_vehicle_type`: rides and revenue per vehicle type (bonus)

## Run it

```bash
docker compose up -d
docker compose exec airflow cat /opt/airflow/standalone_admin_password.txt
```

- Airflow: http://localhost:8083 (login `admin` + the password above)
- Adminer: http://localhost:8086 (System `PostgreSQL`, Server `postgres`, user/password/database `indrive`)

Stop with `docker compose down` (or `docker compose down -v` for a full reset).

## Key points

- Every staging and mart table is rebuilt with `DROP` + `CREATE TABLE AS`, so each run is idempotent.
- Invalid rides (unknown driver, `fare_amount <= 0`, duplicates) are filtered in staging, not silently dropped by a join.
- If a staging task fails, `4_marts` does not start.

See [ANSWERS.md](ANSWERS.md) for the answers to the exercise questions.
