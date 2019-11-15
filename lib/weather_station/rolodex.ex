defmodule WeatherStation.Rolodex do

  @doc """
  Gets all the people from the GenServer
  """
  @callback get_people() :: [%{}]
end

defmodule WeatherStation.AgentRolodex do
  use Agent

  @behavior WeatherStation.Rolodex

  @doc """
  Starts a new rolodex
  """
  def start_link(_opts) do
    Agent.start_link(fn -> %{} end)
  end

  @impl
  def get_people do
    External.DockYardApiClient.get_employees()
  end
end
