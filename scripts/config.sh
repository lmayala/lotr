# Initialize SQLite database
DATABASE_NAME=middle_earth
DATABASE_PATH=/var/lib/middle_earth/middle_earth.db

echo "Checking if SQLite database exists..."
if [ ! -f "$DATABASE_PATH" ]; then
    echo "Database $DATABASE_NAME.db does not exist. Creating it..."
    # Create the database file with proper schema
    mkdir -p /var/lib/middle_earth
    sqlite3 $DATABASE_PATH < /root/middle_earth_sqlite.sql
fi

# Set proper permissions for the database directory and file
chmod 777 /var/lib/middle_earth
chmod 666 $DATABASE_PATH

# Wait a moment for services to be ready
sleep 2

/usr/local/bin/middle_earth/create_environment
