defmodule MeterReading do
  # Type spec for a map with a meter reading
  @type meter_reading :: %{
          metering_point_id: String.t(),
          time: DateTime.t(),
          resolution: String.t(),
          quantity_kwh: float()
        }

  @spec get_in_period(
          pid(),
          metering_point_id :: String.t(),
          from :: DateTime.t(),
          to :: DateTime.t()
        ) :: [meter_reading()]
  @doc """
    Example code for reading some rows from Postgres. You get the connection
    from calling `Billing.db_connection!/0`
  """
  def get_in_period(conn, metering_point_id, from, to) do
    Postgrex.query!(
      conn,
      "SELECT metering_point_id, time, resolution, quantity_kwh FROM meter_readings WHERE metering_point_id = $1 AND time >= $2 AND time < $3",
      [metering_point_id, from, to]
    )
    |> then(& &1.rows)
    |> Enum.map(fn [mp_id, time, resolution, quantity_kwh] ->
      %{metering_point_id: mp_id, time: time, resolution: resolution, quantity_kwh: quantity_kwh}
    end)
  end
end
