defmodule WeatherStation.WeatherApi do
  @doc """
  Gets all the forecasts for a lat/long from the National Weather Service
  """
  @callback get_forecasts(float, float) :: [%{}]
end
