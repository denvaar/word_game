# Word Game

It's a simplified version of hangman. A player starts (`Game.start()`) a game, then guesses letters one at a time (`Game.guess(state, "D")`,) until the secret word is revealed.

The goals here are:

  1. See what a simple Elixir project looks like in general
  2. Learn how we can manage state
  3. Do a little code refactoring, so that it's a more modular system

There's three versions of this app, each on it's own branch.

### Basic Version

The [first version](https://github.com/denvaar/word_game/tree/master/lib) is a simple approach. All code is just placed into a single module. State is maintained by passing it to and fro. Sometimes this is fine, but in this application, it doesn't make sense. That's because some of the state should be considered private -- the secret word!

### "Lil bit better" Version

The [second version](https://github.com/denvaar/word_game/tree/version-two/lib) solves the problem of revealing data that should be considered private. The game state no longer needs to be passed around like in the first version. This is made possible by Elixir processes. State is maintained internally by utilizing a process mailbox and tail recursion. Now the player does not have to see the entire game state, but just the "clue" instead.

### "Now We're Getting Somewhere" Version

The [third version](https://github.com/denvaar/word_game/tree/version-three/lib) illustrates how the game can utilize functions from a standardized, battle-tested module, called `GenServer`. Using a `GenServer` for this game replaces the need to write our own recursive function to watch for messages. As a result, the code will be less error prone, and adhear to a standardized specification. The code is also refactored into separate modules, so that it's a bit more maintainable and clear.

Want to make the game even better? I recommend Dave Thomas's course: https://codestool.coding-gnome.com/courses/elixir-for-programmers in which you will build an even better hangman-style game.

## Installation

1. Pick a version you want to explore and download the code for that branch.
2. From within the project, run `iex -S mix` to get an interactive Elixir console.
3. `Game.<TAB>` to see what functions you have at your disposal.
4. You can view documentation/examples for functions by prefixing the function name with `h `.

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/game](https://hexdocs.pm/game).

