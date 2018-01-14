defmodule IO.ANSI.Table.Server do
  # @moduledoc """
  # Table GenServer...
  # """
  @moduledoc false

  use GenServer

  alias IO.ANSI.Table.{Formatter, Server, Spec}

  require Logger

  @typep from :: GenServer.from

  @spec start_link(term) :: GenServer.on_start
  def start_link(:ok), do: GenServer.start_link(Server, :ok, name: Server)

  ## Callbacks

  @spec init(term) :: {:ok, Spec.t}
  def init(:ok), do: {:ok, Spec.new()}

  @spec handle_cast(term, Spec.t) :: {:noreply, Spec.t}
  def handle_cast({maps, options}, spec) do
    Logger.debug("Handling cast with options #{inspect(options)}")
    Formatter.print_table(spec, maps, options)
    {:noreply, spec}
  end

  @spec handle_call(term, from, Spec.t) :: {:reply, :ok, Spec.t}
  def handle_call({maps, options}, _from, spec) do
    Logger.debug("Handling call with options #{inspect(options)}")
    :ok = Formatter.print_table(spec, maps, options)
    {:reply, :ok, spec}
  end
end
