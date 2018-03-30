# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config

# To allow mix messages in colors...
config :elixir, ansi_enabled: true

# Examples of config to provide when using :io_ansi_table as a dep:
#
#
#     config :io_ansi_table, headers: [
#       "station_id", "observation_time_rfc822", "wind_mph"
#     ]
#
#
#     config :io_ansi_table, header_fixes: %{
#       ~r[ id$]i       => " ID",
#       ~r[ mph$]i      => " MPH",
#       ~r[ rfc(\d+)$]i => " RFC-\\1"
#     }
#
#
#     config :io_ansi_table, align_specs: [
#       center: "station_id", right: "wind_mph"
#     ]
#
#
#     config :io_ansi_table, bell: true
#
#
#     config :io_ansi_table, count: 22
#
#
#     config :io_ansi_table, margins: [
#       top:    1, # line(s) before table (can be negative)
#       bottom: 1, # line(s) after table
#       left:   3  # column(s) left of table
#     ]
#     config :io_ansi_table, margins: [
#       left: 3 # column(s) left of table
#     ]
#
#
#     config :io_ansi_table, max_width: 88
#
#
#     config :io_ansi_table, sort_specs: [
#       "station_id", desc: "wind_mph"
#     ]
#     config :io_ansi_table, sort_specs: [
#       asc: "station_id", desc: "wind_mph"
#     ]
#
#
#     config :io_ansi_table, sort_symbols: [
#       asc: "▲", desc: "▼", pos: :trailing
#     ]
#     config :io_ansi_table, sort_symbols: [
#       asc: "⬆"
#     ]
#     config :io_ansi_table, sort_symbols: [
#       asc: "⬆", desc: "⬇", pos: :leading
#     ]
#     config :io_ansi_table, sort_symbols: [
#       pos: [:leading, :trailing]
#     ]
#
#
#     config :io_ansi_table, style: :light

# Table formatting in colors...
config :io_ansi_table, ansi_enabled: true

# If truthy -> GenServer.cast, otherwise -> GenServer.call...
# config :io_ansi_table, async: true

# Comment out to compile debug, info and warn messages...
config :logger, compile_time_purge_level: :error

# Prevents runtime debug, info and warn messages...
config :logger, level: :error

# Listed by ascending log level...
config :logger, :console,
  colors: [
    debug: :light_cyan,
    info: :light_green,
    warn: :light_yellow,
    error: :light_red
  ]

# config :map_sorter, sorting_on_structs?: true

import_config "persist_colors.exs"
import_config "persist_defaults.exs"
import_config "persist_styles.exs"
import_config "persist_book_ref.exs"
