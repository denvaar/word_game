defmodule Game do

  @doc"""
  Start a new word guessing game

  ## Examples

      iex> Game.start()
      %{clue: ["_", "_", "_", "_", "_", "_", "_", "_", "_", "_", "_", "_", "_", "_"],
        secret_word: ["D", "o", "m", "i", "n", "o", "'", "s", " ", "P", "i", "z", "z", "a"]}

  """
  def start() do
    # hardcode the word to guess for simplicity
    secret_word =
      "Domino's Pizza"
      |> String.graphemes()

    clue =
      secret_word
      |> Enum.map(fn(_letter) -> "_" end)

    # game's initial state
    %{secret_word: secret_word, clue: clue}
  end

  @doc"""
  Make a guess to see if the secret word contains a letter

  ## Examples

      iex> Game.guess(Game.start(), "z")
      _ = "___________zz_\\n"
      %{clue: ["_", "_", "_", "_", "_", "_", "_", "_", "_", "_", "_", "z", "z", "_"],
        secret_word: ["D", "o", "m", "i", "n", "o", "'", "s", " ", "P", "i", "z", "z", "a"]}
  """
  def guess(state, letter) do
    # figure out a new game state
    new_state = %{state | clue: update_clue(state, letter)}

    # print the clue
    new_state.clue |> List.to_string() |> IO.puts()

    # need to return the updated state
    # so that the client can use it on
    # the next guess.
    new_state
  end

  defp update_clue(%{secret_word: secret_word, clue: clue}, letter) do
    secret_word
    |> Enum.zip(clue) # [{"D", "_"}, {"o", _}, ...]
    |> Enum.map(fn({secret_letter, clue_letter}) ->
      reveal_letter(secret_letter, clue_letter, letter)
    end)
  end

  defp reveal_letter(_secret, clue, _guess) when clue !== "_" do
    # when letter has already been revealed then just return it
    clue
  end

  defp reveal_letter(secret, _clue, guess) when secret === guess do
    # when the guess matches a letter,
    # return the letter to replace "_"
    secret
  end

  defp reveal_letter(_secret, _clue, _guess) do
    # based on the two functions above, the guess did not match
    # so the clue remains unrevealed
    "_"
  end
end
