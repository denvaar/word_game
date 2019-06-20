defmodule Game.Logic do
  def new_game() do
    secret_word =
      "Domino's Pizza"
      |> String.graphemes()

    clue =
      secret_word
      |> Enum.map(fn(_letter) -> "_" end)

    %{secret_word: secret_word, clue: clue}
  end

  def update_clue(%{secret_word: secret_word, clue: clue}, letter) do
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
end
