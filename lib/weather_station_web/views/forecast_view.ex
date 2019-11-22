defmodule WeatherStationWeb.ForecastView do
  use WeatherStationWeb, :view
  alias WeatherStationWeb.ForecastView

  def render("index.json", %{forecasts: forecasts}) do
    render_many(forecasts, ForecastView, "forecast.json")
  end

  def render("forecast.json", %{forecast: forecast}) do
    %{period: forecast.period, shortDescription: forecast.short_description}
  end
end
