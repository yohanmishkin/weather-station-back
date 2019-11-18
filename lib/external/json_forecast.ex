defmodule External.JsonForecast do
  def translate(json) do
    %{"shortForecast" => short_description} = json

    %{:short_description => short_description}
  end
end
