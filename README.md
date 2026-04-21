# Take home assignment

This is the take home assignement for the Senior Software Engineer position at Reel. If you have any questions about the task, feel free to write
to [Christian Kjær](mailto:ckl@reel.energy).

Once you are done, please send the solution to [Christian Kjær](mailto:ckl@reel.energy) as a zip file together with a short explainer of what you
did and why.

And be aware that we know that Claude Code can solve this assignment correctly.

## Background

At Reel we do a fair bit of data ingestion and analytics, and for that we often scrape data from APIs and store it in a database. Typically Postgres.

We have included some example data for meter readings and SQL scripts to store it. The task is to extend the data model with grid emissions data.

On [Energidataservice](https://www.energidataservice.dk/tso-electricity/DeclarationGridEmission) there is a publically available API endpoint where
you can explore one specific source of emissions data. Your task is to data from the API and use it to calculate the emissions for a metering point.

You should not spend more than a couple of hours on the task, and if you don't complete all the parts, then think about how you would solve them.

You are free to use whatever programming language and libraries that you want, but if you choose to use Elixir, there is some example code for
fetching JSON and talking to postgres in the `emissions` folder. You can install Elixir using the [Official guide](https://elixir-lang.org/install.html).
Note that the example code is not a great example of production quality Elixir.

## Initial task: Setting up a postgres instance

There are some scripts setting up an initial postgres schema in the `sql` folder. If
you need a postgres running locally, you can start one easily with Docker:

```
$ docker run docker run -e POSTGRES_PASSWORD=postgres -d -p 5432:5432 postgres:latest
```

Then if you have [PSQL](https://www.tigerdata.com/blog/how-to-install-psql-on-mac-ubuntu-debian-windows)
installed, you can seed the database with the initial data.

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

In the first part of the exercise, you should create a new file `03_create_grid_emissions_table.sql`
with the relevant `CREATE TABLE...` statement to create a table to store the emissions data.

## 2. Write a function to scrape the emissions data and store it in the table

Write code to scrape, parse and store the emissions data in the table that you previously created. You can use the provided Elixir boilerplate,
or you can use whatever programming language and libraries that you are most comfortable with.

## 3. Implement a function to calculate grid emissions for a metering point

Write code that takes a metering point id and a time range as arguments, and calculates the grid emissions.
