defmodule WeatherStation.Weather.CacheAgent do
  use Agent

  alias WeatherStation.Weather.Cache

  @behaviour Cache

  # 12 hours worth of seconds
  @default_expiration 43200

  def start_link(initial_value) do
    Agent.start_link(fn -> initial_value end, name: __MODULE__)
  end

  @impl Cache
  def get_forecasts(lat, long) do
    get("#{lat}-#{long}-forecasts")
  end

  @impl Cache
  def get_current_weather(lat, long) do
    get("#{lat}-#{long}-weather")
  end

  @impl Cache
  def put_current_weather(lat, long, weather) do
    put(lat, long, "#{lat}-#{long}-weather", weather)
  end

  @impl Cache
  def put_forecasts(lat, long, forecasts) do
    put(lat, long, "#{lat}-#{long}-forecasts", forecasts)
  end

  defp get(key) do
    Agent.get(__MODULE__, fn cache ->
      case cache[String.to_atom(key)] do
        nil ->
          {:not_found, key}

        hit ->
          case DateTime.compare(hit.expiration, DateTime.utc_now()) do
            :lt -> {:expired, hit.expiration}
            _ -> {:ok, hit.value}
          end
      end
    end)
  end

  defp put(lat, long, key, data) do
    this_time_tomorrow = DateTime.utc_now() |> DateTime.add(@default_expiration, :second)

    Agent.update(__MODULE__, fn cache ->
      Map.put(cache, String.to_atom(key), %{
        :value => data,
        :expiration => this_time_tomorrow
      })
    end)
  end
end
