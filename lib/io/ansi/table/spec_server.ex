defmodule IO.ANSI.Table.SpecServer do
  @moduledoc """
  A server process that holds a table spec struct as its state.
  """

  use GenServer, restart: :transient
  use PersistConfig

  alias __MODULE__
  alias IO.ANSI.Table.{Log, Spec}

  @ets get_env(:ets_name)
  @reg get_env(:registry)
  # @wait 50

  @doc """
  Spawns a table `spec` server process to be registered via a spec name.
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

  @spec develop_or_lookup(Spec.t()) :: Spec.t()
  defp develop_or_lookup(spec) do
    case :ets.lookup(@ets, key(spec.spec_name)) do
      [] ->
        Log.info(:spawned, {spec, __ENV__})
        Spec.develop(spec) |> save()

      [{_key, spec}] ->
        Log.info(:restarted, {spec, __ENV__})
        spec
    end
  end

  @spec save(Spec.t()) :: Spec.t()
  defp save(spec) do
    Log.info(:save, {spec, __ENV__})
    true = :ets.insert(@ets, {key(spec.spec_name), spec})
    spec
  end

  ## Callbacks

  @spec init(Spec.t()) :: {:ok, Spec.t()}
  def init(spec), do: {:ok, develop_or_lookup(spec)}

  @spec handle_cast(term, Spec.t()) :: {:noreply, Spec.t()}
  def handle_cast({:format, maps, options} = request, spec) do
    Log.info(:handle_cast, {spec, request, __ENV__})
    Spec.write_table(spec, maps, options)
    {:noreply, spec}
  end

  @spec handle_call(term, GenServer.from(), Spec.t()) ::
          {:reply, :ok | Spec.t(), Spec.t()}
  def handle_call({:format, maps, options} = request, {from_pid, _tag}, spec) do
    # Update group leader in case request comes from remote shell...
    group_leader = Process.info(from_pid)[:group_leader]
    if group_leader, do: self() |> Process.group_leader(group_leader)
    Log.info(:handle_call, {spec, request, __ENV__})
    Spec.write_table(spec, maps, options)
    {:reply, :ok, spec}
  end

  def handle_call(request = :get_spec, _from, spec) do
    Log.info(:handle_call, {spec, request, __ENV__})
    {:reply, spec, spec}
  end

  @spec terminate(term, Spec.t()) :: true
  def terminate(reason = :shutdown, spec) do
    Log.info(:terminate, {reason, spec, __ENV__})
    true = :ets.delete(@ets, key(spec.spec_name))
    # Ensure message logged before exiting...
    # Process.sleep(@wait)
  end

  def terminate(reason, spec) do
    Log.error(:terminate, {reason, spec, __ENV__})
    true = :ets.delete(@ets, key(spec.spec_name))
    # Ensure message logged before exiting...
    # Process.sleep(@wait)
  end
end
