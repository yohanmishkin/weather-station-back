defmodule WeatherStationWeb.Router do
  use WeatherStationWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", WeatherStationWeb do
    pipe_through :api
  end
end
