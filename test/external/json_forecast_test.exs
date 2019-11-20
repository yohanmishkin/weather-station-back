defmodule External.JsonForecastTest do
  use ExUnit.Case, async: true

  alias WeatherStation.Person

  test "translates json to people" do
    json = %{
      "name" => "Sunday",
      "shortForecast" => "Sunny"
    }

    forecast = External.JsonForecast.translate(json)

    assert forecast.short_description == "Sunny"
    assert forecast.period == "Sunday"
  end
end
