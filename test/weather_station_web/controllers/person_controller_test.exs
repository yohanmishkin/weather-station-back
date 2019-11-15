defmodule WeatherStationWeb.PersonControllerTest do
  use WeatherStationWeb.ConnCase

  import Mox
  # alias WeatherStation.People
  # alias WeatherStation.People.Person

  # @create_attrs %{
  #   name: "some name",
  #   temperature: 42
  # }

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all people", %{conn: conn} do
      WeatherStation.RolodexMock
      |> expect(:get_people, fn -> [] end)

      conn = get(conn, "/api/people")

      assert json_response(conn, 200)["data"] == []
    end
  end
end
