# ┌───────────────────────────────────────────────────────────┐
# │ Inspired by the book "Programming Elixir" by Dave Thomas. │
# └───────────────────────────────────────────────────────────┘
defmodule IO.ANSI.Table do
  @moduledoc """
  Writes data to `:stdio` as a table with borders and colors.
  Can choose a table style to change the look of the table.

  ##### Inspired by the book [Programming Elixir](https://pragprog.com/titles/elixir16/programming-elixir-1-6) by Dave Thomas.
  """

  use PersistConfig

  alias __MODULE__.{DynSpecSup, Header, Spec, SpecServer}

  @reg get_env(:registry)

  @doc """
  Starts a new table spec server process and supervises it.
  Upon request (see `format/2`), the server will write data from a list of
  maps to `:stdio` as a table formatted according to `headers` and `options`.

  The table columns are identified by `headers` (`t:Map.key/0`).
  We calculate the width of each column to fit the longest element
  in that column, also considering the column heading (derived from header).
  However, the `:max_width` option prevails.

  If the `:count` option is positive, we format the first _count_
  maps in the list, once sorted. If negative, the last _count_ ones.

  See `IO.ANSI.Table.Options` for a list of all options in this API.

  ## Parameters

    - `headers` - keys identifying each column (list)
    - `options` - up to `10` options (keyword)

  ## Options

    - `:align_specs`  - to align column elements (list/keyword)
    - `:bell`         - whether to ring the bell (boolean)
    - `:count`        - number of maps to format (integer)
    - `:header_fixes` - to alter the `headers` (map)
    - `:margins`      - to position the table (keyword)
    - `:max_width`    - to cap column widths (non neg integer)
    - `:sort_specs`   - to sort the maps (list/keyword)
    - `:sort_symbols` - to denote sort direction (keyword)
    - `:spec_name`    - to identify the table spec server (string)
    - `:style`        - table style (atom)

  ## Notes

    - Option `:spec_name` defaults to the current app name (as a string).

  ## Examples

      iex> alias IO.ANSI.Table
      iex> alias IO.ANSI.Table.SpecServer
      iex> {:ok, pid} = Table.start([:name, :dob, :likes], spec_name: "people")
      iex> pid == SpecServer.via("people") |> GenServer.whereis()
      true
  """
  @spec start([Header.t(), ...], keyword) :: Supervisor.on_start_child()
  def start([_ | _] = headers, options \\ []) when is_list(options) do
    spec = Spec.new(headers, options)
    DynamicSupervisor.start_child(DynSpecSup, {SpecServer, spec})
  end

  @doc """
  Stops a table spec server process normally. It won't be restarted.
  The table spec server to stop is identified by option `:spec_name`.

  See `IO.ANSI.Table.Options` for a list of all options in this API.

  ## Parameters

    - `options` - up to `1` option (keyword)

  ## Options

    - `:spec_name` - to identify the table spec server (string)

  ## Notes

    - Option `:spec_name` defaults to the current app name (as a string).

  ## Examples

      iex> alias IO.ANSI.Table
      iex> Table.start([:name, :dob, :likes])
      iex> Table.stop()
      :ok

      iex> alias IO.ANSI.Table
      iex> Table.start([:name, :dob, :likes], spec_name: "stats")
      iex> Table.stop(spec_name: "stats")
      :ok
  """
  @spec stop(keyword) :: :ok
  def stop(options \\ []) when is_list(options) do
    spec_name = Spec.spec_name(options)
    SpecServer.via(spec_name) |> GenServer.stop(:shutdown)
  end

  @doc """
  Sends a request to the table spec server identified by option `:spec_name`.
  The server will write data from `maps` to `:stdio` as a table formatted
  according to its spec and `options`.

  Also supports:

    - keywords
    - structs implementing the [Access](https://hexdocs.pm/elixir/Access.html)
      behaviour.

  Does not support:

    - _nested_ maps, keywords or structs

  See `IO.ANSI.Table.Options` for a list of all options in this API.

  ## Parameters

    - `maps`    - _flat_ maps/keywords/structs (list)
    - `options` - up to `6` options (keyword)

  ## Options

    - `:async`     - whether to write the table asynchronously (boolean)
    - `:bell`      - whether to ring the bell (boolean)
    - `:count`     - number of `maps` to format (integer)
    - `:max_width` - to cap column widths (non neg integer)
    - `:spec_name` - to identify the table spec server (string)
    - `:style`     - table style (atom)

  ## Notes

    - Option `:spec_name` defaults to the current app name (as a string).

  ## Examples

      alias IO.ANSI.Table

      people = [
        %{name: "Mike", likes: "ski, arts", dob: "1992-04-15", bmi: 23.9},
        %{name: "Mary", likes: "travels"  , dob: "1992-04-15", bmi: 26.8},
        %{name: "Ann" , likes: "reading"  , dob: "1992-04-15", bmi: 24.7},
        %{name: "Ray" , likes: "cycling"  , dob: "1977-08-28", bmi: 19.1},
        %{name: "Bill", likes: "karate"   , dob: "1977-08-28", bmi: 18.1},
        %{name: "Joe" , likes: "boxing"   , dob: "1977-08-28", bmi: 20.8},
        %{name: "Jill", likes: "cooking"  , dob: "1976-09-28", bmi: 25.8}
      ]

      Table.start([:name, :dob, :likes],
        header_fixes: %{~r[dob]i => "Date of Birth"},
        sort_specs: [asc: :dob],
        align_specs: [center: :dob],
        margins: [top: 2, bottom: 2, left: 2]
      )

      Table.format(people, style: :light)
      Table.format(people, style: :light_alt)
      Table.format(people, style: :light_mult)
      Table.format(people, style: :cyan_alt)
      Table.format(people, style: :cyan_mult)

  ## ![light](images/light.png)
  ## ![light_alt](images/light_alt.png)
  ## ![light_mult](images/light_mult.png)
  ## ![cyan_alt](images/cyan_alt.png)
  ## ![cyan_mult](images/cyan_mult.png)
  """
  @spec format([Access.container()], keyword) :: :ok
  def format(maps, options \\ []) when is_list(maps) and is_list(options) do
    spec_name = Spec.spec_name(options)

    if options[:async] do
      SpecServer.via(spec_name) |> GenServer.cast({:format, maps, options})
    else
      SpecServer.via(spec_name) |> GenServer.call({:format, maps, options})
    end
  end

  @doc """
  Sends a request to the table spec server identified by option `:spec_name`.
  Returns the server's table spec.

  See `IO.ANSI.Table.Options` for a list of all options in this API.

  ## Parameters

    - `options` - up to `1` option (keyword)

  ## Options

    - `:spec_name` - to identify the table spec server (string)

  ## Notes

    - Option `:spec_name` defaults to the current app name (as a string).

  ## Examples

      iex> alias IO.ANSI.Table
      iex> Table.start([:name, :dob, :likes])
      iex> spec = Table.get_spec()
      iex> {spec.headers, spec.spec_name}
      {[:name, :dob, :likes], "io_ansi_table"}

      iex> alias IO.ANSI.Table
      iex> Table.start([:name, :dob, :likes], spec_name: "members")
      iex> spec = Table.get_spec(spec_name: "members")
      iex> {spec.headers, spec.spec_name}
      {[:name, :dob, :likes], "members"}
  """
  @spec get_spec(keyword) :: Spec.t()
  def get_spec(options \\ []) when is_list(options) do
    # spec_name = Spec.spec_name(options)
    # SpecServer.via(spec_name) |> GenServer.call(:get_spec)
    options
    |> Spec.spec_name()
    |> SpecServer.via()
    |> GenServer.call(:get_spec)
  end

  @doc """
  Sends a request to the table spec server identified by option `:spec_name`
  to update its table spec using the given `options`.

  See `IO.ANSI.Table.Options` for a list of all options in this API.

  ## Parameters

    - `options` - up to `10` options (keyword)

  ## Options

    - `:align_specs`  - to align column elements (list/keyword)
    - `:bell`         - whether to ring the bell (boolean)
    - `:count`        - number of maps to format (integer)
    - `:header_fixes` - to alter the `headers` (map)
    - `:margins`      - to position the table (keyword)
    - `:max_width`    - to cap column widths (non neg integer)
    - `:sort_specs`   - to sort the maps (list/keyword)
    - `:sort_symbols` - to denote sort direction (keyword)
    - `:spec_name`    - to identify the table spec server (string)
    - `:style`        - table style (atom)

  ## Notes

    - Option `:spec_name` defaults to the current app name (as a string).
    - Options `:margins` and `:sort_symbols` can specify a subset of their keys.

  ## Examples

      iex> alias IO.ANSI.Table
      iex> alias IO.ANSI.Table.Spec
      iex> Table.start([:name, :dob, :likes])
      iex> options = [margins: [top: -9], bell: true, sort_symbols: [asc: "⇑"]]
      iex> :ok = Table.update_spec(options)
      iex> spec = Table.get_spec()
      iex> %Spec{margins: m, sort_symbols: ss, bell: b} = spec
      iex> {Enum.sort(m), Enum.sort(ss), b}
      {[bottom: 1, left: 2, top: -9],
       [asc: "⇑", desc: "↓", pos: :trailing],
       true}
  """
  @spec update_spec(keyword) :: :ok
  def update_spec(options \\ []) when is_list(options) do
    options
    |> Spec.spec_name()
    |> SpecServer.via()
    |> GenServer.call({:update_spec, options})
  end

  @doc """
  Writes data from `maps` to `:stdio` as a table formatted according to
  `spec` and `options`.

  Also supports:

    - keywords
    - structs implementing the [Access](https://hexdocs.pm/elixir/Access.html)
      behaviour

  Does not support:

    - _nested_ maps, keywords or structs

  See `IO.ANSI.Table.Options` for a list of all options in this API.

  ## Parameters

    - `spec`    - table spec (struct)
    - `maps`    - _flat_ maps/keywords/structs (list)
    - `options` - up to `4` options (keyword)

  ## Options

    - `:bell`      - whether to ring the bell (boolean)
    - `:count`     - number of `maps` to format (integer)
    - `:max_width` - to cap column widths (non neg integer)
    - `:style`     - table style (atom)

  ## Notes

    - If only using this function (`write/3` and not `format/2` whatsoever),
      you could configure `io_ansi_table` as an included application so it
      runs as a library application (without needing its supervision tree):

      ```elixir
      def application do
        [
          included_applications: [:io_ansi_table],
          extra_applications: [:logger]
        ]
      end
      ```

  ## Examples

      alias IO.ANSI.Table
      alias IO.ANSI.Table.Spec

      people = [
        %{name: "Mike", likes: "ski, arts", dob: "1992-04-15", bmi: 23.9},
        %{name: "Mary", likes: "travels"  , dob: "1992-04-15", bmi: 26.8},
        %{name: "Ann" , likes: "reading"  , dob: "1992-04-15", bmi: 24.7},
        %{name: "Ray" , likes: "cycling"  , dob: "1977-08-28", bmi: 19.1},
        %{name: "Bill", likes: "karate"   , dob: "1977-08-28", bmi: 18.1},
        %{name: "Joe" , likes: "boxing"   , dob: "1977-08-28", bmi: 20.8},
        %{name: "Jill", likes: "cooking"  , dob: "1976-09-28", bmi: 25.8}
      ]

      spec =
        Spec.new([:name, :dob, :likes],
          header_fixes: %{~r[dob]i => "Date of Birth"},
          sort_specs: [asc: :dob],
          align_specs: [center: :dob],
          margins: [top: 2, bottom: 2, left: 2]
        )
        |> Spec.expand()

      Table.write(spec, people, style: :light)
      Table.write(spec, people, style: :light_alt)
      Table.write(spec, people, style: :light_mult)
      Table.write(spec, people, style: :cyan_alt)
      Table.write(spec, people, style: :cyan_mult)
  """
  @spec write(Spec.t(), [Access.container()], keyword) :: :ok
  defdelegate write(spec, maps, options \\ []), to: Spec, as: :write_table

  @doc """
  Returns a sorted list of registered spec names.
  """
  @spec spec_names :: [String.t() | atom]
  def spec_names do
    DynamicSupervisor.which_children(DynSpecSup)
    |> Enum.map(&child_name/1)
    |> Enum.sort()
  end

  @doc """
  Returns the PID of the spec server process registered via the
  given `spec_name`, or `nil` if no such process is registered.
  """
  @spec spec_pid(String.t()) :: pid | nil
  def spec_pid(spec_name), do: SpecServer.via(spec_name) |> GenServer.whereis()

  ## Private functions

  @spec child_name(tuple) :: String.t() | atom
  defp child_name({:undefined, pid, :worker, modules}) when is_pid(pid) do
    if SpecServer in modules do
      [{SpecServer, spec_name}] = Registry.keys(@reg, pid)
      spec_name
    else
      :worker
    end
  end

  defp child_name({:undefined, :restarting, _type, _modules}), do: :restarting
  defp child_name({:undefined, _pid, :supervisor, _modules}), do: :supervisor
end
