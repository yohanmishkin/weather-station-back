defmodule External.NationalWeatherService.JsonForecastTest do
  use ExUnit.Case, async: true

  test "translates json to forecast" do
    json = %{
      "name" => "Sunday",
      "shortForecast" => "Sunny"
    }

    forecast = External.NationalWeatherService.JsonForecast.translate(json)

    assert forecast.short_description == "Sunny"
    assert forecast.period == "Sunday"
  end
end
