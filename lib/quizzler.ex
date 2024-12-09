defmodule Quizzler do
  def play do
    IO.puts("Welcome to Quizzler!")
    play_game()
  end

  defp play_game do
    topics = [:music, :science]
    played_topics = []
    score = 0
    play_game_loop(topics, played_topics, score)
  end

  defp play_game_loop(topics, played_topics, score) do
    topic = choose_topic(topics, played_topics)
    case topic do
      :no_more_topics ->
        IO.puts("All topics have been played.")
        IO.puts("Game over! Your final score is: #{score}")

      topic ->
        played_topics = [topic | played_topics]
        {new_score, questions_left} = play_questions(topic, score)

        if Enum.empty?(questions_left) do
          IO.puts("No more questions left in this topic!")
        end

        IO.puts("Would you like to switch topics? (yes/no)")
        switch_choice = IO.gets("> ") |> String.trim()

        case switch_choice do
          "yes" -> play_game_loop(topics, played_topics, new_score)
          "no" -> IO.puts("Game over! Your final score is: #{new_score}")
          _ -> IO.puts("Invalid choice. Exiting game.")
        end
    end
  end

  defp choose_topic(topics, played_topics) do
    available_topics = Enum.filter(topics, fn topic -> not Enum.member?(played_topics, topic) end)

    if Enum.empty?(available_topics) do
      :no_more_topics
    else
      IO.puts("Choose a topic: ")

      Enum.each(available_topics, fn topic ->
        IO.puts("- #{Atom.to_string(topic) |> String.capitalize()}")
      end)

      topic_choice = IO.gets("Choose a topic: ")
      |> String.trim()
      |> String.downcase()  # Convert input to lowercase

      case Enum.find(available_topics, fn topic -> String.downcase(Atom.to_string(topic)) == topic_choice end) do
        nil ->
          IO.puts("Invalid topic choice. Please select a valid topic.")
          choose_topic(topics, played_topics)

        topic ->
          topic
      end
    end
  end

  defp play_questions(:music, score) do
    questions = [
      %{
        question: "Taylor Swift's song 'Cardigan' was released as part of which album?",
        options: ["Folklore", "Evermore", "Reputation"],
        correct_answer: 1
      },
      %{
        question: "What does the abbreviation of the album 'TTPD' stand for?",
        options: ["Timeless Tragedy Poem Depot", "The Tortured Poets' Department", "The Twilight Poets' Department"],
        correct_answer: 2
      }
    ]

    ask_questions(questions, score)
  end

  defp play_questions(:science, score) do
    questions = [
      %{
        question: "What is the chemical symbol for water?",
        options: ["O", "H2O", "CO2"],
        correct_answer: 2
      },
      %{
        question: "What planet is known as the Red Planet?",
        options: ["Earth", "Mars", "Venus"],
        correct_answer: 2
      }
    ]

    ask_questions(questions, score)
  end

  defp ask_questions([], score), do: {score, []}

  defp ask_questions([question | remaining_questions], score) do
    IO.puts(question.question)

    Enum.with_index(question.options) |> Enum.each(fn {option, index} ->
      IO.puts("#{index + 1}. #{option}")
    end)

    answer = IO.gets("Your answer (enter the number): ") |> String.trim()

    new_score =
      if String.to_integer(answer) == question.correct_answer do
        IO.puts("Correct!")
        score + 1
      else
        IO.puts("Incorrect!")
        score
      end

    ask_questions(remaining_questions, new_score)
  end
end
