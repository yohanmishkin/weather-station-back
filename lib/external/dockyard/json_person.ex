defmodule External.DockYard.JsonPerson do
  alias WeatherStation.People.Person

  def translate(json) do
    %{
      "id" => id,
      "attributes" => %{
        "avatar-full" => avatar_full,
        "first-name" => first_name,
        "deactivated-at" => deactivated_at,
        "last-name" => last_name,
        "location" => location
      }
    } = json

    %Person{
      :deactivated =>
        if deactivated_at do
          true
        else
          false
        end,
      :id => id || String.upcase(UUID.uuid4(:hex)),
      :image_url => avatar_full,
      :lat => location["lat"],
      :long => location["lng"],
      :name => "#{first_name} #{last_name}"
    }
  end
end
