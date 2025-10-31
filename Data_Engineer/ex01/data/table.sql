-- table.sql
-- Create table from data_2022_dec.csv
-- Using at least 6 data types
-- First column must be a DATETIME (TIMESTAMP)

-- 1️⃣ Se connecter à la base (déjà faite dans Docker avec POSTGRES_DB=piscineds)
\c piscineds

-- 2️⃣ Supprimer la table si elle existe déjà
DROP TABLE IF EXISTS data_2022_dec;

-- 3️⃣ Créer la table
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

-- 4️⃣ Importer les données depuis le CSV (dans Docker)
COPY data_2022_dec(event_time, event_type, product_id, price, user_id, user_session)
FROM '/data/customer/data_2022_dec.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',');

-- 5️⃣ Ajouter le champ dérivé
UPDATE data_2022_dec
SET is_weekend = EXTRACT(ISODOW FROM event_time) IN (6,7);

-- 6️⃣ Vérification rapide
-- \dt
-- SELECT * FROM data_2022_dec LIMIT 10;
