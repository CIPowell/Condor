defmodule Condor.BasketTest do
  use ExUnit.Case, async: true
  doctest Condor.BasketAgent

  test "add an item" do
    {:ok, basket} = Condor.BasketAgent.start_link([])

    assert Condor.BasketAgent.add(basket, "TESTSKU") == :ok
  end

  test "get items" do
    {:ok, basket} = Condor.BasketAgent.start_link([])
    :ok = Condor.BasketAgent.add(basket, "TESTSKU")

    ["TESTSKU"] = Condor.BasketAgent.list(basket)
  end

  test "get item count" do
    {:ok, basket} = Condor.BasketAgent.start_link([])
    :ok = Condor.BasketAgent.add(basket, "TESTSKU")
    :ok = Condor.BasketAgent.add(basket, "TESTSKU", 3)

    assert Condor.BasketAgent.get_count(basket) == 4
  end
end
