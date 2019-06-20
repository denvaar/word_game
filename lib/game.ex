defmodule Game do
  alias Game.{Server, Logic}

  @doc"""
  Start a new word guessing game

  ## Examples

      iex> Game.start()

  """
  def start() do
    GenServer.start_link(Server, Logic.new_game())
  end


  @doc"""
  Make a guess to see if the secret word contains a letter

  ## Examples

      iex> Game.guess(Game.start(), "z")
  """
  def guess(pid, letter) do
    GenServer.call(pid, {:guess, letter})
    |> List.to_string()
  end

end
