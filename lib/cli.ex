defmodule Quizzler.CLI do
  def run do
    IO.puts("Welcome to Trivia Game!")
    show_menu()

    input = IO.gets("Choose an option: ") |> String.trim()

    case input do
      "1" -> start_game()
      "2" -> IO.puts("Goodbye!") && exit(:normal)
      _ -> IO.puts("Invalid option! Type 1 or 2. ") && run()
    end
  end

  defp show_menu do
    IO.puts("Menu:")
    IO.puts("1. Start Game")
    IO.puts("2. Exit")
  end

  defp start_game do
    IO.puts("Starting game...")
    Quizzler.Topic.start_link("Music")
    IO.puts("Trivia topic 'Music' initialized!")
  end
end
