defmodule WeatherStation.Weather do
  @moduledoc """
  The Weather context.
  """

  @weather_api Application.get_env(:weather_station, :weather_api)

  @doc """
  Returns the list of forecasts for a given set of geo-cordinates

  ## Examples

      iex> get_forecasts(81.34, 34.81)
      [%Person{}, ...]

  """
  def get_forecasts(lat, long) do
    @weather_api.get_forecasts(lat, long)
  end
end
