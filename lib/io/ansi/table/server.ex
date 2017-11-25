defmodule IO.ANSI.Table.Server do
  # @moduledoc """
  # Table GenServer...
  # """
  @moduledoc false

  use GenServer

  alias IO.ANSI.Table.{Formatter, Spec}

  @typep from :: GenServer.from

  @me __MODULE__

  @spec start_link(term) :: GenServer.on_start
  def start_link(:ok), do: GenServer.start_link(@me, :ok, name: @me)

  ## Callbacks

  @spec init(term) :: {:ok, Spec.t}
  def init(:ok), do: {:ok, Spec.new()}

  @spec handle_cast(term, Spec.t) :: {:noreply, Spec.t}
  def handle_cast({maps, options}, spec) do
    Formatter.print_table(spec, maps, options)
    {:noreply, spec}
  end
  def handle_cast({maps}, spec) do
    Formatter.print_table(spec, maps)
    {:noreply, spec}
  end

  @spec handle_call(term, from, Spec.t) :: {:reply, :ok, Spec.t}
  def handle_call({maps, options}, _from, spec) do
    :ok = Formatter.print_table(spec, maps, options)
    {:reply, :ok, spec}
  end
  def handle_call({maps}, _from, spec) do
    :ok = Formatter.print_table(spec, maps)
    {:reply, :ok, spec}
  end
end
