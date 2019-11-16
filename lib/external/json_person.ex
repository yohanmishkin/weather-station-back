defmodule External.JsonPerson do
  alias WeatherStation.Person

  def translate(json) do
    %{
      "id" => id,
      "attributes" => %{
        "address" => address,
        "avatar-full" => avatar_full,
        "first-name" => first_name,
        "deactivated-at" => deactivated_at,
        "last-name" => last_name
      }
    } = json

    %Person{
      :address => address,
      :deactivated =>
        if deactivated_at do
          true
        else
          false
        end,
      :id => id || UUID.uuid4(:hex) |> String.upcase,
      :image_url => avatar_full,
      :name => "#{first_name} #{last_name}",
    }
  end
end