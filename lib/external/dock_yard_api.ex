defmodule External.DockYardApi do
  @doc """
  Gets all the employees from DockYard api
  """
  @callback get_employees() :: []

  defmodule Http do
    use HTTPoison.Base

    @behaviour DockYardApi

    @impl DockYardApi
    def get_employees do
      response = HTTPoison.get!("https://dockyard.com/api/employees")
      Jason.decode!(response.body)["data"]
    end
  end
end
