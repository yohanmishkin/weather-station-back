defmodule WeatherStationWeb.ForecastView do
  use WeatherStationWeb, :view
  alias WeatherStationWeb.ForecastView

  def render("index.json", %{forecast: forecast}) do
    render_many(forecast, ForecastView, "forecast.json")
  end

  def render("forecast.json", %{}) do
    %{}
  end
end
