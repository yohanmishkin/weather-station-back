defmodule External.JsonPersonTest do
  use ExUnit.Case, async: true

  alias WeatherStation.Person

  test "translates json to people" do
    json = %{
      "id" => "yig-yag",
      "attributes" => %{
        "address" => "12 Candy Lane",
        "avatar-full" => "www.picture.com/1.jpg",
        "first-name" => "Charles",
        "deactivated-at" => "2016-02-01T14:10:39.000000",
        "last-name" => "Jack",
      }
    }

    %Person{} = person = External.JsonPerson.translate(json)

    assert person.address == "12 Candy Lane"
    assert person.deactivated == true
    assert person.image_url == "www.picture.com/1.jpg"
    assert person.name == "Charles Jack"
  end
end
