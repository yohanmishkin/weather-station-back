defmodule WeatherStation.Weather.CacheAgentTest do
  use ExUnit.Case

  import Mox

  setup :set_mox_global
  setup :verify_on_exit!

  test "forecast cache miss" do
    {:ok, _pid} = WeatherStation.Weather.CacheAgent.start_link(%{})
    {:not_found, _} = WeatherStation.Weather.CacheAgent.get_forecasts(1234, 1234)
  end

  test "forecast cache expired" do
    lat = 1234
    long = 1234

    ten_minutes_ago = DateTime.utc_now() |> DateTime.add(-600, :second)

    {:ok, _pid} =
      WeatherStation.Weather.CacheAgent.start_link(%{
        String.to_atom("#{lat}-#{long}-forecasts") => %{
          :value => [%{:period => "tomorrow", :short_description => "sunny"}],
          :expiration => ten_minutes_ago
        }
      })

    {:expired, _} = WeatherStation.Weather.CacheAgent.get_forecasts(lat, long)
  end

  test "forecast cache hit" do
    lat = 1234
    long = 1234

    {:ok, _pid} =
      WeatherStation.Weather.CacheAgent.start_link(%{
        String.to_atom("#{lat}-#{long}-forecasts") => %{
          :value => [%{:period => "tomorrow", :short_description => "sunny"}],
          :expiration => DateTime.utc_now() |> DateTime.add(3600, :second)
        }
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
    {:not_found, _} = WeatherStation.Weather.CacheAgent.get_current_weather(1234, 1234)
  end

  test "weather cache expired" do
    lat = 1234
    long = 1234

    ten_minutes_ago = DateTime.utc_now() |> DateTime.add(-600, :second)

    {:ok, _pid} =
      WeatherStation.Weather.CacheAgent.start_link(%{
        String.to_atom("#{lat}-#{long}-weather") => %{
          :value => %{:type => "sunny", :temperature => 75},
          :expiration => ten_minutes_ago
        }
      })

    {:expired, _} = WeatherStation.Weather.CacheAgent.get_current_weather(lat, long)
  end

  test "weather cache hit" do
    lat = 1234
    long = 1234

    {:ok, _pid} =
      WeatherStation.Weather.CacheAgent.start_link(%{
        String.to_atom("#{lat}-#{long}-weather") => %{
          :value => %{:type => "sunny", :temperature => 75},
          :expiration => DateTime.utc_now() |> DateTime.add(3600, :second)
        }
      })

    {:ok, weather} = WeatherStation.Weather.CacheAgent.get_current_weather(lat, long)

    assert weather.type == "sunny"
    assert weather.temperature == 75
  end

  test "fill weather cache" do
    lat = 1234
    long = 1234

    {:ok, _pid} = WeatherStation.Weather.CacheAgent.start_link(%{})

    :ok =
      WeatherStation.Weather.CacheAgent.put_current_weather(lat, long, %{
        :period => "tomorrow",
        :short_description => "sunny"
      })

    {:ok, weather} = WeatherStation.Weather.CacheAgent.get_current_weather(lat, long)
  end
end
