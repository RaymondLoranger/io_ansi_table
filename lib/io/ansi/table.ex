# ┌───────────────────────────────────────────────────────────┐
# │ Inspired by the book "Programming Elixir" by Dave Thomas. │
# └───────────────────────────────────────────────────────────┘
defmodule IO.ANSI.Table do
  @moduledoc """
  Prints data to STDOUT in a table with borders and colors.

  Can choose a table style to change the look of the table.
  """

  use PersistConfig

  alias __MODULE__.{Server, Style}

  @async Application.get_env(@app, :async)

  @doc """
  Prints data from `maps` to STDOUT in a table tailored by `options`.

  All options can be configured and/or passed as a keyword argument.
  Each option of the keyword will override its configured counterpart.
  You should however configure all options except possibly
  `bell`, `count` and `style`.

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

      # Assuming the following config:

      # config :io_ansi_table, headers: [:name, :dob, :likes]
      # config :io_ansi_table, header_fixes: %{~r[dob]i => "Date of Birth"}
      # config :io_ansi_table, sort_specs: [asc: :dob]
      # config :io_ansi_table, align_specs: [center: :dob]
      # config :io_ansi_table, margins: [top: 2, bottom: 2]

      alias IO.ANSI.Table
      people = [
        %{name: "Mike", likes: "ski, arts", dob: "1992-04-15"},
        %{name: "Mary", likes: "reading"  , dob: "1985-07-11"},
        %{name: "Ray" , likes: "cycling"  , dob: "1977-08-28"}
      ]
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
  if @async do
    def format(maps, options \\ []) when is_list(options) do
      GenServer.cast(Server, {maps, options})
    end
  else
    def format(maps, options \\ []) when is_list(options) do
      GenServer.call(Server, {maps, options})
    end
  end
end
