defmodule Quizzler.Application do
  use Application

  def start(_type, _args) do
    children = [
      {Registry, keys: :unique, name: Quizzler.Registry},
      Quizzler.CentralProcess
    ]

    opts = [strategy: :one_for_one, name: Quizzler.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
