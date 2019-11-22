defmodule WeatherStation.PeopleTest do
  use ExUnit.Case, async: true

  import Mox

  alias WeatherStation.People.Person

  setup :verify_on_exit!

  test "can get all the people from the rolodex" do
    person = %{name: "some name", temperature: 42}

    WeatherStation.People.RolodexMock
    |> expect(:get_people, fn -> [person, person, person] end)

    people = WeatherStation.People.get_all()

    assert length(people) == 3
  end

  test "can get a person" do
    location = %{lat: 1234, long: 5678}

    WeatherStation.People.RolodexMock
    |> expect(:get_people, fn ->
      [%Person{id: "yipyap", name: "some name", lat: location.lat, long: location.long}]
    end)

    person = WeatherStation.People.get!("yipyap")

    %Person{:id => "yipyap", :lat => 1234, :long => 5678} = person
  end
end
