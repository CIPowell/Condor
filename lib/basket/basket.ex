defmodule Condor.Basket do
  @enforce_keys [:id, :products]
  defstruct [
    :id,
    :products,
    :promos
  ]
end
