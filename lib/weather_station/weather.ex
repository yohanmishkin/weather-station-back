defmodule WeatherStation.Weather do
  @moduledoc """
  The Weather context.
  """

  @weather_api Application.get_env(:weather_station, :weather_api)
  @weather_cache Application.get_env(:weather_station, :weather_cache)

  @doc """
  Returns the list of forecasts for a set of geo-coordinates

  ## Examples

      iex> get_forecasts(81.34, 34.81)
      [%{}, ...]

  """
  def get_forecasts(lat, long) do
    case @weather_cache.get_forecasts(lat, long) do
      {:ok, forecasts} ->
        forecasts

      {:not_found, _error} ->
        api_forecast = @weather_api.get_forecasts(lat, long)
        @weather_cache.put_forecasts(lat, long, api_forecast)
        api_forecast
    end
  end

  @doc """
  Returns the current weather for a set of geo-coordinates

  ## Examples

      iex> get_current_weather(81.34, 34.81)
      %{}

  """
  def get_current_weather(lat, long) do
    case @weather_cache.get_current_weather(lat, long) do
      {:ok, weather} ->
        weather

      {:not_found, _error} ->
        api_weather = @weather_api.get_current_weather(lat, long)
        @weather_cache.put_current_weather(lat, long, api_weather)
        api_weather
    end
  end
end
