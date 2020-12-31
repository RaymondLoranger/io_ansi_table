# ┌───────────────────────────────────────────────────────────┐
# │ Inspired by the book "Programming Elixir" by Dave Thomas. │
# └───────────────────────────────────────────────────────────┘
defmodule IO.ANSI.Table do
  @moduledoc """
  Writes data to stdout in a table with borders and colors.
  Can choose a table style to change the look of the table.

  ##### Inspired by the book [Programming Elixir](https://pragprog.com/book/elixir16/programming-elixir-1-6) by Dave Thomas.
  """

  use PersistConfig

  alias __MODULE__.{DynSpecSup, Header, Spec, SpecServer}

  @doc """
  Starts a new table spec server process and supervises it.
  Upon request (see `format/2`), the server will write data from
  `maps` to stdout in a table formatted per `headers` and `options`.

  The table columns are identified by `headers` (`map` keys).
  We calculate the width of each column to fit the longest element
  in that column, also considering the column heading.
  However, the `:max_width` option prevails.

  If the `:count` option is positive, we format the first _count_
  `maps` in the list, once sorted. If negative, the last _count_ ones.

  See `IO.ANSI.Table.Options` for a list of all options in this API.

  ## Parameters

    - `headers` - keys identifying each column (list)
    - `options` - up to `10` options (keyword)

  ## Options

    - `:align_specs`  - to align column elements (list)
    - `:bell`         - whether to ring the bell (boolean)
    - `:count`        - number of `maps` to format (integer)
    - `:header_fixes` - to alter the `headers` (map)
    - `:margins`      - to position the table (keyword)
    - `:max_width`    - to cap column widths (non neg integer)
    - `:sort_specs`   - to sort the `maps` (list)
    - `:sort_symbols` - to denote sort direction (keyword)
    - `:spec_name`    - to identify the table spec server (string)
    - `:style`        - table style (atom)

  ## Examples

      iex> alias IO.ANSI.Table
      iex> alias IO.ANSI.Table.SpecServer
      iex> {:ok, pid} = Table.start([:name, :dob, :likes])
      iex> pid == SpecServer.via("io_ansi_table") |> GenServer.whereis()
      true
  """
  @spec start([Header.t(), ...], Keyword.t()) :: Supervisor.on_start_child()
  def start([_ | _] = headers, options \\ []) when is_list(options) do
    spec = Spec.new(headers, options)
    DynamicSupervisor.start_child(DynSpecSup, {SpecServer, spec})
  end

  @doc """
  Stops a table spec server process normally. It won't be restarted.
  The table spec server to stop is identified by `option` `:spec_name`.

  See `IO.ANSI.Table.Options` for a list of all options in this API.

  ## Parameters

    - `options` - up to `1` option (keyword)

  ## Options

    - `:spec_name` - to identify the table spec server (string)

  ## Examples

      iex> alias IO.ANSI.Table
      iex> Table.start([:name, :dob, :likes])
      iex> Table.stop
      :ok
  """
  @spec stop(Keyword.t()) :: :ok
  def stop(options \\ []) when is_list(options) do
    spec_name = Spec.spec_name(options)
    SpecServer.via(spec_name) |> GenServer.stop(:shutdown)
  end

  @doc """
  Sends a request to the table spec server identified by `option` `:spec_name`.
  The server will write data from `maps` to stdout in a table formatted per its
  spec and `options`.

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
  @spec format([Access.container()], Keyword.t()) :: :ok
  def format(maps, options \\ []) when is_list(maps) and is_list(options) do
    spec_name = Spec.spec_name(options)

    if options[:async],
      do: GenServer.cast(SpecServer.via(spec_name), {:format, maps, options}),
      else: GenServer.call(SpecServer.via(spec_name), {:format, maps, options})
  end

  @doc """
  Sends a request to the table spec server identified by `option` `:spec_name`.
  Returns the server's table spec.

  See `IO.ANSI.Table.Options` for a list of all options in this API.

  ## Parameters

    - `options` - up to `1` option (keyword)

  ## Options

    - `:spec_name` - to identify the table spec server (string)
  """
  def get(options \\ []) when is_list(options) do
    spec_name = Spec.spec_name(options)
    GenServer.call(SpecServer.via(spec_name), :get)
  end

  @doc """
  Writes data from `maps` to stdout in a table formatted per `spec` and
  `options`.

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
        |> Spec.extend()

      Table.write(people, spec, style: :light)
      Table.write(people, spec, style: :light_alt)
      Table.write(people, spec, style: :light_mult)
      Table.write(people, spec, style: :cyan_alt)
      Table.write(people, spec, style: :cyan_mult)
  """
  @spec write([Access.container()], Spec.t(), Keyword.t()) :: :ok
  defdelegate write(maps, spec, options \\ []), to: Spec, as: :write_table
end
