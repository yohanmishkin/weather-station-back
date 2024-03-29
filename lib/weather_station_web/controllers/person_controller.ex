defmodule WeatherStationWeb.PersonController do
  use WeatherStationWeb, :controller

  alias WeatherStation.People

  action_fallback WeatherStationWeb.FallbackController

  def index(conn, _params) do
    people = People.get_all()
    render(conn, "index.json", people: people)
  end

  def show(conn, %{"id" => id}) do
    person = People.get!(id)
    render(conn, "show.json", person: person)
  end
end
