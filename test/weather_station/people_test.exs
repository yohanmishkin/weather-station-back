defmodule WeatherStation.PeopleTest do
  use ExUnit.Case, async: true

  import Mox

  setup :verify_on_exit!

  describe "people" do
    # alias WeatherStation.People.Chip

    @valid_attrs %{name: "some name", temperature: 42}

    # def person_fixture(attrs \\ %{}) do
    #   {:ok, person} =
    #     attrs
    #     |> Enum.into(@valid_attrs)
    #     |> People.create_person()

    #   person
    # end

    test "get_all/0 returns all people" do
      WeatherStation.RolodexMock
      |> expect(:get_people, fn -> [@valid_attrs, @valid_attrs, @valid_attrs] end)

      assert WeatherStation.People.get_all() |> length() == 3
    end

    # test "get_chip!/1 returns the chip with given id" do
    #   chip = chip_fixture()
    #   assert People.get_chip!(chip.id) == chip
    # end
  end
end
