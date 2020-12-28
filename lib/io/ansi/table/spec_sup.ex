defmodule IO.ANSI.Table.SpecSup do
  use Supervisor

  alias __MODULE__
  alias IO.ANSI.Table.{DynSpecSup, SpecRecovery}

  @spec start_link(term) :: Supervisor.on_start()
  def start_link(:ok), do: Supervisor.start_link(SpecSup, :ok, name: SpecSup)

  ## Callbacks

  @spec init(term) ::
          {:ok, {:supervisor.sup_flags(), [:supervisor.child_spec()]}} | :ignore
  def init(:ok) do
    [
      # Child spec relying on `use DynamicSupervisor`...
      {DynSpecSup, :ok},
      # Child spec relying on `use GenServer`...
      {SpecRecovery, :ok}
    ]
    |> Supervisor.init(strategy: :rest_for_one)
  end
end
