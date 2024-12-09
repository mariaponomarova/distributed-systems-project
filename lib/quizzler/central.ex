defmodule Quizzler.CentralProcess do
  use GenServer

  # Public API
  def start_link(_) do
    GenServer.start_link(__MODULE__, %{}, name: __MODULE__)
  end

  def update_score(topic, points) do
    GenServer.cast(__MODULE__, {:update_score, topic, points})
  end

  def get_total_score do
    GenServer.call(__MODULE__, :get_total_score)
  end

  # Callbacks
  def init(_) do
    {:ok, %{}}
  end

  def handle_cast({:update_score, topic, points}, state) do
    updated_state = Map.update(state, topic, points, &(&1 + points))
    {:noreply, updated_state}
  end

  def handle_call(:get_total_score, _from, state) do
    total_score = Enum.sum(Map.values(state))
    {:reply, total_score, state}
  end
end
