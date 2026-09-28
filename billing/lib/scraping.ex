defmodule Scraping do
  @spec scrape_stuff() :: map()
  @doc """
    Example for fetching some json from an "API"
  """
  def scrape_stuff() do
    Req.get!("https://slamko.de/example.json").body
  end
end
