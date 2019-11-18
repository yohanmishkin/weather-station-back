defmodule WeatherStation.People do
  @moduledoc """
  The People context.
  """

  @rolodex Application.get_env(:weather_station, :rolodex)

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
    @rolodex.get_people()
    |> Enum.find(fn person -> person.id == id end)
  end
end
