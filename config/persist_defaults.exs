import Config

config :io_ansi_table, default_bell: false
config :io_ansi_table, default_count: 11

# Default table position...
config :io_ansi_table,
  default_margins: [
    top:    1, # line(s) before table (can be negative)
    bottom: 1, # line(s) after table
    left:   2  # column(s) left of table
  ]

config :io_ansi_table, default_max_width: 99

config :io_ansi_table,
  default_sort_symbols: [asc: "↑", desc: "↓", pos: :trailing]

config :io_ansi_table, default_style: :plain
