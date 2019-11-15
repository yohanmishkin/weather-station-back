Mox.defmock(WeatherStation.RolodexMock, for: WeatherStation.Rolodex)
ExUnit.start()
ExUnit.configure(exclude: [:external])