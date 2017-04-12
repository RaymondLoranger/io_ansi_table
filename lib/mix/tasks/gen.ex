defmodule Mix.Tasks.Gen do
  # use Mix.Task # otherwise dialyzer complains

  def run(_args) do
    Mix.Tasks.Compile.run []
    # Mix.Tasks.Escript.Build.run []
    Mix.Tasks.Cmd.run ~w/mix test/
    Mix.Tasks.Cmd.run ~w/mix dialyzer --no-check/
    Mix.Tasks.Cmd.run ~w/mix docs/
  end
end