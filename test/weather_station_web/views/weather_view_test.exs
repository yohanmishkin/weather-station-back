defmodule WeatherStationWeb.WeatherViewTest do
  use WeatherStationWeb.ConnCase, async: true

  import Phoenix.View

  test "renders weather" do
    weather = %{:type => "sunny", :temperature => 2.7777777777777715}

    payload = render(WeatherStationWeb.WeatherView, "index.json", weather: weather)

    assert payload == %{:type => "sunny", :temperature => 3 }
  end
end
