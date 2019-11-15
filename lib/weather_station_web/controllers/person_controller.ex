defmodule WeatherStationWeb.PersonController do
  use WeatherStationWeb, :controller

  alias WeatherStation.People

  action_fallback WeatherStationWeb.FallbackController

  def index(conn, _params) do
    people = People.get_all()
    render(conn, "index.json", people: people)
  end
end
