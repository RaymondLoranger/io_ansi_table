defmodule IO.ANSI.Table.App do
  @moduledoc false

  use Application

  @me __MODULE__

  @spec start(Application.start_type, term) :: {:ok, pid}
  def start(_type, :ok) do
    [
      {IO.ANSI.Table.Server, :ok} # child spec relying on use GenServer...
    ]
    |> Supervisor.start_link(name: @me, strategy: :one_for_one)
  end
end
