defmodule WeatherStationWeb.PersonView do
  use WeatherStationWeb, :view
  alias WeatherStationWeb.PersonView

  def render("index.json", %{people: people}) do
    render_many(people, PersonView, "person.json")
  end

  def render("show.json", %{person: person}) do
    render_one(person, PersonView, "person.json")
  end

  def render("person.json", %{person: person}) do
    %{
      id: person.id,
      imageUrl: person.image_url,
      name: person.name,
      lat: person.lat,
      long: person.long
    }
  end
end
