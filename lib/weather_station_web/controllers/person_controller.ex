defmodule WeatherStationWeb.PersonController do
  use WeatherStationWeb, :controller

  alias WeatherStation.People
  alias WeatherStation.People.Person

  action_fallback WeatherStationWeb.FallbackController

  def index(conn, _params) do
    people = People.list_people()
    render(conn, "index.json", people: people)
  end

  def show(conn, %{"id" => id}) do
    person = People.get_person!(id)
    render(conn, "show.json", person: person)
  end
end
