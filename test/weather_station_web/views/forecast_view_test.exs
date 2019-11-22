defmodule WeatherStationWeb.ForecastViewTest do
  use WeatherStationWeb.ConnCase, async: true

  import Phoenix.View

  alias WeatherStation.Person

  test "renders forecasts" do
    forecast = %{:period => "nancy", :short_description => "www.picture.com/1.jpg"}

    assert render(WeatherStationWeb.ForecastView, "index.json", %{forecasts: [forecast]}) == [
             %{
               :shortDescription => "www.picture.com/1.jpg",
               :period => "nancy"
             }
           ]
  end
end
