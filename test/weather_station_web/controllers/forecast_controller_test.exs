defmodule WeatherStationWeb.ForecastControllerTest do
  use WeatherStationWeb.ConnCase

  import Mox

  # alias WeatherStation.Person

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "GET /api/forecast?lat=&long=" do
    test "gets a list of forecasts", %{conn: conn} do
      lat = 123.456
      long = 456.123
      # person = %Person{
      #   :id => "Person1234",
      #   :location => %{lat: 1234, long: 5678},
      #   :name => "Jik jak"
      # }

      WeatherStation.WeatherApiMock
      |> expect(:get_forecasts, fn _lat, _long ->
        [%{period: "Sunday", short_description: "blah blah blah"}]
      end)

      conn = get(conn, "/api/forecast?lat#{lat}&long=#{long}")

      assert json_response(conn, 200) == %{}
      #          "id" => person.id,
      #          "imageUrl" => nil,
      #          "name" => person.name,
      #          "forecasts" => [%{"period" => "Sunday", "shortDescription" => "blah blah blah"}]
      #        }
    end
  end
end
