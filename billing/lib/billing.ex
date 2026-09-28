defmodule Billing do
  @moduledoc """
  Documentation for `Billing`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Billing.hello()
      :world

  """
  def hello do
    :world
  end

  @spec db_connection! :: pid()
  def db_connection! do
    {:ok, pid} =
      Postgrex.start_link(
        hostname: "localhost",
        port: 5432,
        username: "postgres",
        password: "postgres",
        database: "postgres"
      )

    pid
  end
end
