defmodule IO.ANSI.Table.SpecServer do
  @moduledoc """
  A server process that holds a table spec struct as its state.
  Times out after 60 minutes of inactivity.
  """

  use GenServer, restart: :transient
  use PersistConfig

  alias __MODULE__
  alias IO.ANSI.Table.{Log, Spec}

  @ets get_env(:ets_name)
  @reg get_env(:registry)
  @timeout :timer.minutes(60)
  # @timeout :timer.seconds(60)
  # @wait 50

  @doc """
  Spawns a table `spec` server process to be registered via a spec name.
  """
  @spec start_link(Spec.t()) :: GenServer.on_start()
  def start_link(spec) do
    GenServer.start_link(SpecServer, spec, name: via(spec.spec_name))
  end

  @doc """
  Allows to register or look up a table spec server process via `spec_name`.
  """
  @spec via(String.t()) :: {:via, Registry, tuple}
  def via(spec_name), do: {:via, Registry, {@reg, key(spec_name)}}

  ## Callbacks

  @spec init(Spec.t()) :: {:ok, Spec.t(), timeout}
  def init(spec), do: {:ok, expand_or_lookup(spec), @timeout}

  @spec handle_cast(term, Spec.t()) :: {:noreply, Spec.t(), timeout}
  def handle_cast({:format, maps, options} = request, spec) do
    Log.info(:handle_cast, {spec, request, __ENV__})
    Spec.write_table(spec, maps, options)
    {:noreply, spec, @timeout}
  end

  @spec handle_call(term, GenServer.from(), Spec.t()) ::
          {:reply, :ok | Spec.t(), Spec.t(), timeout}
  def handle_call({:format, maps, options} = request, {from_pid, _tag}, spec) do
    Log.info(:handle_call, {spec, request, __ENV__})
    server_leader = Process.group_leader()
    {:group_leader, caller_leader} = Process.info(from_pid, :group_leader)
    changing_group_leader = {spec, from_pid, caller_leader, server_leader}
    Log.info(:changing_group_leader, {changing_group_leader, __ENV__})
    # Change group leader in case request comes from remote shell...
    Process.group_leader(self(), caller_leader)
    Spec.write_table(spec, maps, options)
    # Restore group leader...
    Process.group_leader(self(), server_leader)
    {:reply, :ok, spec, @timeout}
  end

  def handle_call(request = :get_spec, _from, spec) do
    Log.info(:handle_call, {spec, request, __ENV__})
    {:reply, spec, spec, @timeout}
  end

  def handle_call({:update_spec, options} = request, _from, spec) do
    spec = Spec.update_spec(spec, options) |> Spec.expand() |> save()
    Log.info(:handle_call, {spec, request, __ENV__})
    {:reply, :ok, spec, @timeout}
  end

  @spec handle_info(term, Spec.t()) ::
          {:stop, reason :: tuple, Spec.t()} | {:noreply, Spec.t()}
  def handle_info(:timeout, spec), do: {:stop, {:shutdown, :timeout}, spec}
  def handle_info(_message, spec), do: {:noreply, spec}

  @spec terminate(term, Spec.t()) :: true
  def terminate(reason, spec)
      when reason in [:shutdown, {:shutdown, :timeout}] do
    Log.info(:terminating, {reason, spec, __ENV__})
    true = :ets.delete(@ets, key(spec.spec_name))
    # Ensure message logged before exiting...
    # Process.sleep(@wait)
  end

  def terminate(reason, spec) do
    Log.error(:terminating, {reason, spec, __ENV__})
    true = :ets.delete(@ets, key(spec.spec_name))
    # Ensure message logged before exiting...
    # Process.sleep(@wait)
  end

  ## Private functions

  @spec key(String.t()) :: tuple
  defp key(spec_name), do: {SpecServer, spec_name}

  @spec expand_or_lookup(Spec.t()) :: Spec.t()
  defp expand_or_lookup(spec) do
    case :ets.lookup(@ets, key(spec.spec_name)) do
      [] ->
        Log.info(:spawning, {spec, __ENV__})
        Spec.expand(spec) |> save()

      [{_key, spec}] ->
        Log.info(:restarted, {spec, __ENV__})
        spec
    end
  end

  @spec save(Spec.t()) :: Spec.t()
  defp save(spec) do
    Log.info(:saving, {spec, __ENV__})
    true = :ets.insert(@ets, {key(spec.spec_name), spec})
    spec
  end

  # E.g. #PID<0.104.0> => %{"node" => "0", "process" => "104", "serial" => "0"}
  # @spec pid_to_map(pid) :: map
  # defp pid_to_map(pid) when is_pid(pid) do
  #   ~r/<(?<node>\d+)\.(?<process>\d+)\.(?<serial>\d+)>/
  #   |> Regex.named_captures(inspect(pid))
  #   |> Map.new(fn {k, v} -> {String.to_atom(k), String.to_integer(v)} end)
  # end
end
