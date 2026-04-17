# Take home assignment

## Background

At Reel we do a fair bit of data ingestion and analytics, and for that we often scrape data from APIs and store it in a database. Typically Postgres.

We have included some example data for meter readings.

On [Energidataservice](https://www.energidataservice.dk/tso-electricity/DeclarationGridEmission) there is a publically available API endpoint where
you can 

Your task is to scrape emissions data from the API and use it to calculate the emissions for a metering point.

You should not spend more than a couple of hours on the task, and if you don't complete all the tasks, then think about how you would solve them.


## Initial task: Setting up a postgres

We have included some initial data 

From inside the `sql` folder we can run stuff

```
$ docker run docker run -e POSTGRES_PASSWORD=postgres -d -p 5432:5432 postgres:latest
```

Then if you have PSQL installed, you can seed the database with the initial data.

```
psql -h localhost -p 5432 -U postgres -f 01_create_tables.sql
psql -h localhost -p 5432 -U postgres -f 02_insert_test_data.sql
```

And then you can query the usual way

```
psql -h localhost -p 5432 -U postgres
postgres=# select metering_point_id, sum(quantity_kwh) from meter_readings group by metering_point_id;
 metering_point_id  |        sum
--------------------+-------------------
 571313161170107671 | 718.5299999999826
 571313113162366344 | 745871.6999999995
```


## 1. Design an SQL table for the grid emissions data

Put it in a new file `03_create_grid_emissions_table.sql`

## 2. Write a function to scrape the emissions data and store it in the table

There is some boilerplate in Elixir, but feel free to use whatever language you are most comfortable with.
Please include instructions on how to run it.

## 3. Implement a function to calculate grid emissions for a metering point

Something something
