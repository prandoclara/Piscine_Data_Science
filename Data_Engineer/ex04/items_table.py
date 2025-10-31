#!/usr/bin/env python3
import pandas as pd
from sqlalchemy import create_engine, types

engine = create_engine("postgresql://claprand:mysecretpassword@localhost:5432/piscineds")

df = pd.read_csv("./data/item/item.csv")

data_types = {
    "item_id": types.Integer(),
    "item_name": types.String(255),
    "price": types.Numeric(10, 2),
}

df.to_sql("items", engine, if_exists="replace", index=False, dtype=data_types)

print("Table 'items' créée avec succès !")
