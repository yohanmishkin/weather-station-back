defmodule WeatherStation.RolodexTest do
  use ExUnit.Case

  import Mox

  alias WeatherStation.Person

  setup :set_mox_global
  setup :verify_on_exit!

  test "gathers list of people on startup" do
    External.DockYardApiMock
    |> expect(:get_employees, fn ->
      [create_person(%{}), create_person(%{}), create_person(%{})]
    end)

    {:ok, _pid} = WeatherStation.Rolodex.Employees.start_link([])

    [%Person{} | _] = people = WeatherStation.Rolodex.Employees.get_people()

    assert length(people) > 1
  end

  test "excludes deactivated employees" do
    External.DockYardApiMock
    |> expect(:get_employees, fn ->
      [create_person(%{deactivated: true}), create_person(%{}), create_person(%{})]
    end)

    {:ok, _pid} = WeatherStation.Rolodex.Employees.start_link([])

    people = WeatherStation.Rolodex.Employees.get_people()

    assert length(people) == 2
  end

  test "excludes out employees without locations" do
    External.DockYardApiMock
    |> expect(:get_employees, fn ->
      [
        create_person(%{location: %{lat: 123, long: 456}}),
        create_person(%{location: nil}),
        create_person(%{location: nil})
      ]
    end)

    {:ok, _pid} = WeatherStation.Rolodex.Employees.start_link([])

    people = WeatherStation.Rolodex.Employees.get_people()

    assert length(people) == 1
  end

  defp create_person(attrs) do
    Map.merge(
      %Person{
        :id => "person1234",
        :name => "nancy",
        :deactivated => false,
        :location => %{lat: 123, long: 456}
      },
      attrs
    )
  end
end
