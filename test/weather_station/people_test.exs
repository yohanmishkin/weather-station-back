defmodule WeatherStation.PeopleTest do
  use ExUnit.Case, async: true

  import Mox

  alias WeatherStation.Person

  setup :verify_on_exit!

  test "can get all the people from the rolodex" do
    person = %{name: "some name", temperature: 42}

    WeatherStation.RolodexMock
    |> expect(:get_people, fn -> [person, person, person] end)

    people = WeatherStation.People.get_all()

    assert length(people) == 3
  end

  test "can get a person with forecasts" do
    location = %{lat: 1234, long: 5678}

    WeatherStation.RolodexMock
    |> expect(:get_people, fn ->
      [%Person{id: "yipyap", name: "some name", location: location}]
    end)

    WeatherStation.WeatherApiMock
    |> expect(:get_forecasts, fn lat, long ->
      assert lat == location.lat
      assert long == location.long

      [%{short_description: "blah blah blah"}]
    end)

    person = WeatherStation.People.get!("yipyap")

    %Person{:id => "yipyap", :forecasts => [%{short_description: "blah blah blah"}]} = person
  end
end
