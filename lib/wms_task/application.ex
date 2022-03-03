defmodule WmsTask.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      WmsTask.Repo,
      # Start the Telemetry supervisor
      WmsTaskWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: WmsTask.PubSub},
      # Start the Endpoint (http/https)
      WmsTaskWeb.Endpoint,
      WmsTaskWeb.Scheduler
      # Start a worker by calling: WmsTask.Worker.start_link(arg)
      # {WmsTask.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: WmsTask.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    WmsTaskWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
