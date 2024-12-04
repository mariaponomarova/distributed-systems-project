defmodule Quizzler.Topic do
  use GenServer

  def init(state) do
    {:ok, state}
  end

  #Starts the GenServer and initializes its state
  def start_link(topic_name) do
    GenServer.start_link(__MODULE__, %{name: topic_name, questions: [], score: 0})
  end

  #Adds a question to the topic
  def add_question(topic_name, question) do
    GenServer.call(topic_name, {:add_question, question})
  end

  #Fetches the next question
  def ask_question(topic_name) do
    GenServer.call(topic_name, :ask_question)
  end

end
