defmodule IO.ANSI.Table.Options do
  alias IO.ANSI.Table.Style

  @moduledoc """
  Lists the options and table styles used in the `IO.ANSI.Table` API.

  ## Options

  * `:align_specs` - to align column elements (list of
    [align specs](`t:IO.ANSI.Table.Header.align_spec/0`) where `:left` is the
    default [align attribute](`t:IO.ANSI.Table.Header.align_attr/0`)).
    Defaults to `[]`.

    ```elixir
    align_specs: [
      center: "station_id", right: "pressure_mb", right: "pressure_in"
    ]
    ```

    ```elixir
    align_specs: [left: "station_id", right: "wind_mph"]
    ```

    ```elixir
    align_specs: ["station_id", right: "wind_mph"]
    ```

  * `:async` - whether to write the table asynchronously (boolean). Defaults to
    `false`.

  * `:bell` - whether to ring the bell (boolean). Defaults to `false`.

  * `:count` - number of [maps/keywords/structs](`t:Access.container/0`)
    to format (integer). Defaults to `11`.

    ```elixir
    count: 11 # first 11 sorted `maps`
    ```

    ```elixir
    count: -11 # last 11 sorted `maps`
    ```

  * `:header_fixes` - to alter the [headers](`t:IO.ANSI.Table.Header.t/0`)
    once converted to "title case" (map). Defaults to %{}.

    ```elixir
    header_fixes: %{
      # "station_id" => "Station ID"
      ~r[ id$]i       => " ID",
      # "wind_mph" => "Wind MPH"
      ~r[ mph$]i      => " MPH",
      # "observation_time_rfc822" => "Observation Time RFC-822"
      ~r[ rfc(\\d+)$]i => " RFC-\\\\1"
    }
    ```

    ```elixir
    header_fixes: %{
      " A "   => " a ",
      " An "  => " an ",
      " And " => " and ",
      " At "  => " at ",
      " But " => " but ",
      " By "  => " by ",
      " For " => " for ",
      " Not " => " not ",
      " Of "  => " of ",
      " On "  => " on ",
      " Or "  => " or ",
      " So "  => " so ",
      " The " => " the ",
      " To "  => " to ",
      " Yet " => " yet "
    }
    ```

  * `:margins` - to position the table (keyword). Defaults to
    `[top: 1, bottom: 1, left: 2]`

    ```elixir
    margins: [ # default margins
      top:    1, # line(s) before table (can be negative)
      bottom: 1, # line(s) after table
      left:   2  # column(s) left of table
    ]
    ```

    ```elixir
    margins: [ # example of a side-by-side table
      top:    -11, # move cursor up 11 lines!!
      bottom:   1,
      left:    35, # move cursor forward 35 columns!!
    ]
    ```

  * `:max_width` - to cap column widths (non neg integer). Defaults to `99`.

  * `:sort_specs` - to sort the maps/keywords/structs (list of
    [sort specs](`t:IO.ANSI.Table.Header.sort_spec/0`) where `:asc` is the
    default [sort attribute](`t:IO.ANSI.Table.Header.sort_attr/0`)).
    Defaults to `[]`.

    ```elixir
    sort_specs: ["station_id", "wind_mph"]
    ```

    ```elixir
    sort_specs: ["station_id", desc: "wind_mph", desc: "temp_c"]
    ```

    ```elixir
    sort_specs: [asc: "station_id", desc: "wind_mph"]
    ```

    ```elixir
    sort_specs: ["dept", desc: {"hired", Date}]
    ```

    ```elixir
    sort_specs: [{"hired", Date}, "job", {:desc, "dept"}]
    ```

    ```elixir
    sort_specs: [{"hired", Date}, desc: "dept"]
    ```

  * `:sort_symbols` - to denote sort direction (keyword list of
    [sort symbols](`t:IO.ANSI.Table.Header.sort_symbol/0`)). Defaults to
    `[asc: "↑", desc: "↓", pos: :trailing]`.

    ```elixir
    sort_symbols: [asc: "↑", desc: "↓", pos: :trailing] # default sort symbols
    ```

    ```elixir
    sort_symbols: [asc: " ▲ ", desc: " ▼ ", pos: [:leading, :trailing]]
    ```

    ```elixir
    sort_symbols: [asc: "⬆", desc: "⬇", pos: :leading]
    ```

  * `:spec_name` - to identify the table spec server (string). Defaults to the
    current application name expressed as a string.

  * `:style` - table style (atom). Defaults to `:plain`.

    ```elixir
    style: :plain # default style
    ```

    ```elixir
    style: :dark
    ```
  ## Table styles

  #{Style.texts("  - `&style`&filler - &note\n")}
  """
end
