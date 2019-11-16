defmodule External.JsonPerson do
  alias WeatherStation.Person

  def translate(json) do
    %{
      "attributes" => %{
        "address" => address,
        "avatar-full" => avatar_full,
        "first-name" => first_name,
        "deactivated-at" => deactivated_at,
        "last-name" => last_name,
        "location" => location
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
      :image_url => avatar_full,
      :name => "#{first_name} #{last_name}",
      :location => location
    }
  end
end
