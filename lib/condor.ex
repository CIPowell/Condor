defmodule Condor do
  use Application

  @impl true
  def start(__type, __args) do
    Condor.Supervisor.start_link(name: Condor.Supervisor)
  end
end
