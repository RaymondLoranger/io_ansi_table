defmodule IO.ANSI.Table.Log do
  use File.Only.Logger

  import IO.ANSI.Table.SpecServer, only: [via: 1]

  error :app_start, {reason, app, env} do
    """
    \nError starting application...
    • Call: 'Application.ensure_all_started/1'
    • App argument: #{inspect(app)}
    • Reason: #{inspect(reason) |> maybe_break(10)}
    #{from(env, __MODULE__)}\
    """
  end

  error :terminate, {reason, spec, env} do
    """
    \nTerminating table spec server...
    • Server: #{via(spec.spec_name) |> inspect() |> maybe_break(10)}
    • Server PID: #{self() |> inspect() |> maybe_break(14)}
    • 'terminate' reason: #{inspect(reason) |> maybe_break(22)}
    • Spec: #{inspect(spec) |> maybe_break(8)}
    #{from(env, __MODULE__)}\
    """
  end

  info :terminate, {reason, spec, env} do
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

  info :spawned, {spec, env} do
    """
    \nSpawned table spec server...
    • Spec name: #{inspect(spec.spec_name)}
    • Server PID: #{self() |> inspect() |> maybe_break(14)}
    #{from(env, __MODULE__)}\
    """
  end

  info :restarted, {spec, env} do
    """
    \nRestarted table spec server...
    • Spec name: #{inspect(spec.spec_name)}
    • Server PID: #{self() |> inspect() |> maybe_break(14)}
    #{from(env, __MODULE__)}\
    """
  end

  info :save, {spec, env} do
    """
    \nSaving table spec...
    • Server: #{via(spec.spec_name) |> inspect() |> maybe_break(10)}
    • Server PID: #{self() |> inspect() |> maybe_break(14)}
    • Spec: #{inspect(spec) |> maybe_break(8)}
    #{from(env, __MODULE__)}\
    """
  end
end
