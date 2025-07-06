defmodule IO.ANSI.Table.TopSup do
  use Application
  use PersistConfig

  alias __MODULE__
  alias IO.ANSI.Table.SpecSup

  @ets get_env(:ets_name)
  @reg get_env(:registry)

  @spec start(Application.start_type(), term) :: {:ok, pid}
  def start(_start_type, _start_args = :ok) do
    :ets.new(@ets, [:public, :named_table])

    [
      {Registry, keys: :unique, name: @reg},

      # Child spec relying on `use Supervisor`...
      {SpecSup, :ok}
    ]
    |> Supervisor.start_link(name: TopSup, strategy: :one_for_one)
  end
end
