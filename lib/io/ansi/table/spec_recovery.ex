defmodule IO.ANSI.Table.SpecRecovery do
  @moduledoc """
  Makes processes under the spec supervisor fault-tolerant. If any crashes (or
  is killed), it is immediately restarted and the system remains undisturbed.
  """

  use GenServer
  use PersistConfig

  alias __MODULE__
  alias IO.ANSI.Table.{DynSpecSup, SpecServer}

  @ets get_env(:ets_name)

  @spec start_link(term) :: GenServer.on_start()
  def start_link(_init_arg = :ok),
    do: GenServer.start_link(SpecRecovery, :ok, name: SpecRecovery)

  ## Private functions

  @spec restart_servers :: :ok
  defp restart_servers do
    @ets
    |> :ets.match_object({{SpecServer, :_}, :_})
    |> Enum.each(fn {{SpecServer, _spec_name}, spec} ->
      # Child may already be started...
      DynamicSupervisor.start_child(DynSpecSup, {SpecServer, spec})
    end)
  end

  ## Callbacks

  @spec init(term) :: {:ok, term}
  def init(_init_arg = :ok), do: {:ok, restart_servers()}
end
