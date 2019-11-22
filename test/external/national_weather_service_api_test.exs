defmodule External.NationalWeatherServiceApi.HttpTest do
  use ExUnit.Case, async: true

  alias WeatherStation.Person

  @moduletag :external

  describe "national weather service api" do
    External.NationalWeatherServiceApi.start()

    test "fetches forecasts for geo-coordinates" do
      forecasts = External.NationalWeatherServiceApi.get_forecasts(33.6845673, -117.8265049)

      [forecast = %{} | _] = forecasts

      assert length(forecasts) > 1
      assert forecast.short_description != nil
    end

    test "fetches weather for geo-coordinates" do
      weather = External.NationalWeatherServiceApi.get_current_weather(33.6845673, -117.8265049)

      assert weather.type == "rain_showers"
      assert weather.temperature == 17.77777777777783
    end
  end
end
