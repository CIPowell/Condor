defmodule Condor.BasketAgent do
  @moduledoc """
  The BasketAgent Module that manages user baskets.
  """
  use Agent
  require Logger

  @doc """
  Starts a new basket.
  """
  def start_link(_opts) do
    Agent.start_link(fn -> %Condor.Basket{id: "xxx", products: %{}} end, name: __MODULE__)
  end

  @doc """
  Add an item to the basket.

  ## Examples
      iex> {:ok, basket} = Condor.BasketAgent.start_link([])
      iex> Condor.BasketAgent.add(basket, "SKU")
      :ok

  """
  def add(basket, sku) do
    add(basket, sku, 1)
  end

  @doc """
  Add an item to the basket.

  ## Examples
      iex> {:ok, basket} = Condor.BasketAgent.start_link([])
      iex> Condor.BasketAgent.add(basket, "SKU", 1)
      :ok

  """
  def add(basket, sku, quantity) do
    products = Agent.get(basket, &Map.get(&1, :products))
    new_products = Map.put(products, sku, get_quantity(basket, sku) + quantity)
    Agent.update(basket, &Map.put(&1, :products, new_products))
  end


  @doc """
  Get the Quantity of a specifict Item

  ### Examples
    iex> {:ok, basket} = Condor.BasketAgent.start_link([])
    iex> Condor.BasketAgent.get_quantity(basket, "SKU")
    0

    iex> {:ok, basket} = Condor.BasketAgent.start_link([])
    iex> Condor.BasketAgent.add(basket, "SKU")
    iex> Condor.BasketAgent.get_quantity(basket, "SKU")
    1

    iex> {:ok, basket} = Condor.BasketAgent.start_link([])
    iex> Condor.BasketAgent.add(basket, "SKU")
    iex> Condor.BasketAgent.add(basket, "SKU", 2)
    iex> Condor.BasketAgent.get_quantity(basket, "SKU")
    3
  """
  def get_quantity(basket, sku) do
    products = Agent.get(basket, &Map.get(&1, :products))

    Map.get(products, sku, 0)
  end

  @doc """
  Get a count of items

  ## Examples
      iex> {:ok, basket} = Condor.BasketAgent.start_link([])
      iex> Condor.BasketAgent.add(basket, "SKU")
      iex> Condor.BasketAgent.get_count(basket)
      1
  """
  def get_count(basket) do
    Agent.get(basket, &Map.get(&1, :products)) |>
      Map.values |>
      Enum.sum
  end

  @doc """
  Return the basket
  """
  def list(basket) do
    Agent.get(basket, &Map.get(&1, :products)) |>
      Map.keys
  end
end
