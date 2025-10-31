CREATE TABLE IF NOT EXISTS users (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100) UNIQUE,
    age INT,
    created_at TIMESTAMP DEFAULT NOW()
);

INSERT INTO users (first_name, last_name, email, age)
VALUES
('Alice', 'Dupont', 'alice@example.com', 25),
('Bob', 'Martin', 'bob@example.com', 30),
('Charlie', 'Durand', 'charlie@example.com', 22)
ON CONFLICT (email) DO NOTHING;

\dt
