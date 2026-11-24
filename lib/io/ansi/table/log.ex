defmodule IO.ANSI.Table.Log do
  use File.Only.Logger

  import IO.ANSI.Table.SpecServer, only: [via: 1]

  info :apps_started, {apps, args, env} do
    """
    \nApplications started at 'compile time'...
    • Call: 'Application.ensure_all_started/1'
    • Arguments: #{inspect(args)}
    • Apps started: #{inspect(apps) |> maybe_break(16)}
    #{from(env, __MODULE__)}\
    """
  end

  error :error_starting_app, {reason, apps, env} do
    """
    \nError starting application at 'compile time'...
    • Call: 'Application.ensure_all_started/1'
    • Arguments: #{inspect(apps)}
    • Reason: #{inspect(reason) |> maybe_break(10)}
    #{from(env, __MODULE__)}\
    """
  end

  error :terminating, {reason, spec, env} do
    """
    \nTerminating table spec server...
    • Server: #{via(spec.spec_name) |> inspect() |> maybe_break(10)}
    • Server PID: #{self() |> inspect() |> maybe_break(14)}
    • 'terminate' reason: #{inspect(reason) |> maybe_break(22)}
    • Spec: #{inspect(spec) |> maybe_break(8)}
    #{from(env, __MODULE__)}\
    """
  end

  info :terminating, {reason, spec, env} do
    """
    \nTerminating table spec server...
    • Server: #{via(spec.spec_name) |> inspect() |> maybe_break(10)}
    • Server PID: #{self() |> inspect() |> maybe_break(14)}
    • 'terminate' reason: #{inspect(reason) |> maybe_break(22)}
    • Spec: #{inspect(spec) |> maybe_break(8)}
    #{from(env, __MODULE__)}\
    """
  end

  info :handle_cast, {spec, {:format, maps, options}, env} do
    """
    \nHandling cast...
    • Server: #{via(spec.spec_name) |> inspect() |> maybe_break(10)}
    • Server PID: #{self() |> inspect() |> maybe_break(14)}
    • Request: {:format, <maps>, <options>}
    • Number of maps: #{length(maps)}
    • Options: #{inspect(options) |> maybe_break(11)}
    • Spec: #{inspect(spec) |> maybe_break(8)}
    #{from(env, __MODULE__)}\
    """
  end

  info :changing_group_leader, {spec, caller_pid, caller_leader, env} do
    server_pid = self()
    {:group_leader, server_leader} = Process.info(self(), :group_leader)

    """
    \nBriefly changing server group leader to caller's...
    • Server: #{via(spec.spec_name) |> inspect() |> maybe_break(10)}
    • Server PID: #{inspect(server_pid) |> maybe_break(14)}
    • Server group leader: #{inspect(server_leader) |> maybe_break(23)}
    • Caller PID: #{inspect(caller_pid) |> maybe_break(14)}
    • Caller group leader: #{inspect(caller_leader) |> maybe_break(23)}
    • Request: {:format, <maps>, <options>}
    #{from(env, __MODULE__)}\
    """
  end

  info :handle_call, {spec, {:format, maps, options}, env} do
    """
    \nHandling call...
    • Server: #{via(spec.spec_name) |> inspect() |> maybe_break(10)}
    • Server PID: #{self() |> inspect() |> maybe_break(14)}
    • Request: {:format, <maps>, <options>}
    • Number of maps: #{length(maps)}
    • Options: #{inspect(options) |> maybe_break(11)}
    • Spec: #{inspect(spec) |> maybe_break(8)}
    #{from(env, __MODULE__)}\
    """
  end

  info :handle_call, {spec, :get_spec, env} do
    """
    \nHandling call...
    • Server: #{via(spec.spec_name) |> inspect() |> maybe_break(10)}
    • Server PID: #{self() |> inspect() |> maybe_break(14)}
    • Request: :get_spec
    • Spec: #{inspect(spec) |> maybe_break(8)}
    #{from(env, __MODULE__)}\
    """
  end

  info :handle_call, {spec, {:update_spec, options}, env} do
    """
    \nHandling call...
    • Server: #{via(spec.spec_name) |> inspect() |> maybe_break(10)}
    • Server PID: #{self() |> inspect() |> maybe_break(14)}
    • Request: {:update_spec, <options>}
    • Options: #{inspect(options) |> maybe_break(11)}
    • Updated spec: #{inspect(spec) |> maybe_break(14)}
    #{from(env, __MODULE__)}\
    """
  end

  info :spawning, {spec, env} do
    """
    \nSpawning table spec server...
    • Spec name: #{inspect(spec.spec_name)}
    • Server PID: #{self() |> inspect() |> maybe_break(14)}
    • Spec: #{inspect(spec) |> maybe_break(8)}
    #{from(env, __MODULE__)}\
    """
  end

  info :restarted, {spec, env} do
    """
    \nRestarted table spec server...
    • Spec name: #{inspect(spec.spec_name)}
    • Server PID: #{self() |> inspect() |> maybe_break(14)}
    • Spec: #{inspect(spec) |> maybe_break(8)}
    #{from(env, __MODULE__)}\
    """
  end

  info :saving, {spec, env} do
    """
    \nSaving table spec...
    • Server: #{via(spec.spec_name) |> inspect() |> maybe_break(10)}
    • Server PID: #{self() |> inspect() |> maybe_break(14)}
    • Spec: #{inspect(spec) |> maybe_break(8)}
    #{from(env, __MODULE__)}\
    """
  end
end
