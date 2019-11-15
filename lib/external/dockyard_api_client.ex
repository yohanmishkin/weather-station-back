defmodule External.DockYardApiClient do
  use HTTPoison.Base

  def get_employees do
    response = HTTPoison.get!("https://dockyard.com/api/employees")
    Jason.decode!(response.body)["data"]
  end
end
