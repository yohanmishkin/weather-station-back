defmodule WeatherStation.Weather.CacheAgent do
  use Agent

  alias WeatherStation.Weather.Cache

  @behaviour Cache

  def start_link(initial_value) do
    Agent.start_link(fn -> initial_value end, name: __MODULE__)
  end

  @impl Cache
  def get_forecasts(lat, long) do
    Agent.get(__MODULE__, fn cache ->
      case cache["#{lat}-#{long}-forecasts"] do
        nil ->
          {:not_found, "#{lat}-#{long}-forecasts"}

        hit ->
          case DateTime.compare(hit.expiration, DateTime.utc_now()) do
            :lt -> {:expired, hit.expiration}
            _ -> {:ok, hit.value}
          end
      end
    end)
  end

  @impl Cache
  def put_forecasts(lat, long, forecasts) do
    this_time_tomorrow = DateTime.utc_now() |> DateTime.add(86400, :second)

    Agent.update(__MODULE__, fn cache ->
      Map.put(cache, "#{lat}-#{long}-forecasts", %{
        :value => forecasts,
        :expiration => this_time_tomorrow
      })
    end)
  end

  @impl Cache
  def get_weather(lat, long) do
    Agent.get(__MODULE__, fn cache ->
      case cache["#{lat}-#{long}-weather"] do
        nil ->
          {:not_found, "#{lat}-#{long}-weather"}

        hit ->
          case DateTime.compare(hit.expiration, DateTime.utc_now()) do
            :lt -> {:expired, hit.expiration}
            _ -> {:ok, hit.value}
          end
      end
    end)
  end

  @impl Cache
  def put_weather(lat, long, weather) do
    this_time_tomorrow = DateTime.utc_now() |> DateTime.add(86400, :second)

    Agent.update(__MODULE__, fn cache ->
      Map.put(cache, "#{lat}-#{long}-weather", %{
        :value => weather,
        :expiration => this_time_tomorrow
      })
    end)
  end
end
