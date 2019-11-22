defmodule WeatherStation.People.EmployeesAgent do
  use Agent

  alias WeatherStation.People.Rolodex

  @behaviour Rolodex

  @dock_yard_api Application.get_env(:weather_station, :dock_yard_api)

  @doc """
  Starts a new rolodex agent
  """
  def start_link(_opts) do
    Agent.start_link(fn -> fetch_people() end, name: __MODULE__)
  end

  @impl Rolodex
  def get_people do
    Agent.get(__MODULE__, fn people -> people end)
  end

  defp fetch_people do
    @dock_yard_api.get_employees()
    |> Enum.filter(fn person ->
      person.deactivated == false && (person.lat != nil && person.long != nil)
    end)
  end
end
