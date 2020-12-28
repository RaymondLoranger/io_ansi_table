defmodule IO.ANSI.Table.Log do
  use File.Only.Logger

  alias IO.ANSI.Table.SpecServer

  error :terminate, {reason, spec, env} do
    """
    \nTerminating table spec server...
    • Inside function:
      #{fun(env)}
    • Server:
      #{spec.spec_name |> SpecServer.via() |> inspect()}
    • Server PID: #{self() |> inspect()}
    • 'terminate' reason: #{inspect(reason)}
    • Spec:
      #{inspect(spec)}
    #{from()}
    """
  end

  info :terminate, {reason, spec, env} do
    """
    \nTerminating table spec server...
    • Inside function:
      #{fun(env)}
    • Server:
      #{spec.spec_name |> SpecServer.via() |> inspect()}
    • Server PID: #{self() |> inspect()}
    • 'terminate' reason: #{inspect(reason)}
    • Spec:
      #{inspect(spec)}
    #{from()}
    """
  end

  info :save, {spec, env} do
    """
    \nSaving spec...
    • Inside function:
      #{fun(env)}
    • Server:
      #{spec.spec_name |> SpecServer.via() |> inspect()}
    • Server PID: #{self() |> inspect()}
    • Spec:
      #{inspect(spec)}
    #{from()}
    """
  end

  info :handle_cast, {spec, {:write, maps, options}, env} do
    """
    \nHandling cast...
    • Inside function:
      #{fun(env)}
    • Server:
      #{spec.spec_name |> SpecServer.via() |> inspect()}
    • Server PID: #{self() |> inspect()}
    • Request: '{:write, <maps>, <options>}'
    • Number of maps: #{length(maps)}
    • Options: #{inspect(options)}
    • Spec:
      #{inspect(spec)}
    #{from()}
    """
  end

  info :handle_call, {spec, {:format, maps, options}, env} do
    """
    \nHandling call...
    • Inside function:
      #{fun(env)}
    • Server:
      #{spec.spec_name |> SpecServer.via() |> inspect()}
    • Server PID: #{self() |> inspect()}
    • Request: '{:format, <maps>, <options>}'
    • Number of maps: #{length(maps)}
    • Options: #{inspect(options)}
    • Spec:
      #{inspect(spec)}
    #{from()}
    """
  end

  info :handle_call, {spec, :get, env} do
    """
    \nHandling call...
    • Inside function:
      #{fun(env)}
    • Server:
      #{spec.spec_name |> SpecServer.via() |> inspect()}
    • Server PID: #{self() |> inspect()}
    • Request: ':get'
    • Spec:
      #{inspect(spec)}
    #{from()}
    """
  end

  info :spawned, {spec} do
    """
    \nSpawned table spec server...
    • Spec name: #{inspect(spec.spec_name)}
    • Server PID: #{self() |> inspect()}
    #{from()}
    """
  end

  info :restarted, {spec} do
    """
    \nRestarted table spec server...
    • Spec name: #{inspect(spec.spec_name)}
    • Server PID: #{self() |> inspect()}
    #{from()}
    """
  end
end
