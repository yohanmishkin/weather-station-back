defmodule External.JsonPersonTest do
  use ExUnit.Case, async: true

  alias WeatherStation.Person

  test "translates json to people" do
    json = %{
      "attributes" => %{
        "address" => "12 Candy Lane",
        "avatar-full" => "www.picture.com/1.jpg",
        "first-name" => "Charles",
        "deactivated-at" => "2016-02-01T14:10:39.000000",
        "last-name" => "Jack",
        "location" => "Cucumber Farms"
      }
    }

    %Person{} = person = External.JsonPerson.translate(json)

    assert person.address == "12 Candy Lane"
    assert person.deactivated == true
    assert person.name == "Charles Jack"
    assert person.image_url == "www.picture.com/1.jpg"
    assert person.location == "Cucumber Farms"
  end
end
