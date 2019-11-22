defmodule WeatherStation.People.Person do
  defstruct [:id, :image_url, :lat, :long, :name, deactivated: false]
end
