INSERT INTO metering_points VALUES
    ('571313113162366344', 'DK1', 0.60),
    ('571313161170107671', 'DK2', 0.55);

\copy meter_readings FROM './meter_readings.txt';
