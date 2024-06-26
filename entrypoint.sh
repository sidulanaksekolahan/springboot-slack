#!/bin/bash

# Start SQL Server in the background
/opt/mssql/bin/sqlservr &

# Capture the SQL Server process ID
SQL_PID=$!

# Wait for the SQL Server to be available
echo "Waiting for SQL Server to be available..."
until /opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P "$SA_PASSWORD" -Q "SELECT 1" &> /dev/null
do
    echo "SQL Server is unavailable - sleeping"
    sleep 5
done

echo "SQL Server is up - checking if database exists"
DB_EXISTS=$(/opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P "$SA_PASSWORD" -Q "IF DB_ID('demo') IS NOT NULL PRINT 1 ELSE PRINT 0" -h -1)

if [ "$DB_EXISTS" -eq "0" ]; then
    echo "Database 'demo' does not exist - creating database"
    /opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P "$SA_PASSWORD" -Q "CREATE DATABASE demo"
else
    echo "Database 'demo' already exists - skipping creation"
fi

# Wait for the SQL Server process to exit
wait $SQL_PID
