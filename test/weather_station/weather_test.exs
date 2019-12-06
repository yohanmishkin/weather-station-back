defmodule WeatherStation.WeatherTest do
  use ExUnit.Case, async: true

  import Mox

  setup :verify_on_exit!

  test "weather is served from cache if available" do
    WeatherStation.Weather.CacheMock
    |> expect(:get_current_weather, fn _, __ ->
      {:ok, %{:type => 'cached-weather', :temperature => 1234}}
    end)

    WeatherStation.Weather.ApiMock
    |> expect(:get_current_weather, 0, fn _, __ -> nil end)

    weather = WeatherStation.Weather.get_current_weather(1234, 1234)

    assert weather.type == 'cached-weather'
    assert weather.temperature == 1234
  end

  test "weather is fetched from api and cached if not initially in cache" do
    WeatherStation.Weather.CacheMock
    |> expect(:get_current_weather, fn _, __ -> {:not_found, %{:message => 'not in cache'}} end)

    WeatherStation.Weather.CacheMock
    |> expect(:put_current_weather, fn lat, long, weather -> nil end)

    WeatherStation.Weather.ApiMock
    |> expect(:get_current_weather, fn _, __ ->
      %{:type => 'api-weather', :temperature => 1234}
    end)

    weather = WeatherStation.Weather.get_current_weather(1234, 1234)

    assert weather.type == 'api-weather'
    assert weather.temperature == 1234
  end

  test "weather is fetched from api and cached if expired" do
    WeatherStation.Weather.CacheMock
    |> expect(:get_current_weather, fn _, __ -> {:expired, %{:message => 'expired'}} end)

    WeatherStation.Weather.CacheMock
    |> expect(:put_current_weather, fn lat, long, weather -> nil end)

    WeatherStation.Weather.ApiMock
    |> expect(:get_current_weather, fn _, __ ->
      %{:type => 'api-weather', :temperature => 1234}
    end)

    weather = WeatherStation.Weather.get_current_weather(1234, 1234)

    assert weather.type == 'api-weather'
    assert weather.temperature == 1234
  end

  test "forecast is served from cache if available" do
    WeatherStation.Weather.CacheMock
    |> expect(:get_forecasts, fn _, __ ->
      {:ok, [%{}, %{}, %{}]}
    end)

    WeatherStation.Weather.ApiMock
    |> expect(:get_forecasts, 0, fn _, __ -> nil end)

    forecasts = WeatherStation.Weather.get_forecasts(1234, 1234)

    assert length(forecasts) == 3
  end

  test "forecast is fetched from api and cached if not initially in cache" do
    WeatherStation.Weather.CacheMock
    |> expect(:get_forecasts, fn _, __ -> {:not_found, %{:message => 'not in cache'}} end)

    WeatherStation.Weather.CacheMock
    |> expect(:put_forecasts, fn lat, long, forecasts -> nil end)

    WeatherStation.Weather.ApiMock
    |> expect(:get_forecasts, fn _, __ ->
      [%{}, %{}, %{}]
    end)

    forecasts = WeatherStation.Weather.get_forecasts(1234, 1234)

    assert length(forecasts) == 3
  end

  test "forecast is fetched from api and cached if expired" do
    WeatherStation.Weather.CacheMock
    |> expect(:get_forecasts, fn _, __ -> {:expired, %{:message => 'expired'}} end)

    WeatherStation.Weather.CacheMock
    |> expect(:put_forecasts, fn lat, long, forecasts -> nil end)

    WeatherStation.Weather.ApiMock
    |> expect(:get_forecasts, fn _, __ ->
      [%{}, %{}, %{}]
    end)

    forecasts = WeatherStation.Weather.get_forecasts(1234, 1234)

    assert length(forecasts) == 3
  end
end
