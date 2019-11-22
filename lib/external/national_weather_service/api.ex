defmodule External.NationalWeatherService.Api do
  use HTTPoison.Base

  alias External.NationalWeatherService.JsonForecast
  alias External.NationalWeatherService.JsonWeather

  @behaviour WeatherStation.Weather.Api

  @impl WeatherStation.Weather.Api
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

  @impl WeatherStation.Weather.Api
  def get_current_weather(lat, long) do
    trimmed_lat = Float.round(lat, 4)
    trimmed_long = Float.round(long, 4)

    location_details =
      HTTPoison.get!("https://api.weather.gov/points/#{trimmed_lat},#{trimmed_long}")

    weather_url = Jason.decode!(location_details.body)["properties"]["forecastGridData"]

    weather_response = HTTPoison.get!(weather_url)

    JsonWeather.translate(
      Jason.decode!(weather_response.body)["properties"]["temperature"]["values"],
      Jason.decode!(weather_response.body)["properties"]["weather"]["values"]
    )
  end
end
