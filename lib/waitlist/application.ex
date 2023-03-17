defmodule Waitlist.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Waitlist.Repo,
      # Start the Telemetry supervisor
      WaitlistWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Waitlist.PubSub},
      # Start the Endpoint (http/https)
      WaitlistWeb.Endpoint
      # Start a worker by calling: Waitlist.Worker.start_link(arg)
      # {Waitlist.Worker, arg}
    ]

    {:ok, config} = SecretVault.Config.fetch_from_current_env(:waitlist)
    SecretVault.Storage.to_persistent_term(config)

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Waitlist.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    WaitlistWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
