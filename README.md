# Piscine Data Science — Day 0: Data Engineer 🧠

---

## 🧰 Setup

We use a simple **Docker Compose** stack running two services:

- **Postgres 17** → main database engine
- **pgAdmin 4** → web UI to inspect and query the database

This approach keeps everything isolated, reproducible, and easy to clean up.

---

## 🧩 Day 0 - Exercises Overview

### 🧱 ex00 — Create Postgres DB

This first exercise was about setting up a working PostgreSQL database, either on a VM or via Docker Compose.

We created:

- a Postgres service using the **official postgres:17** image
- database name: `piscineds`
- user: `claprand`
- password: `mysecretpassword`
- exposed on port **5432**

Everything runs through Docker, making it portable and easy to reset.  
Connection test:

```bash
psql -U claprand -d piscineds -h localhost -W
```

Once connected, we could create a simple test table like users and insert a few rows.

---

### 🧭 ex01 — Show me your DB

The second exercise focused on visualizing and managing the database using a GUI tool.

We added pgAdmin 4 to our Docker Compose setup, connected it to our Postgres service,
and defined a servers.json file for automatic configuration.

Accessing http://localhost:5050

with admin@admin.com / admin gives a full view of our database, tables, and records.

This step made browsing tables and debugging much easier.

---

### 💾 ex02 — First table

Here we created our first real data table from a provided CSV file.

We mounted the CSV inside the container (./data:/data) and used SQL to:

Create a table named after the CSV file (data_2022_dec)

Use at least six data types, including TIMESTAMP, UUID, BOOLEAN, and NUMERIC

Load data via COPY FROM '/data/data_2022_dec.csv'

Add a derived column is_weekend to flag Saturday/Sunday events

This step highlighted how critical it is to run imports inside the database —
what took 8.5 minutes externally now runs in ~35 seconds with the COPY command inside Postgres.

---

### ⚙️ ex03 — Automatic table

Now things get more interesting.
By the end of February 2022, we were able to create tables manually —
so the next step was to automate the process.

In this exercise, the goal was to:

Automatically scan all CSV files in the /customer folder

Create a table for each one, named after the file (e.g., data_2022_oct)

Use the appropriate column types inferred from the CSV header

In practice, this means writing a script (SQL or Python) that:

Iterates over the list of CSV files

Generates a CREATE TABLE statement for each

Loads the data with the COPY command

The result: all monthly datasets (October, November, December 2022, January 2023…)
are imported automatically into PostgreSQL — each in its own table.

This was the point where automation started replacing repetitive SQL work.

---

### 📦 ex04 — Items table

This last exercise of the day focused on creating a specific items table,
based on a provided items.csv file located in the /items folder.

We had to:

Create the table items manually

Use at least three different data types

Import the CSV contents into the table

Even though the logic was similar to ex02, the schema design was more flexible,
with only three types required — typically VARCHAR, INTEGER, and NUMERIC.
