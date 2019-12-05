defmodule WeatherStation.Weather.Cache do
  @doc """
  Gets all the forecasts for a lat/long from cache
  """
  @callback get_forecasts(float, float) :: [%{}]

  @doc """
  Gets the current weather for a lat/long from cache
  """
  @callback get_current_weather(float, float) :: %{}

  @doc """
  Caches the current weather for a lat/long 
  """
  @callback put_current_weather(float, float, %{}) :: %{}

  @doc """
  Caches the forecast for a lat/long 
  """
  @callback put_forecasts(float, float, %{}) :: %{}
end
