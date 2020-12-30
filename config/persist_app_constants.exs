import Config

config :io_ansi_table, ets_name: IO.ANSI.Table.Ets
config :io_ansi_table, registry: IO.ANSI.Table.Reg

config :io_ansi_table,
  row_types: [:row, :even_row, :odd_row, :row_1, :row_2, :row_3]

config :io_ansi_table, rule_types: [:top, :separator, :bottom]
