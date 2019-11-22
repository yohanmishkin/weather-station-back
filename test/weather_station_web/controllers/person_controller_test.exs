defmodule WeatherStationWeb.PersonControllerTest do
  use WeatherStationWeb.ConnCase

  import Mox

  alias WeatherStation.People.Person

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "GET /api/people" do
    test "lists all people", %{conn: conn} do
      WeatherStation.People.RolodexMock
      |> expect(:get_people, fn -> [] end)

      conn = get(conn, "/api/people")

      assert json_response(conn, 200) == []
    end
  end

  describe "GET /api/people/:id" do
    test "gets a person", %{conn: conn} do
      person = %Person{
        :id => "Person1234",
        :lat => 1234,
        :long => 5678,
        :name => "Jik jak"
      }

      WeatherStation.People.RolodexMock
      |> expect(:get_people, fn -> [person] end)

      conn = get(conn, "/api/people/#{person.id}")

      assert json_response(conn, 200) == %{
               "id" => person.id,
               "imageUrl" => nil,
               "name" => person.name,
               "lat" => 1234,
               "long" => 5678
             }
    end
  end
end
