defmodule PhoenixService.Application do
  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the PubSub system
      {Phoenix.PubSub, name: PhoenixService.PubSub},
      # Start the Endpoint (http/https)
      PhoenixServiceWeb.Endpoint,
      # Start Kaffe GroupMemberSupervisor
      %{
        id: Kaffe.GroupMemberSupervisor,
        start: {Kaffe.GroupMemberSupervisor, :start_link, []},
        type: :supervisor
      }
    ]

    opts = [strategy: :one_for_one, name: PhoenixService.Supervisor]
    Supervisor.start_link(children, opts)
  end

  @impl true
  def config_change(changed, _new, removed) do
    PhoenixServiceWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
