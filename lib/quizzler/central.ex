defmodule Quizzler.CentralProcess do
  use GenServer

  # Public API
  def start_link(_) do
    GenServer.start_link(__MODULE__, %{}, name: __MODULE__)
  end

  # Updates the score for a specific topic
  def update_score(topic, points) do
    GenServer.cast(__MODULE__, {:update_score, topic, points})
  end

  # Retrieves the total score from the GenServer
  def get_total_score do
    GenServer.call(__MODULE__, :get_total_score)
  end

  # Callbacks
  # Initializes the GenServer with an empty map as initial state
  def init(_) do
    {:ok, %{}}
  end

  # Handles cast messages (like update_score)
  def handle_cast({:update_score, topic, points}, state) do
    # Updates the score for the given topic in the state
    updated_state = Map.update(state, topic, points, &(&1 + points))
    {:noreply, updated_state}
  end

  # Handles call messages (like get_total_score)
  def handle_call(:get_total_score, _from, state) do
    # Calculates the total score by summing all values in the state
    total_score = Enum.sum(Map.values(state))
    {:reply, total_score, state}
  end
end
