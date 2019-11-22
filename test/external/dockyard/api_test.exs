defmodule External.DockYard.ApiTest do
  use ExUnit.Case, async: true

  alias WeatherStation.People.Person

  @moduletag :external

  describe "dockyard api" do
    External.DockYard.Api.Http.start()

    test "fetches list of employees" do
      employees = External.DockYard.Api.Http.get_employees()

      [%Person{} | _] = employees

      assert length(employees) > 1
    end
  end
end
