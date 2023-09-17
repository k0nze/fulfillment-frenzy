@echo off

SET DATABASE_FILE_PATH=".\\model\\database.db"
SET DATABASE_LAYOUT_SQL_FILE_PATH=".\\setup\\database_layout.sql"
SET ADDRESSES_CSV_FILE_PATH=".\\setup\\addresses.csv"

:: if the database file already exists delete it
IF EXIST %DATABASE_FILE_PATH% (
	echo * deleting existing database file at '%DATABASE_FILE_PATH%'
	DEL /F %DATABASE_FILE_PATH%
)

echo * setup database layout in '%DATABASE_FILE_PATH%
duckdb %DATABASE_FILE_PATH% ".read %DATABASE_LAYOUT_SQL_FILE_PATH%"

echo * tables created in database:
duckdb %DATABASE_FILE_PATH% "SHOW TABLES;"

echo * inserting example data into database
duckdb %DATABASE_FILE_PATH% "INSERT INTO Addresses SELECT * FROM read_csv_auto('%ADDRESSES_CSV_FILE_PATH%)"

