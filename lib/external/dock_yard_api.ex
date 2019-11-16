defmodule External.DockYardApi do
  alias WeatherStation.Person

  @doc """
  Gets all the employees from DockYard api
  """
  @callback get_employees() :: [%Person{}]

  defmodule Http do
    use HTTPoison.Base

    alias External.JsonPerson

    @behaviour DockYardApi

    @impl DockYardApi
    def get_employees do
      response = HTTPoison.get!("https://dockyard.com/api/employees")

      Jason.decode!(response.body)["data"]
      |> Enum.map(fn employee -> JsonPerson.translate(employee) end)
    end
  end
end
