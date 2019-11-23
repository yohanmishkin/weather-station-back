defmodule External.NationalWeatherService.JsonWeather do
  def translate(period_json) do
    %{"temperature" => temperature, "shortForecast" => type} = period_json

    %{:type => type, :temperature => temperature}
  end
end
