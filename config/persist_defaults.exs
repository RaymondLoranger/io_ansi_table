import Config

config :io_ansi_table, default_align_specs: [:undefined]
config :io_ansi_table, default_bell: false
config :io_ansi_table, default_count: 11
config :io_ansi_table, default_headers: [:undefined]

config :io_ansi_table,
  default_header_fixes: %{
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

# Default table position...
config :io_ansi_table,
  default_margins: [
    top:    1, # line(s) before table (can be negative)
    bottom: 1, # line(s) after table
    left:   2  # column(s) left of table
  ]

config :io_ansi_table, default_sort_specs: [:undefined]

config :io_ansi_table,
  default_sort_symbols: [
    asc: "↑", desc: "↓", pos: :trailing
  ]

config :io_ansi_table, default_style: :plain
config :io_ansi_table, max_width_range: 7..99

config :io_ansi_table,
  options: [
    :align_specs,  # to align column elements (list)
    :bell,         # ring the bell? (boolean)
    :count,        # number of `maps` to format (integer)
    :headers,      # to identify each column (list)
    :header_fixes, # to alter the `headers` (map)
    :margins,      # to position the table (keyword)
    :max_width,    # to cap column widths (non_neg_integer)
    :sort_specs,   # to sort the `maps` (list)
    :sort_symbols, # to denote sort direction (keyword)
    :style         # table style (atom)
  ]

config :io_ansi_table,
  row_types: [
    :even_row, :odd_row, :row, :row_1, :row_2, :row_3
  ]

config :io_ansi_table, rule_types: [:top, :separator, :bottom]
