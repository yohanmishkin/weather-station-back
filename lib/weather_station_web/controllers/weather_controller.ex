defmodule WeatherStationWeb.WeatherController do
  use WeatherStationWeb, :controller

  alias WeatherStation.Weather

  action_fallback WeatherStationWeb.FallbackController

  def index(conn, params) do
    %{"lat" => lat_param, "long" => long_param} = params

    {lat, _} = Float.parse(lat_param)
    {long, _} = Float.parse(long_param)

    weather = Weather.get_current_weather(lat, long)

    render(conn, "index.json", weather: weather)
  end
end
