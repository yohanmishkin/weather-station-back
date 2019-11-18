defmodule WeatherStation.People do
  @moduledoc """
  The People context.
  """

  @rolodex Application.get_env(:weather_station, :rolodex)
  @weather_api Application.get_env(:weather_station, :weather_api)

  alias WeatherStation.Person

  @doc """
  Returns the list of people.

  ## Examples

      iex> get_all()
      [%Person{}, ...]

  """
  @spec get_all :: [%Person{}]
  def get_all do
    @rolodex.get_people()
  end

  @doc """
  Gets a single person.

  Raises `Ecto.NoResultsError` if the Person does not exist.

  ## Examples

      iex> get!(123)
      %Person{}

      iex> get!(456)
      ** (Ecto.NoResultsError)

  """
  def get!(id) do
    person =
      @rolodex.get_people()
      |> Enum.find(fn person -> person.id == id end)

    Map.put(
      person,
      :forecasts,
      @weather_api.get_forecasts(person.location.lat, person.location.long)
    )
  end
end
