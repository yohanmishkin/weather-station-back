defmodule WeatherStation.Person do
  defstruct [:id, :image_url, :location, :name, deactivated: false, forecasts: []]
end
