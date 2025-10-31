#!/usr/bin/env python3
import os
import pandas as pd
import psycopg2
from sqlalchemy import create_engine, MetaData
import sqlalchemy

DB_USER = "claprand"
DB_PASSWORD = "mysecretpassword"
DB_HOST = "localhost"
DB_PORT = "5432"
DB_NAME = "piscineds"

BASE_FOLDER = "./data/customer"

def table_exists(engine, table_name):
    metadata = MetaData()
    metadata.reflect(bind=engine)
    return table_name in metadata.tables

def load_csv_to_postgres(path, table_name):
    try:
        print(f"Creating table '{table_name}' from {os.path.basename(path)} ...")

        df = pd.read_csv(path)

        data_types = {
            "event_time": sqlalchemy.types.DateTime(),
            "event_type": sqlalchemy.types.String(length=255),
            "product_id": sqlalchemy.types.BigInteger(),
            "price": sqlalchemy.types.Numeric(10, 2),
            "user_id": sqlalchemy.types.Integer(),
            "user_session": sqlalchemy.types.UUID(as_uuid=True),
        }

        engine = create_engine(
            f"postgresql://{DB_USER}:{DB_PASSWORD}@{DB_HOST}:{DB_PORT}/{DB_NAME}"
        )

        if table_exists(engine, table_name):
            print(f"Table '{table_name}' already exists — skipping.\n")
            engine.dispose()
            return

        df.head(0).to_sql(table_name, engine, index=False, dtype=data_types, if_exists="replace")
        engine.dispose()

        conn = psycopg2.connect(
            dbname=DB_NAME,
            user=DB_USER,
            password=DB_PASSWORD,
            host=DB_HOST,
            port=DB_PORT,
        )
        cur = conn.cursor()

        with open(path, "r", encoding="utf-8") as f:
            cur.copy_expert(
                f"COPY {table_name} FROM STDIN WITH CSV HEADER DELIMITER ','",
                f,
            )

        conn.commit()
        cur.close()
        conn.close()

        print(f"Table '{table_name}' imported successfully with COPY!\n")

    except Exception as e:
        print(f"Error while processing '{table_name}': {e}\n")

if __name__ == "__main__":
    print("Starting table import process...\n")
    total = 0
    for root, dirs, files in os.walk(BASE_FOLDER):
        for file in files:
            if file.endswith(".csv"):
                total += 1
                csv_path = os.path.join(root, file)
                table_name = os.path.splitext(file)[0]
                load_csv_to_postgres(csv_path, table_name)

    print(f"All CSV files processed! ({total} tables created or updated)\n")
