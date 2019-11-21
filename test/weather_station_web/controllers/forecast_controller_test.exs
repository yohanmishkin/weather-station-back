defmodule WeatherStationWeb.ForecastControllerTest do
  use WeatherStationWeb.ConnCase

  import Mox

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "GET /api/forecast?lat=&long=" do
    test "gets a list of forecasts", %{conn: conn} do
      lat = 123.456
      long = 456.123

      WeatherStation.WeatherApiMock
      |> expect(:get_forecasts, fn _lat, _long ->
        [
          %{period: "Monday", short_description: "blah blah blah"},
          %{period: "Tuesday", short_description: "blah blah blah"},
          %{period: "Sunday", short_description: "blah blah blah"}
        ]
      end)

      conn = get(conn, "/api/forecast?lat=#{lat}&long=#{long}")

      response = json_response(conn, 200)

      assert length(response) == 3
    end
  end
end
