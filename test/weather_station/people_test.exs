defmodule WeatherStation.PeopleTest do
  use ExUnit.Case, async: true

  import Mox

  setup :verify_on_exit!

  test "can get all the people from the rolodex" do
    person = %{name: "some name", temperature: 42}

    WeatherStation.RolodexMock
    |> expect(:get_people, fn -> [person, person, person] end)

    assert WeatherStation.People.get_all() |> length() == 3
  end
end
