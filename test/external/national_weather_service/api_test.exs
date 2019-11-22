defmodule External.NationalWeatherService.ApiTest do
  use ExUnit.Case, async: true

  @moduletag :external

  describe "national weather service api" do
    External.NationalWeatherService.Api.start()

    test "fetches forecasts for geo-coordinates" do
      forecasts = External.NationalWeatherService.Api.get_forecasts(39.7456,-97.0892)

      [forecast = %{} | _] = forecasts

      assert length(forecasts) > 1
      assert forecast.short_description != nil
    end

    test "fetches weather for geo-coordinates" do
      weather = External.NationalWeatherService.Api.get_current_weather(33.6845673, -117.8265049)

      assert weather.type == "rain_showers"
      assert weather.temperature == 17.77777777777783
    end
  end
end
