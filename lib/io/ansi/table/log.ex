defmodule IO.ANSI.Table.Log do
  use File.Only.Logger

  import IO.ANSI.Table.SpecServer, only: [via: 1]

  error :terminate, {reason, spec, env} do
    """
    \nTerminating table spec server...
    • Server: #{via(spec.spec_name) |> inspect() |> maybe_break(10)}
    • Server PID: #{self() |> inspect() |> maybe_break(14)}
    • 'terminate' reason: #{inspect(reason) |> maybe_break(22)}
    • Spec: #{inspect(spec) |> maybe_break(8)}
    #{from(env, __MODULE__)}
    """
  end

  info :terminate, {reason, spec, env} do
    """
    \nTerminating table spec server...
    • Server: #{via(spec.spec_name) |> inspect() |> maybe_break(10)}
    • Server PID: #{self() |> inspect() |> maybe_break(14)}
    • 'terminate' reason: #{inspect(reason) |> maybe_break(22)}
    • Spec: #{inspect(spec) |> maybe_break(8)}
    #{from(env, __MODULE__)}
    """
  end

  info :save, {spec, env} do
    """
    \nSaving spec...
    • Server: #{via(spec.spec_name) |> inspect() |> maybe_break(10)}
    • Server PID: #{self() |> inspect() |> maybe_break(14)}
    • Spec: #{inspect(spec) |> maybe_break(8)}
    #{from(env, __MODULE__)}
    """
  end

  info :handle_cast, {spec, {:write, maps, options}, env} do
    """
    \nHandling cast...
    • Server: #{via(spec.spec_name) |> inspect() |> maybe_break(10)}
    • Server PID: #{self() |> inspect() |> maybe_break(14)}
    • Request: '{:write, <maps>, <options>}'
    • Number of maps: #{length(maps)}
    • Options: #{inspect(options)}
    • Spec: #{inspect(spec) |> maybe_break(8)}
    #{from(env, __MODULE__)}
    """
  end

  info :handle_call, {spec, {:format, maps, options}, env} do
    """
    \nHandling call...
    • Server: #{via(spec.spec_name) |> inspect() |> maybe_break(10)}
    • Server PID: #{self() |> inspect() |> maybe_break(14)}
    • Request: '{:format, <maps>, <options>}'
    • Number of maps: #{length(maps)}
    • Options: #{inspect(options)}
    • Spec: #{inspect(spec) |> maybe_break(8)}
    #{from(env, __MODULE__)}
    """
  end

  info :handle_call, {spec, :get, env} do
    """
    \nHandling call...
    • Server: #{via(spec.spec_name) |> inspect() |> maybe_break(10)}
    • Server PID: #{self() |> inspect() |> maybe_break(14)}
    • Request: ':get'
    • Spec: #{inspect(spec) |> maybe_break(8)}
    #{from(env, __MODULE__)}
    """
  end

  info :spawned, {spec, env} do
    """
    \nSpawned table spec server...
    • Spec name: #{inspect(spec.spec_name)}
    • Server PID: #{self() |> inspect() |> maybe_break(14)}
    #{from(env, __MODULE__)}
    """
  end

  info :restarted, {spec, env} do
    """
    \nRestarted table spec server...
    • Spec name: #{inspect(spec.spec_name)}
    • Server PID: #{self() |> inspect() |> maybe_break(14)}
    #{from(env, __MODULE__)}
    """
  end
end
