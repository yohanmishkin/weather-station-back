defmodule External.JsonForecastTest do
  use ExUnit.Case, async: true

  alias WeatherStation.Person

  test "translates json to people" do
    json = %{
      "shortForecast" => "Sunny"
    }

    forecast = External.JsonForecast.translate(json)

    assert forecast.short_description == "Sunny"
  end
end
