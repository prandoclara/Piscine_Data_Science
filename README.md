# 🧠 Piscine Data Science — Day 0: Data Engineer

---

## ⚙️ Setup

Using **Docker Compose** with:
- **Postgres 17** — main database  
- **pgAdmin 4** — web interface (http://localhost:5050)  
  - Login: `admin@admin.com` / `admin`

All CSV data is copied inside the container at `/data` using a helper script.

---

## Exercises Overview

### 🧱 ex00 — Create Postgres DB  
Setup PostgreSQL via Docker.  
Database: `piscineds`  
User: `claprand` / `mysecretpassword`  
Port: `5432`  

Connection:
```bash
psql -U claprand -d piscineds -h localhost -W
```

### 🧭 ex01 — Show me your DB

Add pgAdmin for database visualization and management.
Auto-connected using servers.json.

### 💾 ex02 — First table

Manual table creation from data_2022_dec.csv using SQL:
```bash
CREATE TABLE data_2022_dec (...);
COPY data_2022_dec FROM '/data/customer/data_2022_dec.csv' WITH (FORMAT csv, HEADER true);
UPDATE data_2022_dec SET is_weekend = EXTRACT(ISODOW FROM event_time) IN (6,7);
```

Run:
```bash
docker exec -i postgres_piscineds psql -U claprand -d piscineds -f /data/table.sql
```

### ⚙️ ex03 — Automatic table

Python script scans /data/customer/
→ creates and loads one table per CSV automatically.
Same logic as ex02, but generalized.

### 📦 ex04 — Items table

Create items table from items.csv
(using at least three SQL data types).
