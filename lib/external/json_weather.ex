defmodule External.JsonWeather do
  def translate(temperature_arr, type_arr) do
    %{"value" => temperature} = Enum.sort_by(temperature_arr, & &1["validTime"]) |> List.first()

    %{
      "value" => [
        %{
          "weather" => type
        }
      ]
    } = Enum.sort_by(type_arr, & &1["validTime"]) |> List.first()

    %{:type => type, :temperature => temperature}
  end
end
