defmodule WeatherStation.Weather do
  @moduledoc """
  The Weather context.
  """

  @weather_api Application.get_env(:weather_station, :weather_api)

  @doc """
  Returns the list of forecasts for a set of geo-coordinates

  ## Examples

      iex> get_forecasts(81.34, 34.81)
      [%{}, ...]

  """
  def get_forecasts(lat, long) do
    @weather_api.get_forecasts(lat, long)
  end

  @doc """
  Returns the current weather for a set of geo-coordinates

  ## Examples

      iex> get_current_weather(81.34, 34.81)
      [%{}, ...]

  """
  def get_current_weather(lat, long) do
    @weather_api.get_current_weather(lat, long)
  end
end
