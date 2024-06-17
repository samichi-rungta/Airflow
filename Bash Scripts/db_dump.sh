#!/bin/bash

# Source credentials from external file
source /Users/samichirungta/airflow/scripts/credentials.sh

# Directory for storing dumps
DUMP_DIR="/Users/samichirungta/airflow/backups"
# Current date and time for unique filename
CURRENT_DATETIME=$(date +"%Y%m%d_%H%M%S")

# File name for dump
DUMP_FILE="$DUMP_DIR/${DB_NAME}_${CURRENT_DATETIME}.sql"

# Dump MySQL database
mysqldump -u "$DB_USER" -p"$DB_PASS" "$DB_NAME" > "$DUMP_FILE"

# Check if mysqldump was successful
if [ $? -eq 0 ]; then
    echo "true"
    echo "Database successfully dumped to $DUMP_FILE"
else
    echo "false"
    echo "Failed to dump the database"
fi
