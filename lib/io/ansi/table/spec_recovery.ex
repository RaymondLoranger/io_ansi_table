defmodule IO.ANSI.Table.SpecRecovery do
  use GenServer
  use PersistConfig

  alias __MODULE__
  alias IO.ANSI.Table.{DynSpecSup, SpecServer}

  @ets get_env(:ets_name)

  @spec start_link(term) :: GenServer.on_start()
  def start_link(:ok),
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

  @spec init(term) :: {:ok, :ok}
  def init(:ok), do: {:ok, restart_servers()}
end
