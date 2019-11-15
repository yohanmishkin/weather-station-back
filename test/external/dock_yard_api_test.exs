defmodule External.DockYardApi.HttpTest do
  use ExUnit.Case, async: true

  @moduletag :external

  describe "dockyard api client" do
    External.DockYardApi.Http.start()

    test "fetches list of employees" do
      employees = External.DockYardApi.Http.get_employees()

      assert employees |> length() > 1

      %{
        "attributes" => %{
          "address" => _,
          "avatar-full" => _,
          "first-name" => _,
          "deactivated-at" => _,
          "last-name" => _,
          "location" => _
        }
      } = employees |> List.first()
    end
  end
end
