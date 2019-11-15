defmodule WeatherStation.Rolodex do

  @doc """
  Gets all the people from the GenServer
  """
  @callback get_people() :: [%{}]
end

defmodule WeatherStation.AgentRolodex do
  use Agent

  @behavior WeatherStation.Rolodex

  @dock_yard_api Application.get_env(:weather_station, :dock_yard_api)

  @doc """
  Starts a new rolodex
  """
  def start_link(_opts) do
    Agent.start_link(fn -> fetch_people() end, name: __MODULE__)
  end

  @impl
  def get_people do
    Agent.get(__MODULE__, fn people -> people end)
  end

  defp fetch_people do
    @dock_yard_api.get_employees()
    |> Enum.map(fn x -> json_employee_to_person(x) end)
  end

  defp json_employee_to_person(json) do
    %{}
  end
end
