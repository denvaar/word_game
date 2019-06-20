defmodule Game do

  @doc"""
  Start a new word guessing game

  ## Examples

      process_id = Game.start()
  """
  def start() do
    secret_word =
      "Domino's Pizza"
      |> String.graphemes()

    clue =
      secret_word
      |> Enum.map(fn(_letter) -> "_" end)

    # Spawn a new process and run this module's loop
    # function with the initial state
    spawn(__MODULE__, :loop, [%{secret_word: secret_word, clue: clue}])
  end

  @doc"""
  Make a guess to see if the secret word contains a letter

  ## Examples

      iex> process_id = Game.start()
      iex> Game.guess(process_id, "z")
      {:guess, "z"}
  """
  def guess(pid, letter) do
    # send a message to the process identified by pid
    send(pid, {:guess, letter})
  end

  defp update_clue(%{secret_word: secret_word, clue: clue}, letter) do
    secret_word
    |> Enum.zip(clue)
    |> Enum.map(fn({secret_letter, clue_letter}) ->
      reveal_letter(secret_letter, clue_letter, letter)
    end)
  end

  defp reveal_letter(_secret, clue, _guess) when clue !== "_" do
    clue
  end

  defp reveal_letter(secret, _clue, guess) when secret === guess do
    secret
  end

  defp reveal_letter(_secret, _clue, _guess) do
    "_"
  end

  def loop(game_state) do
    # monitor the process mailbox for messages
    receive do
      # when a message that matches this format is received,
      # the code is executed
      {:guess, letter} ->
        new_game_state = %{game_state | clue: update_clue(game_state, letter)}

        new_game_state.clue |> List.to_string() |> IO.puts()

        # continue to wait for more messages, but
        # with the updated game state
        loop(new_game_state)
    end
    loop(game_state)
  end
end
