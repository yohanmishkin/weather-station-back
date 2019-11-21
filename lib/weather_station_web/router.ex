defmodule WeatherStationWeb.Router do
  use WeatherStationWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", WeatherStationWeb do
    pipe_through :api

    get "/people", PersonController, :index
    get "/people/:id", PersonController, :show
    get "/forecast", ForecastController, :index
  end
end
