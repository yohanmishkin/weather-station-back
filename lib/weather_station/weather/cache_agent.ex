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
        nil -> {:not_found, "#{lat}-#{long}-forecasts"}
        forecasts -> {:ok, forecasts}
      end
    end)
  end

  @impl Cache
  def put_forecasts(lat, long, forecasts) do
    Agent.update(__MODULE__, fn cache ->
      Map.put(cache, "#{lat}-#{long}-forecasts", forecasts)
    end)
  end

  @impl Cache
  def get_weather(lat, long) do
    Agent.get(__MODULE__, fn cache ->
      case cache["#{lat}-#{long}-weather"] do
        nil -> {:not_found, "#{lat}-#{long}-weather"}
        weather -> {:ok, weather}
      end
    end)
  end

  @impl Cache
  def put_weather(lat, long, weather) do
    Agent.update(__MODULE__, fn cache ->
      Map.put(cache, "#{lat}-#{long}-weather", weather)
    end)
  end
end
