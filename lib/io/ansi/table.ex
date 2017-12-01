# ┌───────────────────────────────────────────────────────────┐
# │ Inspired by the book "Programming Elixir" by Dave Thomas. │
# └───────────────────────────────────────────────────────────┘
defmodule IO.ANSI.Table do
  @moduledoc """
  Prints data to STDOUT in a table with borders and colors.

  Can choose a table style among the 40 already predefined.
  """

  use PersistConfig

  alias IO.ANSI.Table.{Server, Style}

  @async Application.get_env(@app, :async)

  @doc """
  Same as `format/2` but will use configured options.
  """
  @spec format([Access.container]) :: :ok
  if @async do
    def format(maps), do: GenServer.cast(Server, {maps})
  else
    def format(maps), do: GenServer.call(Server, {maps})
  end

  @doc """
  Prints data from `maps` to STDOUT in a table tailored by `options`.

  The columns are identified by the `:headers` option (`map` keys).
  We calculate the width of each column to fit the longest element
  in that column, also considering the column heading.
  However, the `:max_width` option prevails.

  If the `:count` option is positive, we format the first _n_
  `maps` in the list, once sorted. If negative, the last _n_ ones.

  See `IO.ANSI.Table.Options` for examples of all options.

  ## Parameters

    - `maps`    - list of maps/keywords/structs (list)
    - `options` - up to 10 options all configurable (keyword)

  ## Options

    - `:align_specs`  - to align column elements (list)
    - `:bell`         - ring the bell? (boolean)
    - `:count`        - number of `maps` to format (integer)
    - `:headers`      - to identify each column (list)
    - `:header_fixes` - to alter the `headers` (map)
    - `:margins`      - to position the table (keyword)
    - `:max_width`    - to cap column widths (non_neg_integer)
    - `:sort_specs`   - to sort the `maps` (list)
    - `:sort_symbols` - to denote sort direction (keyword)
    - `:style`        - table style (atom)

  ## Table styles

  #{Style.texts("  - `&style`&filler - &note\n")}

  ## Examples

      alias IO.ANSI.Table
      people = [
        %{name: "Mike", likes: "ski, arts", dob: "1992-04-15"},
        %{name: "Mary", likes: "reading"  , dob: "1985-07-11"},
        %{name: "Ray" , likes: "cycling"  , dob: "1977-08-28"}
      ]
      Table.format(
        people, bell: true, count: 3, style: :dark,
        headers: [:name, :dob, :likes],
        header_fixes: %{~r[^dob$]i => "Date of Birth"},
        sort_specs: [:dob],
        align_specs: [center: :dob],
        margins: [top: 2, bottom: 2]
      )

  ## ![print_table_people](images/print_table_people.png)
  """
  @spec format([Access.container], Keyword.t) :: :ok
  if @async do
    def format(maps, options), do: GenServer.cast(Server, {maps, options})
  else
    def format(maps, options), do: GenServer.call(Server, {maps, options})
  end
end
