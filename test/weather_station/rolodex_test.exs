defmodule WeatherStation.RolodexTest do
  use ExUnit.Case

  import Mox

  setup :set_mox_global
  setup :verify_on_exit!

  test "gathers list of people on startup" do
    External.DockYardApiMock |> expect(:get_employees, fn -> [%{}, %{}, %{}] end)

    {:ok, _pid} = WeatherStation.AgentRolodex.start_link([])

    people = WeatherStation.AgentRolodex.get_people()

    assert length(people) > 1
  end
end
