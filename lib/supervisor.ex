defmodule Condor.Supervisor do
  use Supervisor

  def start_link(opts) do
    Supervisor.start_link(__MODULE__, :ok, opts)
  end

  @impl true
  def init(:ok) do
    Supervisor.init([
      {DynamicSupervisor, name: Condor.BasketSupervisor, strategy: :one_for_one}
    ], strategy: :one_for_one)
  end
end
