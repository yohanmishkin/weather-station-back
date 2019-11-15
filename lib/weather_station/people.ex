defmodule WeatherStation.People do
  @moduledoc """
  The People context.
  """

  # alias WeatherStation.People.Chip

  @doc """
  Returns the list of people.

  ## Examples

      iex> get_all()
      [%Person{}, ...]

  """
  def get_all do
    []
  end

  # @doc """
  # Gets a single chip.

  # Raises `Ecto.NoResultsError` if the Chip does not exist.

  # ## Examples

  #     iex> get_chip!(123)
  #     %Chip{}

  #     iex> get_chip!(456)
  #     ** (Ecto.NoResultsError)

  # """
  # def get_chip!(id), do: Repo.get!(Chip, id)
end
