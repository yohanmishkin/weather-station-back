defmodule WeatherStationWeb.ForecastController do
  use WeatherStationWeb, :controller

  action_fallback WeatherStationWeb.FallbackController

  def index(conn, params) do
    render(conn, "index.json", forecast: %{})
    # people = People.get_all()
    # render(conn, "index.json", people: people)
  end
end
