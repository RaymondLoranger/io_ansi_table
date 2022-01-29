defmodule IO.ANSI.Table.DynSpecSup do
  @moduledoc """
  A supervisor that starts table spec server processes dynamically.
  """

  use DynamicSupervisor

  alias __MODULE__

  @spec start_link(term) :: Supervisor.on_start()
  def start_link(:ok = _arg),
    do: DynamicSupervisor.start_link(DynSpecSup, :ok, name: DynSpecSup)

  ## Callbacks

  @spec init(term) :: {:ok, DynamicSupervisor.sup_flags()} | :ignore
  def init(:ok = _arg), do: DynamicSupervisor.init(strategy: :one_for_one)
end
