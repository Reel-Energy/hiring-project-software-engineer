# Take home assignment

This is the take home assignment for the Senior Software Engineer, Energy Billing position at Reel. If you have any questions about the task, feel free to write
to [Christian Kjær](mailto:ckl@reel.energy).

Once you are done, please send the solution to [Christian Kjær](mailto:ckl@reel.energy) as a zip file together with a short explainer of what you
did and why.

You are free to use AI tools for solving the assignment.

## Background

At Reel we buy electricity from solar parks and wind farms and sell it on the power market. The market price
changes every hour (and since October 2025 every 15 minutes).

Some producers prefer selling the power from their assets at a fixed price. We give them that with an *adjustment*: the producer sells their electricity on the market at the
market price (also called the *spot price*), and for every period we calculate the difference between the spot price
and the agreed price (the *contract price*):

```
adjustment_dkk = (spot_price - contract_price) * quantity
```

If the spot price is above the contract price the producer pays us the difference. If the spot price is below the contract
price we pay the producer the difference (a negative adjustment). Either way the producer ends up
with the contract price for every kWh they produced. As an example, if a solar park produced 2000 kWh in an hour where the
spot price is 0.72 DKK/kWh and the contract price is 0.60 DKK/kWh, the adjustment for that hour is `(0.72 - 0.60) * 2000 = 240 DKK`,
which the producer pays us. In an hour where the spot price is 0.42 DKK/kWh the adjustment is `(0.42 - 0.60) * 2000 = -360 DKK`,
which we pay the producer.

Once a month we sum the periods and invoice the producer for the total.

## Data

Each solar park or wind farm has a *metering point*: the electricity meter that measures how much it produces, identified by
an 18-digit id. The meter readings in the data are the production per period for that metering point.

We have included some example data for meter readings for two metering points, together with
SQL scripts to store them. The metering points are in different *price areas* (DK1 is western Denmark, DK2 is eastern Denmark),
and each price area has its own spot price. Each metering point has its own contract price:

| Metering point     | Price area | Contract price |
|--------------------|------------|----------------|
| 571313113162366344 | DK1        | 0.60 DKK/kWh   |
| 571313161170107671 | DK2        | 0.55 DKK/kWh   |

The spot prices are publicly available on [Energidataservice](https://www.energidataservice.dk), but are split into two separate datasets:

- [Elspot Prices](https://www.energidataservice.dk/tso-electricity/Elspotprices) has hourly prices up to and including September 30th 2025.
- [Day-Ahead Prices](https://www.energidataservice.dk/tso-electricity/DayAheadPrices) has 15 minute prices from October 1st 2025.

Both are served from the same API (`https://api.energidataservice.dk/dataset/<DatasetName>`), see the
[API guide](https://www.energidataservice.dk/guides/api-guides).

Your task is to extend the data model with the spot prices and calculate the monthly adjustment totals.

You should not spend more than a couple of hours on the task, and if you don't complete all the parts, then think about how you would solve them.

You are free to use whatever programming language and libraries that you want, but if you choose to use Elixir, there is some example code for
fetching JSON and talking to postgres in the `billing` folder. You can install Elixir using the [Official guide](https://elixir-lang.org/install.html).
Note that the example code is not a great example of production quality Elixir.

## Initial task: Setting up a postgres instance

There are some scripts setting up an initial postgres schema in the `sql` folder. If
you need a postgres running locally, you can start one easily with Docker:

```
$ docker run -e POSTGRES_PASSWORD=postgres -d -p 5432:5432 postgres:latest
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
postgres=# select metering_point_id, resolution, round(sum(quantity_kwh)::numeric, 3) from meter_readings group by 1, 2 order by 1, 2;
 metering_point_id  | resolution |   round
--------------------+------------+------------
 571313113162366344 | PT15M      | 311205.600
 571313113162366344 | PT1H       | 428120.200
 571313161170107671 | PT15M      |    322.730
 571313161170107671 | PT1H       |    384.260
```

## 1. Design an SQL table for the spot prices

In the first part of the exercise, you should create a new file `03_create_spot_prices_table.sql`
with the relevant `CREATE TABLE...` statement to create a table to store the spot prices. The table
should be able to hold prices from both datasets.

## 2. Write a function to fetch the spot prices and store them in the table

Write code to fetch, parse and store the spot prices for both price areas for the period covered by the meter readings. You can use the provided Elixir boilerplate,
or you can use whatever programming language and libraries that you are most comfortable with.

## 3. Implement a function to calculate the monthly total

Write code that takes a metering point id and a month as arguments, and returns the total adjustment to invoice for that month.
