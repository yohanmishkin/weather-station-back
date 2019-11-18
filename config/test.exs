use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :weather_station, WeatherStationWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

config :weather_station, :rolodex, WeatherStation.RolodexMock
config :weather_station, :weather_api, WeatherStation.WeatherApiMock
config :weather_station, :dock_yard_api, External.DockYardApiMock
