defmodule WeatherStationWeb.PersonControllerTest do
  use WeatherStationWeb.ConnCase

  import Mox

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "GET /api/people" do
    test "lists all people", %{conn: conn} do
      WeatherStation.RolodexMock
      |> expect(:get_people, fn -> [] end)

      conn = get(conn, "/api/people")

      assert json_response(conn, 200) == []
    end
  end

  # describe "GET /api/people/:id" do
  #   test "returns a person with forecasts", %{conn: conn} do
  #     person_a = %Person{}

  #     WeatherStation.RolodexMock
  #     |> expect(:get_people, fn -> [] end)

  #     conn = get(conn, "/api/people/#{person_a.id}")

  #     assert json_response(conn, 200)["data"] == []
  #   end
  # end
end
