defmodule WeatherStationWeb.WeatherControllerTest do
  use WeatherStationWeb.ConnCase

  import Mox

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "GET /api/weather?lat=&long=" do
    test "gets the current weather for geo-coordinates", %{conn: conn} do
      lat = 123.456
      long = 456.123

      WeatherStation.WeatherApiMock
      |> expect(:get_current_weather, fn _lat, _long ->
        %{type: "rain_showers", temperature: 78}
      end)

      conn = get(conn, "/api/weather?lat=#{lat}&long=#{long}")

      assert json_response(conn, 200) == %{"type" => "rain_showers", "temperature" => 78}
    end
  end
end
