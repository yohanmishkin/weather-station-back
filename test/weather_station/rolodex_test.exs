defmodule WeatherStation.RolodexTest do
  use ExUnit.Case

  import Mox

  setup do
    set_mox_global()
    verify_on_exit!()

    on_exit(fn ->
      set_mox_private()
    end)
  end

  test "gathers list of people on startup" do
    External.DockYardApiMock |> expect(:get_employees, fn -> [%{}, %{}, %{}] end)

    {:ok, _pid} = WeatherStation.AgentRolodex.start_link([])

    people = WeatherStation.AgentRolodex.get_people()

    assert length(people) > 1
  end
end
