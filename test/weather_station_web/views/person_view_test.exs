defmodule WeatherStationWeb.PersonViewTest do
  use WeatherStationWeb.ConnCase, async: true

  import Phoenix.View

  alias WeatherStation.People.Person

  test "renders person with forecasts" do
    person = %Person{
      :id => "person1234",
      :image_url => "www.picture.com/1.jpg",
      :name => "nancy",
      :deactivated => false,
      :lat => 123,
      :long => 456
    }

    assert render(WeatherStationWeb.PersonView, "show.json", %{person: person}) == %{
             :id => "person1234",
             :imageUrl => "www.picture.com/1.jpg",
             :name => "nancy",
             :lat => 123,
             :long => 456
           }
  end
end
