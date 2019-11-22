defmodule WeatherStationWeb.ForecastController do
  use WeatherStationWeb, :controller

  alias WeatherStation.Weather

  action_fallback WeatherStationWeb.FallbackController

  def index(conn, params) do
    %{"lat" => lat_param, "long" => long_param} = params

    {lat, _} = Float.parse(lat_param)
    {long, _} = Float.parse(long_param)

    forecasts = Weather.get_forecasts(lat, long)

    render(conn, "index.json", forecasts: forecasts)
  end
end
