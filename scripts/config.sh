#!/bin/bash
set -e

# Initialize SQLite database
DATABASE_NAME=middle_earth
DATABASE_PATH=/var/lib/middle_earth/middle_earth.db

echo "Checking if SQLite database exists..."
if [ ! -f "$DATABASE_PATH" ]; then
    echo "Database $DATABASE_NAME.db does not exist. Creating it..."
    # Create the database file with proper schema
    mkdir -p /var/lib/middle_earth || { echo "Failed to create database directory"; exit 1; }
    sqlite3 $DATABASE_PATH < /root/middle_earth_sqlite.sql || { echo "Failed to create database"; exit 1; }
fi

# Set proper permissions for the database directory and file
chmod 777 /var/lib/middle_earth || { echo "Failed to set permissions on database directory"; exit 1; }
chmod 666 $DATABASE_PATH || { echo "Failed to set permissions on database file"; exit 1; }

# Wait a moment for services to be ready
sleep 2

/usr/local/bin/middle_earth/create_environment
