defmodule External.JsonPersonTest do
  use ExUnit.Case, async: true

  alias WeatherStation.Person

  test "translates json to people" do
    json = %{
      "id" => "yig-yag",
      "attributes" => %{
        "avatar-full" => "www.picture.com/1.jpg",
        "first-name" => "Charles",
        "deactivated-at" => "2016-02-01T14:10:39.000000",
        "location" => %{"lat" => 123.4, "lng" => 12.32},
        "last-name" => "Jack"
      }
    }

    %Person{} = person = External.JsonPerson.translate(json)

    assert person.location == %{lat: 123.4, long: 12.32}
    assert person.deactivated == true
    assert person.image_url == "www.picture.com/1.jpg"
    assert person.name == "Charles Jack"
  end

  test "handles people without locations" do
    json = %{
      "id" => "no-location",
      "attributes" => %{
        "location" => nil,
        "avatar-full" => nil,
        "first-name" => nil,
        "deactivated-at" => nil,
        "last-name" => nil
      }
    }

    person = External.JsonPerson.translate(json)

    assert person.location == nil
  end
end
