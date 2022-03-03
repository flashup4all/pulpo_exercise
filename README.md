# WmsTask

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create a .env file on the root directory and update the following config
  ```
  export PGDATABASE=""
  export PGUSER=""
  export PGPASSWORD=""
  export PGHOST=""

  export PULPO_BASE_URL="https://show.pulpo.co"

  export SECRET_KEY_BASE=""
  ```
  * Run `mix phx.gen.sercret` to generate a secret key for the above config
  * Create and migrate your database with `mix ecto.setup`
  * Install Node.js dependencies with `npm install` inside the `assets` directory
  * Start Phoenix endpoint with `mix phx.server`
  * Use Postman or any API utility tool to access the following API's `
  * Login using 
  ```
    {
      "username": "felipe_user1",
      "password": "felipe_user1"
    }
  ```
  * Once you are able to login add `Authorization: Bearer <access_token>` to your connection headers. Note that the access token is gotten after a successful login
  * Call the following API's below to see result
  localhost:4000/api/orders/live
  localhost:4000/api/orders
  

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix
