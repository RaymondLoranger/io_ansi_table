defmodule IO.ANSI.Table.TopSup do
  use Application

  alias __MODULE__
  alias IO.ANSI.Table.Server

  @spec start(Application.start_type(), term) :: {:ok, pid}
  def start(_type, :ok) do
    [
      # Child spec relying on use GenServer...
      {Server, :ok}
    ]
    |> Supervisor.start_link(name: TopSup, strategy: :one_for_one)
  end
end
