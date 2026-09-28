CREATE TABLE IF NOT EXISTS metering_points(
    id TEXT NOT NULL PRIMARY KEY,
    price_area TEXT NOT NULL,
    contract_price_dkk_kwh NUMERIC NOT NULL
);
CREATE TABLE IF NOT EXISTS meter_readings(
    metering_point_id TEXT NOT NULL REFERENCES metering_points(id),
    time timestamptz NOT NULL,
    resolution TEXT NOT NULL, -- Like PT1H, PT15M, ...
    quantity_kwh DOUBLE PRECISION NOT NULL,
    PRIMARY KEY (metering_point_id, time)
);
