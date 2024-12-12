defmodule Quizzler.TriviaTopic do
  use GenServer

  # Public API
  # Starts a new GenServer process for a trivia topic
  def start_link({topic, questions}) do
    GenServer.start_link(__MODULE__, %{topic: topic, questions: questions, current_question: nil}, name: via_tuple(topic))
  end

  # Asks the next question in the topic
  def ask_question(topic) do
    GenServer.call(via_tuple(topic), :ask_question)
  end

  # Checks the player's answer against the current question
  def check_answer(topic, user_answer) do
    GenServer.call(via_tuple(topic), {:check_answer, user_answer})
  end

  # Private Helpers
  # Generates a via tuple for the GenServer, using Quizzler.Registry
  defp via_tuple(topic), do: {:via, Registry, {Quizzler.Registry, topic}}

  # Callbacks
  # Initializes the GenServer with the given state
  def init(state) do
    {:ok, state}
  end

  # Handles asking for the next question
  def handle_call(:ask_question, _from, %{questions: []} = state) do
    # Returns a message when there are no more questions
    {:reply, "No more questions!", state}  # No more questions
  end

  def handle_call(:ask_question, _from, %{questions: [current_question | remaining_questions]} = state) do
    # Moves to the next question and updates the current question
    new_state = %{state | questions: remaining_questions, current_question: current_question}
    question_text = current_question.question
    {:reply, question_text, new_state}
  end

  def handle_call({:check_answer, user_answer}, _from, %{current_question: %{answer: correct_answer}} = state) do
    # Compares the players's answer with the correct answer (case-insensitive)
    if String.downcase(user_answer) == String.downcase(correct_answer) do
      Quizzler.CentralProcess.update_score(state.topic, 1)
      {:reply, :correct, state}
    else
      {:reply, :incorrect, state}
    end
  end
end
