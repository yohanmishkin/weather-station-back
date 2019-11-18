defmodule WeatherStation.Rolodex do
  alias WeatherStation.Person

  @doc """
  Gets all the people and makes them available
  """
  @callback get_people() :: [%Person{}]

  defmodule Employees do
    use Agent

    @behaviour WeatherStation.Rolodex

    @dock_yard_api Application.get_env(:weather_station, :dock_yard_api)

    @doc """
    Starts a new rolodex agent
    """
    def start_link(_opts) do
      Agent.start_link(fn -> fetch_people() end, name: __MODULE__)
    end

    @impl WeatherStation.Rolodex
    def get_people do
      Agent.get(__MODULE__, fn people -> people end)
    end

    defp fetch_people do
      @dock_yard_api.get_employees()
      |> Enum.filter(fn person ->
        person.deactivated == false && person.location != nil
      end)
    end
  end
end
