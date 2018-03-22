# Resyncer for Postgres sequences

## Requirements
*PostgreSQL installed
*(Maybe Docker)

## Installation

PostgreSQL could be easily used by just spinning up a Docker container
https://docs.docker.com/samples/library/postgres/
# tl;dr 
```
docker run --name myPsql postgres -e POSTGRES_PASSWORD=myPSQLpass -d postgres
```
Will spin a docker container with myPsql name, exposes the default port 5432 and allows you to connect to the database Postgres via <user: postgres, password: myPSQLpass>

## Issue this script solves
When You want to remove/drop data from the database, it often happens that your sequences will not be reset, and thus inserting the values again, via a migration, can be prohibited.

## How to run it
```
psql -U postgres -d postgres -a -f restarter.sql
```
This will create the function in the database for further use.

## How it works
It will look through all the tables in the schema that contains the name 'sequence', loop through them for further resync.
If the function is called without parameter, it will by default take the last id from the table it belongs to.
```
SELECT sync_sequences();
```
If the function is called with a parameter, it will reset the id to the one specified.
```
SELECT sync_sequences(1); //all last id's from the sequences will be 1
```

## How to remove
```
DROP FUNCTION sync_sequences(INT);
```
