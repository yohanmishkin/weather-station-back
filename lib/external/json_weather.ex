defmodule External.JsonWeather do
  def translate(temperature_arr, type_arr) do
    %{"value" => temperature} =
      Enum.filter(Enum.sort_by(temperature_arr, & &1["validTime"]), &(!is_nil(&1["value"])))
      |> List.first()

    %{:weather => type} =
      Enum.sort_by(
        Enum.filter(
          Enum.map(type_arr, fn x ->
            %{:valid_time => x["validTime"], :weather => List.first(x["value"])["weather"]}
          end),
          fn x -> !is_nil(x.weather) end
        ),
        & &1.valid_time
      )
      |> List.first()

    %{:type => type, :temperature => temperature}
  end
end
