defmodule External.DockYardApi.HttpTest do
  use ExUnit.Case, async: true

  alias WeatherStation.Person

  @moduletag :external

  describe "dockyard api" do
    External.DockYardApi.Http.start()

    test "fetches list of employees" do
      employees = External.DockYardApi.Http.get_employees()

      [person = %Person{} | _] = employees

      assert length(employees) > 1
      assert person.image_url != nil
    end
  end
end
