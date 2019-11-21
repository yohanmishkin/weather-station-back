# WeatherStation

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Install Node.js dependencies with `cd assets && npm install`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix

AGENT TEST DEBUGGING
https://elixir-lang.org/getting-started/mix-otp/agent.html
https://hexdocs.pm/elixir/Agent.html#stop/3
https://elixirforum.com/t/designing-an-agent-with-side-effects-on-start-link/25576/12

Web
  PeopleController
    Get(id)
      People.get(id)
      |> json()

    GetAll()
      People.get_all()    
      |> json()

Application
  People.get_all()
    RolodexGetServer.get('people')

  Person.get(id)
    RolodexGetServer.get('people')
    |> find(id)
    |> Forecast.get(person.address)


  Person
    forecasts: []
    address
    id
    name 
    temperature

  Forecast
    shortDescription
    temperature


RolodexGenServer
  start_link()
    fetch_people


