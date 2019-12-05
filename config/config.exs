# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

# Configures the endpoint
config :weather_station, WeatherStationWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "9ETjPOnncaN8M471bmK5UQFqvmifyb5JUaWNx9vSWxnP3F85MD2SJCK7RyI+kegt",
  render_errors: [view: WeatherStationWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: WeatherStation.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :weather_station, :dock_yard_api, External.DockYard.Api.Http
config :weather_station, :weather_api, External.NationalWeatherService.Api
# config :weather_station, :weather_cache, External.Weather.CacheAgent
config :weather_station, :rolodex, WeatherStation.People.EmployeesAgent

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
