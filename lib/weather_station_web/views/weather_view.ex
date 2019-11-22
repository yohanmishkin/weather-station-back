defmodule WeatherStationWeb.WeatherView do
  use WeatherStationWeb, :view
  alias WeatherStationWeb.WeatherView

  def render("index.json", %{weather: weather}) do
    render_one(weather, WeatherView, "weather.json")
  end

  def render("weather.json", %{weather: weather}) do
    %{
      :type => weather.type,
      :temperature =>
        if is_float(weather.temperature) do
          Float.round(weather.temperature, 0)
        else
          {temp, _} = Integer.parse("#{weather.temperature}")
          temp
        end
    }
  end
end
