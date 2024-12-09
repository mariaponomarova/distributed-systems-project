defmodule Quizzler do
  def play do
    IO.puts("Welcome to Quizzler!")
    play_game()
  end

  defp play_game do
    topics = [:music, :science, :math, :sport, :history]
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
      },
      %{
        question: "Which artist released the album Thriller, the best-selling album of all time?",
        options: ["Prince", "Michael Jackson", "Madonna"],
        correct_answer: 2
      },
      %{
        question: "Which female pop star is referred to as the 'Queen of Pop'?",
        options: ["Madonna", "Britney Spears", "Lady Gaga"],
        correct_answer: 1
      },
      %{
        question: "Which legendary British band performed their final live concert on the rooftop of Apple Corps in 1969?",
        options: ["The Rolling Stones", "The Beatles", "Queen"],
        correct_answer: 2
      },
      %{
        question: "What was the name of the iconic 1969 music festival held in New York State?",
        options: ["Woodstock", "Coachella", "Glastonbury"],
        correct_answer: 1
      },
      %{
        question: "Who performed the famous halftime show at the Super Bowl in 2007 featuring the song 'Purple Rain' in the rain?",
        options: ["Beyoncé", "Prince", "Bruno Mars"],
        correct_answer: 2
      },
      %{
        question: "What is the title of Adele's debut album?",
        options: ["19", "21", "25"],
        correct_answer: 1
      },
      %{
        question: "Which artist is known for the album 'Born to Run'?",
        options: ["Bob Dylan", "Bruce Springsteen", "Billy Joel"],
        correct_answer: 2
      },
      %{
        question: "Which band released the album 'The Dark Side of the Moon'?",
        options: ["Pink Floyd", "Led Zeppelin", "The Who"],
        correct_answer: 1
      }
    ]

    ask_questions(questions, score)
  end

  defp play_questions(:science, score) do
    questions = [
      %{
        question: "What is the speed of light in a vacuum?",
        options: ["300,000 km/s", "150,000 km/s", "1,000,000 km/s"],
        correct_answer: 1
      },
      %{
        question: "Who developed the theory of relativity?",
        options: ["Isaac Newton", "Albert Einstein", "Galileo Galilei"],
        correct_answer: 2
      },
      %{
        question: "What is the primary gas found in Earth's atmosphere?",
        options: ["Oxygen", "Nitrogen", "Carbon Dioxide"],
        correct_answer: 2
      },
      %{
        question: "Which planet has the most moons?",
        options: ["Jupiter", "Saturn", "Uranus"],
        correct_answer: 2
      },
      %{
        question: "What is the powerhouse of the cell?",
        options: ["Nucleus", "Mitochondria", "Ribosome"],
        correct_answer: 2
      },
      %{
        question: "What is the chemical formula for table salt?",
        options: ["NaCl", "KCl", "CaCl2"],
        correct_answer: 1
      },
      %{
        question: "What does DNA stand for?",
        options: [
          "Deoxyribonucleic Acid",
          "Deoxyribosome Acid",
          "Deoxyribose Acid"
        ],
        correct_answer: 1
      },
      %{
        question: "What type of galaxy is the Milky Way?",
        options: ["Elliptical", "Spiral", "Irregular"],
        correct_answer: 2
      },
      %{
        question: "Which element has the chemical symbol 'Au'?",
        options: ["Silver", "Gold", "Aluminum"],
        correct_answer: 2
      },
      %{
        question: "What is the smallest unit of life?",
        options: ["Atom", "Molecule", "Cell"],
        correct_answer: 3
      }
    ]
    ask_questions(questions, score)
  end


  defp play_questions(:math, score) do
    questions = [
      %{
        question: "What is the square root of 64?",
        options: ["6", "8", "10"],
        correct_answer: 2
      },
      %{
        question: "What is 15% of 200?",
        options: ["30", "20", "25"],
        correct_answer: 1
      },
      %{
        question: "What is the value of pi (π) rounded to two decimal places?",
        options: ["3.14", "3.15", "3.13"],
        correct_answer: 1
      },
      %{
        question: "What is the result of 7 × 8?",
        options: ["56", "64", "49"],
        correct_answer: 1
      },
      %{
        question: "What is the next prime number after 11?",
        options: ["13", "15", "17"],
        correct_answer: 1
      },
      %{
        question: "What is the formula to calculate the area of a circle?",
        options: ["πr^2", "2πr", "πd"],
        correct_answer: 1
      },
      %{
        question: "If a triangle has sides 3, 4, and 5, what type of triangle is it?",
        options: ["Equilateral", "Right", "Scalene"],
        correct_answer: 2
      },
      %{
        question: "What is the derivative of x^2?",
        options: ["2x", "x^2", "x"],
        correct_answer: 1
      },
      %{
        question: "What is the value of 0 factorial (0!)?",
        options: ["0", "1", "Undefined"],
        correct_answer: 2
      },
      %{
        question: "What is 2 to the power of 5 (2^5)?",
        options: ["32", "25", "64"],
        correct_answer: 1
      }
    ]
    ask_questions(questions, score)
  end

  defp play_questions(:sport, score) do
    questions = [
      %{
        question: "Which country won the FIFA World Cup in 2018?",
        options: ["Germany", "France", "Brazil"],
        correct_answer: 2
      },
      %{
        question: "In basketball, how many points is a free throw worth?",
        options: ["1", "2", "3"],
        correct_answer: 1
      },
      %{
        question: "Which tennis player has won the most Grand Slam titles as of 2024?",
        options: ["Roger Federer", "Rafael Nadal", "Novak Djokovic"],
        correct_answer: 3
      },
      %{
        question: "What is the national sport of Japan?",
        options: ["Sumo Wrestling", "Baseball", "Karate"],
        correct_answer: 1
      },
      %{
        question: "Which NFL team has won the most Super Bowl titles?",
        options: ["Pittsburgh Steelers", "New England Patriots", "Dallas Cowboys"],
        correct_answer: 2
      },
      %{
        question: "Which Olympic Games were postponed for the first time in history?",
        options: ["2020 Tokyo", "2016 Rio", "2008 Beijing"],
        correct_answer: 1
      },
      %{
        question: "In cricket, what is a 'duck'?",
        options: ["A score of zero", "A foul play", "A special type of catch"],
        correct_answer: 1
      },
      %{
        question: "Who holds the record for the fastest 100m sprint?",
        options: ["Usain Bolt", "Carl Lewis", "Tyson Gay"],
        correct_answer: 1
      },
      %{
        question: "How many players are on a standard soccer team on the field?",
        options: ["9", "10", "11"],
        correct_answer: 3
      },
      %{
        question: "Which female gymnast has won the most Olympic gold medals?",
        options: ["Nadia Comaneci", "Simone Biles", "Larisa Latynina"],
        correct_answer: 2
      }
    ]

    ask_questions(questions, score)
  end

  defp play_questions(:history, score) do
    questions = [
      %{
        question: "Who was the first President of the United States?",
        options: ["Thomas Jefferson", "George Washington", "Abraham Lincoln"],
        correct_answer: 2
      },
      %{
        question: "What year did World War II end?",
        options: ["1945", "1939", "1947"],
        correct_answer: 1
      },
      %{
        question: "Who discovered America in 1492?",
        options: ["Christopher Columbus", "Leif Erikson", "Amerigo Vespucci"],
        correct_answer: 1
      },
      %{
        question: "Which ancient civilization built the pyramids?",
        options: ["Romans", "Egyptians", "Mayans"],
        correct_answer: 2
      },
      %{
        question: "Who was the leader of the Soviet Union during World War II?",
        options: ["Vladimir Lenin", "Joseph Stalin", "Nikita Khrushchev"],
        correct_answer: 2
      },
      %{
        question: "What was the name of the ship that carried the Pilgrims to America in 1620?",
        options: ["Mayflower", "Santa Maria", "Endeavour"],
        correct_answer: 1
      },
      %{
        question: "What empire was ruled by Julius Caesar?",
        options: ["Roman Empire", "Byzantine Empire", "Ottoman Empire"],
        correct_answer: 1
      },
      %{
        question: "The fall of the Berlin Wall occurred in which year?",
        options: ["1989", "1991", "1987"],
        correct_answer: 1
      },
      %{
        question: "Who was the first woman to fly solo across the Atlantic Ocean?",
        options: ["Amelia Earhart", "Harriet Quimby", "Bessie Coleman"],
        correct_answer: 1
      },
      %{
        question: "What was the name of the treaty that ended World War I?",
        options: ["Treaty of Versailles", "Treaty of Paris", "Treaty of Tordesillas"],
        correct_answer: 1
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
