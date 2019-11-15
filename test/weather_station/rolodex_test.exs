defmodule WeatherStation.RolodexTest do
  use ExUnit.Case, async: true

  test "gathers list of people on startup" do
    {:ok, pid } = WeatherStation.AgentRolodex.start_link([])

    people = WeatherStation.AgentRolodex.get_people()
    
    assert people |> length() > 1

    # assert WeatherStation.Rolodex.Gen.lookup(registry, "rolodex") == :error

    # WeatherStation.Rolodex.Gen.start(registry, "rolodex")

    # DockYardApiClient.get_employees [{}, {}, {}]
    # assert response = []
  end

  test "keeps list of people in memory after initial fetch" do
  end

  test "responds as not ready before fetching people" do
  end
end
