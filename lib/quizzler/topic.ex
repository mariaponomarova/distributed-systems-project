defmodule Quizzler.TriviaTopic do
  use GenServer

  # Public API
  def start_link({topic, questions}) do
    GenServer.start_link(__MODULE__, %{topic: topic, questions: questions, current_question: nil}, name: via_tuple(topic))
  end

  def ask_question(topic) do
    GenServer.call(via_tuple(topic), :ask_question)
  end

  def check_answer(topic, user_answer) do
    GenServer.call(via_tuple(topic), {:check_answer, user_answer})
  end

  # Private Helpers
  defp via_tuple(topic), do: {:via, Registry, {Quizzler.Registry, topic}}

  # Callbacks
  def init(state) do
    {:ok, state}
  end

  def handle_call(:ask_question, _from, %{questions: []} = state) do
    {:reply, "No more questions!", state}  # No more questions
  end
  def handle_call(:ask_question, _from, %{questions: [current_question | remaining_questions]} = state) do
    new_state = %{state | questions: remaining_questions, current_question: current_question}
    question_text = current_question.question
    {:reply, question_text, new_state}
  end

  def handle_call({:check_answer, user_answer}, _from, %{current_question: %{answer: correct_answer}} = state) do
    if String.downcase(user_answer) == String.downcase(correct_answer) do
      Quizzler.CentralProcess.update_score(state.topic, 1)
      {:reply, :correct, state}
    else
      {:reply, :incorrect, state}
    end
  end
end
