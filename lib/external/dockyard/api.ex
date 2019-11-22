defmodule External.DockYard.Api do
  alias WeatherStation.People.Person

  @doc """
  Gets all the employees from DockYard api
  """
  @callback get_employees() :: [%Person{}]

  defmodule Http do
    use HTTPoison.Base

    alias External.DockYard.JsonPerson

    @behaviour Api

    @impl Api
    def get_employees do
      response = HTTPoison.get!("https://dockyard.com/api/employees")

      Jason.decode!(response.body)["data"]
      |> Enum.map(fn employee -> JsonPerson.translate(employee) end)
    end
  end
end
