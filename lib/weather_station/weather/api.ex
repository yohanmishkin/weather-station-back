defmodule WeatherStation.Weather.Api do
  @doc """
  Gets all the forecasts for a lat/long from the National Weather Service
  """
  @callback get_forecasts(float, float) :: [%{}]

  @doc """
  Gets the current weather for a lat/long from the National Weather Service
  """
  @callback get_current_weather(float, float) :: %{}
end
