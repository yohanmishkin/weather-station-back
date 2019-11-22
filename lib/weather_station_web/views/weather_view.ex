defmodule WeatherStationWeb.WeatherView do
  use WeatherStationWeb, :view
  alias WeatherStationWeb.WeatherView

  def render("index.json", %{weather: weather}) do
    render_one(weather, WeatherView, "weather.json")
  end

  def render("weather.json", %{weather: weather}) do
    weather
  end
end
