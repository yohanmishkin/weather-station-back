defmodule External.NationalWeatherService.JsonForecast do
  def translate(json) do
    %{"name" => period, "shortForecast" => short_description} = json

    %{:period => period, :short_description => short_description}
  end
end
