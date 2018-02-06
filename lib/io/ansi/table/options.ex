defmodule IO.ANSI.Table.Options do
  @moduledoc """
  Documents the `IO.ANSI.Table.Options` using configuration examples.

  ## Notes

  You can configure `:async` which is a compile time option. Therefore
  changing this option requires to recompile the `:io_ansi_table` app.
  When `true` the table will print asynchronously. Defaults to `false`.

  If option `sort_specs` (see below) specifies structs like `%Date{}`
  or `%Time{}`, you must provide the following configuration and then
  recompile the `:map_sorter` dependency used by `:io_ansi_table`:

  - `config :map_sorter, sorting_on_structs?: true`
  - `mix deps.compile map_sorter`

  ## Examples

  - `align_specs` - to align column elements (list of attribute/header pairs
                    where the attribute is `:left`, `:center` or `:right` and
                    the default attribute is `:left`)

    ```elixir
    config :io_ansi_table, align_specs: [
      center: "station_id", right: "pressure_mb", right: "pressure_in"
    ]
    ```

    ```elixir
    config :io_ansi_table, align_specs: [
      left: "station_id", right: "wind_mph"
    ]
    ```

    ```elixir
    config :io_ansi_table, align_specs: [
      "station_id", right: "wind_mph"
    ]
    ```

  - `bell` - ring the bell? (boolean)

    ```elixir
    config :io_ansi_table, bell: true
    ```

    ```elixir
    config :io_ansi_table, bell: false
    ```

  - `count` - number of maps/keywords/structs to format (integer)

    ```elixir
    config :io_ansi_table, count: 11 # default count
    ```

    ```elixir
    config :io_ansi_table, count: -11
    ```

  - `headers` - to identify each column (list)

    ```elixir
    config :io_ansi_table, headers: [
      "station_id", "observation_time_rfc822", "wind_mph"
    ]
    ```

  - `header_fixes` - to alter the `headers` (map)

    ```elixir
    config :io_ansi_table, header_fixes: %{ # merged with default header fixes
      ~r[ id$]i       => " ID",
      ~r[ mph$]i      => " MPH",
      ~r[ rfc(...)$]i => " RFC-\\\\1"
    }
    ```

    ```elixir
    config :io_ansi_table, header_fixes: %{ # default header fixes
      " A "       => " a ",
      " After "   => " after ",
      " Along "   => " along ",
      " An "      => " an ",
      " And "     => " and ",
      " Around "  => " around ",
      " At "      => " at ",
      " But "     => " but ",
      " By "      => " by ",
      " For "     => " for ",
      " From "    => " from ",
      " Not "     => " not ",
      " Of "      => " of ",
      " On "      => " on ",
      " Or "      => " or ",
      " So "      => " so ",
      " The "     => " the ",
      " To "      => " to ",
      " With "    => " with ",
      " Without " => " without ",
      " Yet "     => " yet "
    }
    ```

  - `margins` - to position the table (keyword)

    ```elixir
    config :io_ansi_table, margins: [ # merged with default margins
      left: 3 # column(s) left of table
    ]
    ```

    ```elixir
    config :io_ansi_table, margins: [ # default margins
      top:    1, # line(s) before table (can be negative)
      bottom: 1, # line(s) after table
      left:   2  # column(s) left of table
    ]
    ```

    ```elixir
    config :io_ansi_table, margins: [ # example for side-by-side tables
      top:    -11, # move cursor up 11 lines!!
      bottom:   1,
      left:    35, # move cursor forward 35 columns!!
    ]
    ```

  - `max_width` - to cap column widths (non_neg_integer)

    ```elixir
    config :io_ansi_table, max_width: 99 # default max width
    ```

  - `sort_specs` - to sort the maps/keywords/structs (list of attribute/header
                   pairs where the attribute is `:asc` or `:desc` and
                   the default attribute is `:asc`)

    ```elixir
    config :io_ansi_table, sort_specs: [
      "station_id", "wind_mph"
    ]
    ```

    ```elixir
    config :io_ansi_table, sort_specs: [
      "station_id", desc: "wind_mph", desc: "temp_c"
    ]
    ```

    ```elixir
    config :io_ansi_table, sort_specs: [
      asc: "station_id", desc: "wind_mph"
    ]
    ```

  - `sort_symbols` - to denote sort direction (keyword)

    ```elixir
    config :io_ansi_table, sort_symbols: [ # merged with default sort symbols
      asc: "^", pos: [:leading, :trailing]
    ]
    ```

    ```elixir
    config :io_ansi_table, sort_symbols: [ # default sort symbols
      asc: "↑", desc: "↓", pos: :trailing
    ]
    ```

    ```elixir
    config :io_ansi_table, sort_symbols: [
      asc: "▲", desc: "▼", pos: :trailing
    ]
    ```

    ```
    config :io_ansi_table, sort_symbols: [
      asc: "^", desc: "v", pos: :leading
    ]
    ```

  - `style` - table style (atom)

    ```elixir
    config :io_ansi_table, style: :plain # default style
    ```

    ```elixir
    config :io_ansi_table, style: :dark
    ```
  """
end
