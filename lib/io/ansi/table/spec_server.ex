defmodule IO.ANSI.Table.SpecServer do
  @moduledoc """
  A server process that holds a table `spec` struct as its state.
  """

  use GenServer, restart: :transient
  use PersistConfig

  alias __MODULE__
  alias IO.ANSI.Table.{Log, Spec}

  @ets get_env(:ets_name)
  @reg get_env(:registry)
  @wait 50

  @doc """
  Spawns a new table spec server process to be registered via a `spec name`.
  """
  @spec start_link(Spec.t()) :: GenServer.on_start()
  def start_link(spec) do
    GenServer.start_link(SpecServer, spec, name: via(spec.spec_name))
  end

  @doc """
  Allows to register or look up a table spec server process via a `spec name`.
  """
  @spec via(String.t()) :: {:via, Registry, tuple}
  def via(spec_name), do: {:via, Registry, {@reg, key(spec_name)}}

  ## Private functions

  @spec key(String.t()) :: tuple
  defp key(spec_name), do: {SpecServer, spec_name}

  @spec extend(Spec.t()) :: Spec.t()
  defp extend(spec) do
    case :ets.lookup(@ets, key(spec.spec_name)) do
      [] ->
        :ok = Log.info(:spawned, {spec})
        Spec.extend(spec) |> save()

      [{_key, spec}] ->
        :ok = Log.info(:restarted, {spec})
        spec
    end
  end

  @spec save(Spec.t()) :: Spec.t()
  defp save(spec) do
    :ok = Log.info(:save, {spec, __ENV__})
    true = :ets.insert(@ets, {key(spec.spec_name), spec})
    spec
  end

  ## Callbacks

  @spec init(Spec.t()) :: {:ok, Spec.t()}
  def init(spec), do: {:ok, extend(spec)}

  @spec handle_cast(term, Spec.t()) :: {:noreply, Spec.t()}
  def handle_cast({:write, maps, options} = request, spec) do
    :ok = Log.info(:handle_cast, {spec, request, __ENV__})
    :ok = Spec.write_table(maps, spec, options)
    {:noreply, spec}
  end

  @spec handle_call(term, GenServer.from(), Spec.t()) ::
          {:reply, :ok | Spec.t(), Spec.t()}
  def handle_call({:format, maps, options} = request, {from_pid, _tag}, spec) do
    group_leader = Process.info(from_pid)[:group_leader]
    if group_leader, do: self() |> Process.group_leader(group_leader)
    :ok = Log.info(:handle_call, {spec, request, __ENV__})
    :ok = Spec.write_table(maps, spec, options)
    {:reply, :ok, spec}
  end

  def handle_call(:get = request, _from, spec) do
    :ok = Log.info(:handle_call, {spec, request, __ENV__})
    {:reply, spec, spec}
  end

  @spec terminate(term, Spec.t()) :: :ok
  def terminate(:shutdown = reason, spec) do
    :ok = Log.info(:terminate, {reason, spec, __ENV__})
    true = :ets.delete(@ets, key(spec.spec_name))
    # Ensure message logged before exiting...
    Process.sleep(@wait)
  end

  def terminate(reason, spec) do
    :ok = Log.error(:terminate, {reason, spec, __ENV__})
    true = :ets.delete(@ets, key(spec.spec_name))
    # Ensure message logged before exiting...
    Process.sleep(@wait)
  end
end
