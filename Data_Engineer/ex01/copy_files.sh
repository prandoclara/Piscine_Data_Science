#!/bin/bash

# Nom du conteneur 
CONTAINER_NAME="postgres_piscineds"

# Dossier cible dans le conteneur
TARGET_DIR="/data"

# Liste des fichiers à copier
docker cp /Users/clara/Documents/42/42_PostCommonCore/Piscine_Data_Science/Data_Engineer/ex01/data/customer/data_2022_dec.csv $CONTAINER_NAME:$TARGET_DIR
docker cp /Users/clara/Documents/42/42_PostCommonCore/Piscine_Data_Science/Data_Engineer/ex01/data/customer/data_2022_nov.csv $CONTAINER_NAME:$TARGET_DIR
docker cp /Users/clara/Documents/42/42_PostCommonCore/Piscine_Data_Science/Data_Engineer/ex01/data/customer/data_2022_oct.csv $CONTAINER_NAME:$TARGET_DIR
docker cp /Users/clara/Documents/42/42_PostCommonCore/Piscine_Data_Science/Data_Engineer/ex01/data/customer/data_2023_jan.csv $CONTAINER_NAME:$TARGET_DIR
docker cp /Users/clara/Documents/42/42_PostCommonCore/Piscine_Data_Science/Data_Engineer/ex01/data/item/item.csv $CONTAINER_NAME:$TARGET_DIR

echo "✅ Tous les fichiers CSV ont été copiés dans le conteneur $CONTAINER_NAME:$TARGET_DIR"
