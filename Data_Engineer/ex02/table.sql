-- table.sql
-- Create table from data_2022_dec.csv
-- Using at least 6 data types
-- First column must be a DATETIME (TIMESTAMP)

\c piscineds

DROP TABLE IF EXISTS data_2022_dec;

CREATE TABLE data_2022_dec (
    event_time TIMESTAMP,
    event_type VARCHAR(50),
    product_id BIGINT,
    price NUMERIC(10,2),
    user_id INTEGER,
    user_session UUID,
    is_weekend BOOLEAN,
    import_date DATE DEFAULT CURRENT_DATE
);

COPY data_2022_dec(event_time, event_type, product_id, price, user_id, user_session)
FROM '/data/customer/data_2022_dec.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',');

UPDATE data_2022_dec
SET is_weekend = EXTRACT(ISODOW FROM event_time) IN (6,7);

-- Vérification rapide
-- docker cp table.sql postgres_piscineds:/data/table.sql
-- docker exec -i postgres_piscineds psql -U claprand -d piscineds -f /data/table.sql
-- \dt
-- SELECT * FROM data_2022_dec LIMIT 10;
