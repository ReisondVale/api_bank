defmodule ApiBank.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      ApiBank.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: ApiBank.PubSub}
      # Start a worker by calling: ApiBank.Worker.start_link(arg)
      # {ApiBank.Worker, arg}
    ]

    Supervisor.start_link(children, strategy: :one_for_one, name: ApiBank.Supervisor)
  end
end
