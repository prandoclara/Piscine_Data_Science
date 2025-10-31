-- ✅ On est déjà dans la base "piscineds" grâce à POSTGRES_DB
\c piscineds

-- Supprimer la table si elle existe déjà
DROP TABLE IF EXISTS data_2022_dec;

-- Créer la table avec 6 types de données différents
CREATE TABLE data_2022_dec (
    event_time TIMESTAMP,           -- 1️⃣ DATETIME (obligatoire et premier)
    event_type VARCHAR(50),         -- 2️⃣ Texte court
    product_id BIGINT,              -- 3️⃣ Entier large
    price NUMERIC(10,2),            -- 4️⃣ Décimal
    user_id INTEGER,                -- 5️⃣ Entier standard
    user_session UUID,              -- 6️⃣ UUID
    is_weekend BOOLEAN,             -- 7️⃣ Booléen dérivé
    import_date DATE DEFAULT CURRENT_DATE,  -- 8️⃣ Date du jour d’import
    PRIMARY KEY (event_time, product_id)
);

-- Importer les données du CSV (copie directe)
COPY data_2022_dec(event_time, event_type, product_id, price, user_id, user_session)
FROM '/data/data_2022_dec.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',');

-- Marquer les week-ends après import
UPDATE data_2022_dec
SET is_weekend = EXTRACT(ISODOW FROM event_time) IN (6,7);
