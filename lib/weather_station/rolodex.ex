defmodule WeatherStation.Rolodex do
  @doc """

  Gets all the people from the GenServer

  """
  @callback get_people() :: [%{}]
end
