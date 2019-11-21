defmodule WeatherStationWeb.ForecastController do
  use WeatherStationWeb, :controller

  alias WeatherStation.Weather

  action_fallback WeatherStationWeb.FallbackController

  def index(conn, params) do
    %{"lat" => lat, "long" => long} = params

    forecast = Weather.get_forecasts(lat, long)

    render(conn, "index.json", forecast: forecast)
  end
end
