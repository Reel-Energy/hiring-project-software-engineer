# Emissions

This example project contains some code to get started on the hiring project.

You can use iex to run your functions:

```
$ iex -S mix
Erlang/OTP 28 [erts-16.3.1] [source] [64-bit] [smp:16:16] [ds:16:16:10] [async-threads:1] [jit:ns]

Compiling 2 files (.ex)
Generated emissions app
Interactive Elixir (1.19.5) - press Ctrl+C to exit (type h() ENTER for help)
iex(1)> conn = Emissions.db_connection!
#PID<0.236.0>
iex(2)> MeterReading.get_in_period(conn, "571313161170107671", ~U[2026-04-01 12:00:00Z], ~U[2026-04-01 13:00:00Z])
[
  %{
    time: ~U[2026-04-01 12:00:00.000000Z],
    metering_point_id: "571313161170107671",
    resolution: "PT1H",
    quantity_kwh: 0.86
  }
]
iex(3)> Scraping.scrape_stuff()
%{"hello" => "world"}
```


The code uses [Req](https://hexdocs.pm/req/Req.html) for making HTTP requests, and [Postgrex](https://hexdocs.pm/postgrex/Postgrex.html)
for talking to Postgres.

In the `Emissions` module there is a function for getting a database connection
(assuming that the postgres is running on localhost with `postgres` as user/password/db_name).
