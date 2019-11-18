defmodule WeatherStationWeb.PersonViewTest do
  use WeatherStationWeb.ConnCase, async: true

  # Bring render/3 and render_to_string/3 for testing custom views
  import Phoenix.View

  alias WeatherStation.Person

  test "renders person with forecasts" do
    person = %Person{
      :id => "person1234",
      :image_url => "www.picture.com/1.jpg",
      :name => "nancy",
      :deactivated => false,
      :location => %{lat: 123, long: 456},
      :forecasts => [%{short_description: "Sunny"}, %{short_description: "Partly Cloudy"}]
    }

    assert render(WeatherStationWeb.PersonView, "show.json", %{person: person}) == %{
             :id => "person1234",
             :imageUrl => "www.picture.com/1.jpg",
             :name => "nancy",
             :forecasts => [
               %{shortDescription: "Sunny"},
               %{shortDescription: "Partly Cloudy"}
             ]
           }
  end
end
