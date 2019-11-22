defmodule WeatherStation.People.Rolodex do
  alias WeatherStation.People.Person

  @doc """
  Gets all the people and makes them available
  """
  @callback get_people() :: [%Person{}]
end
