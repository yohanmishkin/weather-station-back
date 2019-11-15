Mox.defmock(WeatherStation.RolodexMock, for: WeatherStation.Rolodex)
Mox.defmock(External.DockYardApiMock, for: External.DockYardApi)
ExUnit.start()
ExUnit.configure(exclude: [:external])
