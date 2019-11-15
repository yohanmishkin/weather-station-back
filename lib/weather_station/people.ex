defmodule WeatherStation.People do
  @moduledoc """
  The People context.
  """

  @rolodex Application.get_env(:weather_station, :rolodex)

  @doc """
  Returns the list of people.

  ## Examples

      iex> get_all()
      [%Person{}, ...]

  """
  def get_all() do
    @rolodex.get_people()
  end
end
