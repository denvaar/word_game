defmodule Game.Server do
  use GenServer

  @impl true
  def init(initial_state) do
    {:ok, initial_state}
  end

  @impl true
  def handle_call({:guess, letter}, _from, state) do
    updated_clue = Game.Logic.update_clue(state, letter)
    {:reply, updated_clue, %{state | clue: updated_clue}}
  end
end
