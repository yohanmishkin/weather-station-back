defmodule WeatherStation.Weather.CacheAgentTest do
  use ExUnit.Case

  import Mox

  setup :set_mox_global
  setup :verify_on_exit!

  @moduletag :qwer

  test "forecast cache miss" do
    {:ok, _pid} = WeatherStation.Weather.CacheAgent.start_link(%{})
    {:not_found, _} = WeatherStation.Weather.CacheAgent.get_forecasts(1234, 1234)
  end

  test "forecast cache hit" do
    lat = 1234
    long = 1234

    {:ok, _pid} =
      WeatherStation.Weather.CacheAgent.start_link(%{
        "#{lat}-#{long}-forecasts" => [%{:period => "tomorrow", :short_description => "sunny"}]
      })

    {:ok, forecasts} = WeatherStation.Weather.CacheAgent.get_forecasts(lat, long)

    forecast = List.first(forecasts)
    assert forecast.period == "tomorrow"
    assert forecast.short_description == "sunny"
  end

  test "fill forecast cache" do
    lat = 1234
    long = 1234

    {:ok, _pid} = WeatherStation.Weather.CacheAgent.start_link(%{})

    :ok =
      WeatherStation.Weather.CacheAgent.put_forecasts(lat, long, [
        %{:period => "tomorrow", :short_description => "sunny"}
      ])

    {:ok, forecasts} = WeatherStation.Weather.CacheAgent.get_forecasts(lat, long)

    assert length(forecasts) == 1
  end

  test "weather cache miss" do
    {:ok, _pid} = WeatherStation.Weather.CacheAgent.start_link(%{})
    {:not_found, _} = WeatherStation.Weather.CacheAgent.get_weather(1234, 1234)
  end

  test "weather cache hit" do
    lat = 1234
    long = 1234

    {:ok, _pid} =
      WeatherStation.Weather.CacheAgent.start_link(%{
        "#{lat}-#{long}-weather" => [%{:period => "tomorrow", :short_description => "sunny"}]
      })

    {:ok, weather} = WeatherStation.Weather.CacheAgent.get_weather(lat, long)

    forecast = List.first(weather)
    assert forecast.period == "tomorrow"
    assert forecast.short_description == "sunny"
  end

  test "fill weather cache" do
    lat = 1234
    long = 1234

    {:ok, _pid} = WeatherStation.Weather.CacheAgent.start_link(%{})

    :ok =
      WeatherStation.Weather.CacheAgent.put_weather(lat, long, [
        %{:period => "tomorrow", :short_description => "sunny"}
      ])

    {:ok, weather} = WeatherStation.Weather.CacheAgent.get_weather(lat, long)
  end
end
