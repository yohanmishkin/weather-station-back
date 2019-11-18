defmodule External.NationalWeatherServiceApi do
  # alias WeatherStation.Person
  @behaviour WeatherStation.WeatherApi

  use HTTPoison.Base

  alias External.JsonForecast

  def get_forecasts(lat, long) do
    #
    #   National Weather Service API likes precision <= 4
    #
    #   > "The precision of latitude/longitude points is limited to 4 decimal digits for efficiency. 
    #     The location attribute contains your request mapped to the nearest supported point. 
    #     If your client supports it, you will be redirected."
    #
    trimmed_lat = Float.round(lat, 4)
    trimmed_long = Float.round(long, 4)

    location_details =
      HTTPoison.get!("https://api.weather.gov/points/#{trimmed_lat},#{trimmed_long}")

    forecast_url = Jason.decode!(location_details.body)["properties"]["forecast"]

    forecast = HTTPoison.get!(forecast_url)

    Jason.decode!(forecast.body)["properties"]["periods"]
    |> Enum.map(fn forecast -> JsonForecast.translate(forecast) end)
  end
end