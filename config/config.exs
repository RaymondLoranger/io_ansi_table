# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config

# This configuration is loaded before any dependency and is restricted
# to this project. If another project depends on this project, this
# file won't be loaded nor affect the parent project. For this reason,
# if you want to provide default values for your application for
# 3rd-party users, it should be done in your "mix.exs" file.

# You can configure for your application as:
#
#     config :io_ansi_table, key: :value

config :elixir, ansi_enabled: true # mix messages in colors

# Example of headers, header fixes and key headers to provide:
#
#     config :io_ansi_table, headers: [
#       "station_id", "weather", "temperature_string", "wind_mph",
#       "location", "observation_time_rfc822"
#     ]
#
#     config :io_ansi_table, header_fixes: %{
#       ~r[\sid$]i       => "\sID",
#       ~r[\smph$]i      => "\sMPH",
#       ~r[\srfc(\d+)$]i => "\sRFC-\\1"
#     }
#
#     config :io_ansi_table, key_headers: ["temperature_string", "wind_mph"]

# Example to adjust table position (up to 3 ways):
#
#     config :io_ansi_table, margins: [
#       top:    1, # line(s) before table
#       bottom: 1, # line(s) after table
#       left:   2  # space(s) left of table
#     ]
#
# The above margins represent the default table position.

config :io_ansi_table, ansi_enabled: true # table formatting in colors

config :io_ansi_table, default_margins: [ # default table position:
  top:    1, # line(s) before table
  bottom: 1, # line(s) after table
  left:   2  # space(s) left of table
]

config :io_ansi_table, table_styles: %{
  light: %{
    note: "light colors",
    rank: 10,
    line_types: [:top, :header, :separator, [:row], :bottom],
    borders: %{
      #           left  inner  right dash
      top:       {"┌─", "─┬─", "─┐", "─"},
      header:    {"│" ,  "│",   "│", nil},
      separator: {"├─", "─┼─", "─┤", "─"},
      row:       {"│" ,  "│",   "│", nil},
      bottom:    {"└─", "─┴─", "─┘", "─"}
    },
    border_widths: %{
      #           left    inner      right
      top:       {[2, 0], [0, 3, 0], [0, 2]},
      header:    {[1, 1], [1, 1, 1], [1, 1]},
      separator: {[2, 0], [0, 3, 0], [0, 2]},
      row:       {[1, 1], [1, 1, 1], [1, 1]},
      bottom:    {[2, 0], [0, 3, 0], [0, 2]}
    },
    border_attrs: %{
      top:       :light_white,
      header:    :light_white,
      separator: :light_white,
      row:       :light_white,
      bottom:    :light_white
    },
    filler_attrs: %{
      top:       :normal,
      header:    :normal,
      separator: :normal,
      row:       :normal,
      bottom:    :normal
    },
    key_attrs: %{
      top:       :normal,
      header:    [:light_yellow, :underline],
      separator: :normal,
      row:       :light_cyan,
      bottom:    :normal
    },
    non_key_attrs: %{
      top:       :normal,
      header:    :light_yellow,
      separator: :normal,
      row:       :normal,
      bottom:    :normal
    }
  },
  light_alt: %{
    note: "light colors, alternating row colors",
    rank: 15,
    line_types: [:top, :header, :separator, [:even_row, :odd_row], :bottom],
    borders: %{
      #           left  inner  right dash
      top:       {"┌─", "─┬─", "─┐", "─"},
      header:    {"│" ,  "│",   "│", nil},
      separator: {"├─", "─┼─", "─┤", "─"},
      even_row:  {"│" ,  "│",   "│", nil},
      odd_row:   {"│" ,  "│",   "│", nil},
      bottom:    {"└─", "─┴─", "─┘", "─"}
    },
    border_widths: %{
      #           left    inner      right
      top:       {[2, 0], [0, 3, 0], [0, 2]},
      header:    {[1, 1], [1, 1, 1], [1, 1]},
      separator: {[2, 0], [0, 3, 0], [0, 2]},
      even_row:  {[1, 1], [1, 1, 1], [1, 1]},
      odd_row:   {[1, 1], [1, 1, 1], [1, 1]},
      bottom:    {[2, 0], [0, 3, 0], [0, 2]}
    },
    border_attrs: %{
      top:       :light_white,
      header:    :light_white,
      separator: :light_white,
      even_row:  :light_white,
      odd_row:   :light_white,
      bottom:    :light_white
    },
    filler_attrs: %{
      top:       :normal,
      header:    :normal,
      separator: :normal,
      even_row:  :light_blue_background,
      odd_row:   :normal,
      bottom:    :normal
    },
    key_attrs: %{
      top:       :normal,
      header:    [:light_yellow, :underline],
      separator: :normal,
      even_row:  [:light_cyan, :light_blue_background],
      odd_row:   :light_cyan,
      bottom:    :normal
    },
    non_key_attrs: %{
      top:       :normal,
      header:    :light_yellow,
      separator: :normal,
      even_row:  [:normal, :light_blue_background],
      odd_row:   :normal,
      bottom:    :normal
    }
  },
  medium: %{
    note: "medium colors",
    rank: 20,
    line_types: [:top, :header, :separator, [:row], :bottom],
    borders: %{
      #           left  inner  right dash
      top:       {"╔═", "═╤═", "═╗", "═"},
      header:    {"║",   "│" ,  "║", nil},
      separator: {"╟─", "─┼─", "─╢", "─"},
      row:       {"║" ,  "│" ,  "║", nil},
      bottom:    {"╚═", "═╧═", "═╝", "═"}
    },
    border_widths: %{
      #           left    inner      right
      top:       {[2, 0], [0, 3, 0], [0, 2]},
      header:    {[1, 1], [1, 1, 1], [1, 1]},
      separator: {[2, 0], [0, 3, 0], [0, 2]},
      row:       {[1, 1], [1, 1, 1], [1, 1]},
      bottom:    {[2, 0], [0, 3, 0], [0, 2]}
    },
    border_attrs: %{
      top:       :light_yellow,
      header:    :light_yellow,
      separator: :light_yellow,
      row:       :light_yellow,
      bottom:    :light_yellow
    },
    filler_attrs: %{
      top:       :normal,
      header:    :normal,
      separator: :normal,
      row:       :normal,
      bottom:    :normal
    },
    key_attrs: %{
      top:       :light_yellow,
      header:    [:light_green, :underline],
      separator: :light_yellow,
      row:       :light_cyan,
      bottom:    :light_yellow
    },
    non_key_attrs: %{
      top:       :light_yellow,
      header:    :light_green,
      separator: :light_yellow,
      row:       :light_yellow,
      bottom:    :light_yellow
    }
  },
  medium_alt: %{
    note: "medium colors, alternating row colors",
    rank: 25,
    line_types: [:top, :header, :separator, [:even_row, :odd_row], :bottom],
    borders: %{
      #           left  inner  right dash
      top:       {"╔═", "═╤═", "═╗", "═"},
      header:    {"║",   "│" ,  "║", nil},
      separator: {"╟─", "─┼─", "─╢", "─"},
      even_row:  {"║" ,  "│" ,  "║", nil},
      odd_row:   {"║" ,  "│" ,  "║", nil},
      bottom:    {"╚═", "═╧═", "═╝", "═"}
    },
    border_widths: %{
      #           left    inner      right
      top:       {[2, 0], [0, 3, 0], [0, 2]},
      header:    {[1, 1], [1, 1, 1], [1, 1]},
      separator: {[2, 0], [0, 3, 0], [0, 2]},
      even_row:  {[1, 1], [1, 1, 1], [1, 1]},
      odd_row:   {[1, 1], [1, 1, 1], [1, 1]},
      bottom:    {[2, 0], [0, 3, 0], [0, 2]}
    },
    border_attrs: %{
      top:       :light_yellow,
      header:    :light_yellow,
      separator: :light_yellow,
      even_row:  :light_yellow,
      odd_row:   :light_yellow,
      bottom:    :light_yellow
    },
    filler_attrs: %{
      top:       :normal,
      header:    :normal,
      separator: :normal,
      even_row:  :light_blue_background,
      odd_row:   :normal,
      bottom:    :normal
    },
    key_attrs: %{
      top:       :light_yellow,
      header:    [:light_green, :underline],
      separator: :light_yellow,
      even_row:  [:light_cyan, :light_blue_background],
      odd_row:   :light_cyan,
      bottom:    :light_yellow
    },
    non_key_attrs: %{
      top:       :light_yellow,
      header:    :light_green,
      separator: :light_yellow,
      even_row:  [:light_yellow, :light_blue_background],
      odd_row:   :light_yellow,
      bottom:    :light_yellow
    }
  },
  dark: %{
    note: "dark colors",
    rank: 30,
    line_types: [:top, :header, :separator, [:row], :bottom],
    borders: %{
      #           left  inner  right dash
      top:       {"╔═", "═╦═", "═╗", "═"},
      header:    {"║" ,  "║" ,  "║", nil},
      separator: {"╠═", "═╬═", "═╣", "═"},
      row:       {"║" ,  "║" ,  "║", nil},
      bottom:    {"╚═", "═╩═", "═╝", "═"}
    },
    border_widths: %{
      #           left    inner      right
      top:       {[2, 0], [0, 3, 0], [0, 2]},
      header:    {[1, 1], [1, 1, 1], [1, 1]},
      separator: {[2, 0], [0, 3, 0], [0, 2]},
      row:       {[1, 1], [1, 1, 1], [1, 1]},
      bottom:    {[2, 0], [0, 3, 0], [0, 2]}
    },
    border_attrs: %{
      top:       :light_green,
      header:    :light_green,
      separator: :light_green,
      row:       :light_green,
      bottom:    :light_green
    },
    filler_attrs: %{
      top:       :normal,
      header:    :normal,
      separator: :normal,
      row:       :normal,
      bottom:    :normal
    },
    key_attrs: %{
      top:       :light_green,
      header:    [:light_white, :light_red_background],
      separator: :light_green,
      row:       :light_magenta,
      bottom:    :light_green
    },
    non_key_attrs: %{
      top:       :light_green,
      header:    :light_red,
      separator: :light_green,
      row:       :light_green,
      bottom:    :light_green
    }
  },
  dark_alt: %{
    note: "dark colors, alternating row colors",
    rank: 35,
    line_types: [:top, :header, :separator, [:even_row, :odd_row], :bottom],
    borders: %{
      #           left  inner  right dash
      top:       {"╔═", "═╦═", "═╗", "═"},
      header:    {"║" ,  "║" ,  "║", nil},
      separator: {"╠═", "═╬═", "═╣", "═"},
      even_row:  {"║" ,  "║" ,  "║", nil},
      odd_row:   {"║" ,  "║" ,  "║", nil},
      bottom:    {"╚═", "═╩═", "═╝", "═"}
    },
    border_widths: %{
      #           left    inner      right
      top:       {[2, 0], [0, 3, 0], [0, 2]},
      header:    {[1, 1], [1, 1, 1], [1, 1]},
      separator: {[2, 0], [0, 3, 0], [0, 2]},
      even_row:  {[1, 1], [1, 1, 1], [1, 1]},
      odd_row:   {[1, 1], [1, 1, 1], [1, 1]},
      bottom:    {[2, 0], [0, 3, 0], [0, 2]}
    },
    border_attrs: %{
      top:       :light_green,
      header:    :light_green,
      separator: :light_green,
      even_row:  :light_green,
      odd_row:   :light_green,
      bottom:    :light_green
    },
    filler_attrs: %{
      top:       :normal,
      header:    :normal,
      separator: :normal,
      even_row:  :light_blue_background,
      odd_row:   :normal,
      bottom:    :normal
    },
    key_attrs: %{
      top:       :light_green,
      header:    [:light_white, :light_red_background],
      separator: :light_green,
      even_row:  [:light_magenta, :light_blue_background],
      odd_row:   :light_magenta,
      bottom:    :light_green
    },
    non_key_attrs: %{
      top:       :light_green,
      header:    :light_red,
      separator: :light_green,
      even_row:  [:light_green, :light_blue_background],
      odd_row:   :light_green,
      bottom:    :light_green
    }
  },
  pretty: %{
    note: "multicolored",
    rank: 40,
    line_types: [:top, :header, :separator, [:row], :bottom],
    borders: %{
      #           left  inner  right dash
      top:       {"╔═", "═╦═", "═╗", "═"},
      header:    {"║" ,  "║" ,  "║", nil},
      separator: {"╠═", "═╬═", "═╣", "═"},
      row:       {"║" ,  "║" ,  "║", nil},
      bottom:    {"╚═", "═╩═", "═╝", "═"}
    },
    border_widths: %{
      #           left    inner      right
      top:       {[2, 0], [0, 3, 0], [0, 2]},
      header:    {[1, 1], [1, 1, 1], [1, 1]},
      separator: {[2, 0], [0, 3, 0], [0, 2]},
      row:       {[1, 1], [1, 1, 1], [1, 1]},
      bottom:    {[2, 0], [0, 3, 0], [0, 2]}
    },
    border_attrs: %{
      top:       :light_magenta,
      header:    :light_magenta,
      separator: :light_magenta,
      row:       :light_magenta,
      bottom:    :light_magenta
    },
    filler_attrs: %{
      top:       :normal,
      header:    :normal,
      separator: :normal,
      row:       :normal,
      bottom:    :normal
    },
    key_attrs: %{
      top:       :light_magenta,
      header:    [:light_green, :underline],
      separator: :light_magenta,
      row:       :light_cyan,
      bottom:    :light_magenta
    },
    non_key_attrs: %{
      top:       :light_magenta,
      header:    :light_green,
      separator: :light_magenta,
      row:       :light_yellow,
      bottom:    :light_magenta
    }
  },
  pretty_alt: %{
    note: "multicolored, alternating row colors",
    rank: 45,
    line_types: [:top, :header, :separator, [:even_row, :odd_row], :bottom],
    borders: %{
      #           left  inner  right dash
      top:       {"╔═", "═╦═", "═╗", "═"},
      header:    {"║" ,  "║" ,  "║", nil},
      separator: {"╠═", "═╬═", "═╣", "═"},
      even_row:  {"║" ,  "║" ,  "║", nil},
      odd_row:   {"║" ,  "║" ,  "║", nil},
      bottom:    {"╚═", "═╩═", "═╝", "═"}
    },
    border_widths: %{
      #           left    inner      right
      top:       {[2, 0], [0, 3, 0], [0, 2]},
      header:    {[1, 1], [1, 1, 1], [1, 1]},
      separator: {[2, 0], [0, 3, 0], [0, 2]},
      even_row:  {[1, 1], [1, 1, 1], [1, 1]},
      odd_row:   {[1, 1], [1, 1, 1], [1, 1]},
      bottom:    {[2, 0], [0, 3, 0], [0, 2]}
    },
    border_attrs: %{
      top:       :light_magenta,
      header:    :light_magenta,
      separator: :light_magenta,
      even_row:  :light_magenta,
      odd_row:   :light_magenta,
      bottom:    :light_magenta
    },
    filler_attrs: %{
      top:       :normal,
      header:    :normal,
      separator: :normal,
      even_row:  :light_blue_background,
      odd_row:   :normal,
      bottom:    :normal
    },
    key_attrs: %{
      top:       :light_magenta,
      header:    [:light_green, :underline],
      separator: :light_magenta,
      even_row:  [:light_cyan, :light_blue_background],
      odd_row:   :light_cyan,
      bottom:    :light_magenta
    },
    non_key_attrs: %{
      top:       :light_magenta,
      header:    :light_green,
      separator: :light_magenta,
      even_row:  [:light_yellow, :light_blue_background],
      odd_row:   :light_yellow,
      bottom:    :light_magenta
    }
  },
  cyan: %{
    note: "light cyan background",
    rank: 50,
    line_types: [:top, :header, :separator, [:row], :bottom],
    borders: %{
      #           left  inner  right dash
      top:       {"╔═", "═╦═", "═╗", "═"},
      header:    {"║" ,  "║" ,  "║", nil},
      separator: {"╠═", "═╬═", "═╣", "═"},
      row:       {"║" ,  "║" ,  "║", nil},
      bottom:    {"╚═", "═╩═", "═╝", "═"}
    },
    border_widths: %{
      #           left    inner      right
      top:       {[2, 0], [0, 3, 0], [0, 2]},
      header:    {[1, 1], [1, 1, 1], [1, 1]},
      separator: {[2, 0], [0, 3, 0], [0, 2]},
      row:       {[1, 1], [1, 1, 1], [1, 1]},
      bottom:    {[2, 0], [0, 3, 0], [0, 2]}
    },
    border_attrs: %{
      top:       [:light_blue, :light_cyan_background],
      header:    [:light_blue, :light_cyan_background],
      separator: [:light_blue, :light_cyan_background],
      row:       [:light_blue, :light_cyan_background],
      bottom:    [:light_blue, :light_cyan_background]
    },
    filler_attrs: %{
      top:       :light_cyan_background,
      header:    :light_cyan_background,
      separator: :light_cyan_background,
      row:       :light_cyan_background,
      bottom:    :light_cyan_background
    },
    key_attrs: %{
      top:       [:light_blue, :light_cyan_background],
      header:    [:light_yellow, :light_red_background],
      separator: [:light_blue, :light_cyan_background],
      row:       [:light_blue, :light_cyan_background],
      bottom:    [:light_blue, :light_cyan_background]
    },
    non_key_attrs: %{
      top:       [:light_blue, :light_cyan_background],
      header:    [:light_red, :light_cyan_background],
      separator: [:light_blue, :light_cyan_background],
      row:       [:black, :light_cyan_background],
      bottom:    [:light_blue, :light_cyan_background]
    }
  },
  yellow: %{
    note: "light yellow background",
    rank: 60,
    line_types: [:top, :header, :separator, [:row], :bottom],
    borders: %{
      #           left  inner  right dash
      top:       {"╔═", "═╦═", "═╗", "═"},
      header:    {"║" ,  "║" ,  "║", nil},
      separator: {"╠═", "═╬═", "═╣", "═"},
      row:       {"║" ,  "║" ,  "║", nil},
      bottom:    {"╚═", "═╩═", "═╝", "═"}
    },
    border_widths: %{
      #           left    inner      right
      top:       {[2, 0], [0, 3, 0], [0, 2]},
      header:    {[1, 1], [1, 1, 1], [1, 1]},
      separator: {[2, 0], [0, 3, 0], [0, 2]},
      row:       {[1, 1], [1, 1, 1], [1, 1]},
      bottom:    {[2, 0], [0, 3, 0], [0, 2]}
    },
    border_attrs: %{
      top:       [:green, :light_yellow_background],
      header:    [:green, :light_yellow_background],
      separator: [:green, :light_yellow_background],
      row:       [:green, :light_yellow_background],
      bottom:    [:green, :light_yellow_background]
    },
    filler_attrs: %{
      top:       :light_yellow_background,
      header:    :light_yellow_background,
      separator: :light_yellow_background,
      row:       :light_yellow_background,
      bottom:    :light_yellow_background
    },
    key_attrs: %{
      top:       [:green, :light_yellow_background],
      header:    [:light_white, :light_red_background],
      separator: [:green, :light_yellow_background],
      row:       [:light_blue, :light_yellow_background],
      bottom:    [:green, :light_yellow_background]
    },
    non_key_attrs: %{
      top:       [:green, :light_yellow_background],
      header:    [:light_red, :light_yellow_background],
      separator: [:green, :light_yellow_background],
      row:       [:black, :light_yellow_background],
      bottom:    [:green, :light_yellow_background]
    }
  },
  green: %{
    note: "light green background",
    rank: 70,
    line_types: [:top, :header, :separator, [:row], :bottom],
    borders: %{
      #           left  inner  right dash
      top:       {"╔═", "═╦═", "═╗", "═"},
      header:    {"║" ,  "║" ,  "║", nil},
      separator: {"╠═", "═╬═", "═╣", "═"},
      row:       {"║" ,  "║" ,  "║", nil},
      bottom:    {"╚═", "═╩═", "═╝", "═"}
    },
    border_widths: %{
      #           left    inner      right
      top:       {[2, 0], [0, 3, 0], [0, 2]},
      header:    {[1, 1], [1, 1, 1], [1, 1]},
      separator: {[2, 0], [0, 3, 0], [0, 2]},
      row:       {[1, 1], [1, 1, 1], [1, 1]},
      bottom:    {[2, 0], [0, 3, 0], [0, 2]}
    },
    border_attrs: %{
      top:       [:light_yellow, :light_green_background],
      header:    [:light_yellow, :light_green_background],
      separator: [:light_yellow, :light_green_background],
      row:       [:light_yellow, :light_green_background],
      bottom:    [:light_yellow, :light_green_background]
    },
    filler_attrs: %{
      top:       :light_green_background,
      header:    :light_green_background,
      separator: :light_green_background,
      row:       :light_green_background,
      bottom:    :light_green_background
    },
    key_attrs: %{
      top:       [:light_yellow, :light_green_background],
      header:    [:light_yellow, :light_red_background],
      separator: [:light_yellow, :light_green_background],
      row:       [:light_blue, :light_green_background],
      bottom:    [:light_yellow, :light_green_background]
    },
    non_key_attrs: %{
      top:       [:light_yellow, :light_green_background],
      header:    [:light_red, :light_green_background],
      separator: [:light_yellow, :light_green_background],
      row:       [:black, :light_green_background],
      bottom:    [:light_yellow, :light_green_background]
    }
  },
  CYAN: %{
    note: "light cyan border",
    rank: 80,
    line_types: [:top, :header, :separator, [:row], :bottom],
    borders: %{
      #           left  inner  right dash
      top:       {"╔═", "═╦═", "═╗", "═"},
      header:    {"║" ,  "║" ,  "║", nil},
      separator: {"╠═", "═╬═", "═╣", "═"},
      row:       {"║" ,  "║" ,  "║", nil},
      bottom:    {"╚═", "═╩═", "═╝", "═"}
    },
    border_widths: %{
      #           left    inner      right
      top:       {[2, 0], [0, 3, 0], [0, 2]},
      header:    {[1, 1], [1, 1, 1], [1, 1]},
      separator: {[2, 0], [0, 3, 0], [0, 2]},
      row:       {[1, 1], [1, 1, 1], [1, 1]},
      bottom:    {[2, 0], [0, 3, 0], [0, 2]}
    },
    border_attrs: %{
      top:       [:light_cyan, :light_cyan_background],
      header:    [:light_cyan, :light_cyan_background],
      separator: [:light_cyan, :light_cyan_background],
      row:       [:light_cyan, :light_cyan_background],
      bottom:    [:light_cyan, :light_cyan_background]
    },
    filler_attrs: %{
      top:       :normal,
      header:    :normal,
      separator: :normal,
      row:       :normal,
      bottom:    :normal
    },
    key_attrs: %{
      top:       [:light_cyan, :light_cyan_background],
      header:    :light_red,
      separator: [:light_cyan, :light_cyan_background],
      row:       :light_cyan,
      bottom:    [:light_cyan, :light_cyan_background]
    },
    non_key_attrs: %{
      top:       [:light_cyan, :light_cyan_background],
      header:    :light_magenta,
      separator: [:light_cyan, :light_cyan_background],
      row:       :normal,
      bottom:    [:light_cyan, :light_cyan_background]
    }
  },
  YELLOW: %{
    note: "light yellow border",
    rank: 90,
    line_types: [:top, :header, :separator, [:row], :bottom],
    borders: %{
      #           left  inner  right dash
      top:       {"╔═", "═╦═", "═╗", "═"},
      header:    {"║" ,  "║" ,  "║", nil},
      separator: {"╠═", "═╬═", "═╣", "═"},
      row:       {"║" ,  "║" ,  "║", nil},
      bottom:    {"╚═", "═╩═", "═╝", "═"}
    },
    border_widths: %{
      #           left    inner      right
      top:       {[2, 0], [0, 3, 0], [0, 2]},
      header:    {[1, 1], [1, 1, 1], [1, 1]},
      separator: {[2, 0], [0, 3, 0], [0, 2]},
      row:       {[1, 1], [1, 1, 1], [1, 1]},
      bottom:    {[2, 0], [0, 3, 0], [0, 2]}
    },
    border_attrs: %{
      top:       [:light_yellow, :light_yellow_background],
      header:    [:light_yellow, :light_yellow_background],
      separator: [:light_yellow, :light_yellow_background],
      row:       [:light_yellow, :light_yellow_background],
      bottom:    [:light_yellow, :light_yellow_background]
    },
    filler_attrs: %{
      top:       :normal,
      header:    :normal,
      separator: :normal,
      row:       :normal,
      bottom:    :normal
    },
    key_attrs: %{
      top:       [:light_yellow, :light_yellow_background],
      header:    :light_red,
      separator: [:light_yellow, :light_yellow_background],
      row:       :light_yellow,
      bottom:    [:light_yellow, :light_yellow_background]
    },
    non_key_attrs: %{
      top:       [:light_yellow, :light_yellow_background],
      header:    :light_magenta,
      separator: [:light_yellow, :light_yellow_background],
      row:       :normal,
      bottom:    [:light_yellow, :light_yellow_background]
    }
  },
  GREEN: %{
    note: "light green border",
    rank: 100,
    line_types: [:top, :header, :separator, [:row], :bottom],
    borders: %{
      #           left  inner  right dash
      top:       {"╔═", "═╦═", "═╗", "═"},
      header:    {"║" ,  "║" ,  "║", nil},
      separator: {"╠═", "═╬═", "═╣", "═"},
      row:       {"║" ,  "║" ,  "║", nil},
      bottom:    {"╚═", "═╩═", "═╝", "═"}
    },
    border_widths: %{
      #           left    inner      right
      top:       {[2, 0], [0, 3, 0], [0, 2]},
      header:    {[1, 1], [1, 1, 1], [1, 1]},
      separator: {[2, 0], [0, 3, 0], [0, 2]},
      row:       {[1, 1], [1, 1, 1], [1, 1]},
      bottom:    {[2, 0], [0, 3, 0], [0, 2]}
    },
    border_attrs: %{
      top:       [:light_green, :light_green_background],
      header:    [:light_green, :light_green_background],
      separator: [:light_green, :light_green_background],
      row:       [:light_green, :light_green_background],
      bottom:    [:light_green, :light_green_background]
    },
    filler_attrs: %{
      top:       :normal,
      header:    :normal,
      separator: :normal,
      row:       :normal,
      bottom:    :normal
    },
    key_attrs: %{
      top:       [:light_green, :light_green_background],
      header:    :light_red,
      separator: [:light_green, :light_green_background],
      row:       :light_green,
      bottom:    [:light_green, :light_green_background]
    },
    non_key_attrs: %{
      top:       [:light_green, :light_green_background],
      header:    :light_magenta,
      separator: [:light_green, :light_green_background],
      row:       :normal,
      bottom:    [:light_green, :light_green_background]
    }
  },
  mixed: %{
    note: "fillers revealed",
    rank: 110,
    line_types: [:top, :header, :separator, [:row], :bottom],
    borders: %{
      #           left  inner  right dash
      top:       {"╔═", "═╦═", "═╗", "═"},
      header:    {"║" ,  "║" ,  "║", nil},
      separator: {"╠═", "═╬═", "═╣", "═"},
      row:       {"║" ,  "║" ,  "║", nil},
      bottom:    {"╚═", "═╩═", "═╝", "═"}
    },
    border_widths: %{
      #           left    inner      right
      top:       {[2, 0], [0, 3, 0], [0, 2]},
      header:    {[1, 1], [1, 1, 1], [1, 1]},
      separator: {[2, 0], [0, 3, 0], [0, 2]},
      row:       {[1, 1], [1, 1, 1], [1, 1]},
      bottom:    {[2, 0], [0, 3, 0], [0, 2]}
    },
    border_attrs: %{
      top:       [:black, :light_yellow_background],
      header:    [:black, :light_yellow_background],
      separator: [:black, :light_yellow_background],
      row:       [:black, :light_yellow_background],
      bottom:    [:black, :light_yellow_background]
    },
    filler_attrs: %{
      top:       :light_green_background,
      header:    :light_green_background,
      separator: :light_green_background,
      row:       :light_green_background,
      bottom:    :light_green_background
    },
    key_attrs: %{
      top:       [:black, :light_yellow_background],
      header:    [:light_red, :reverse, :light_yellow_background],
      separator: [:black, :light_yellow_background],
      row:       [:light_blue, :light_yellow_background],
      bottom:    [:black, :light_yellow_background]
    },
    non_key_attrs: %{
      top:       [:black, :light_yellow_background],
      header:    [:light_magenta, :light_white_background],
      separator: [:black, :light_yellow_background],
      row:       [:light_black, :light_yellow_background],
      bottom:    [:black, :light_yellow_background]
    }
  },
  dotted: %{
    note: "slightly colored",
    rank: 120,
    line_types: [:top, :header, :separator, [:row], :bottom],
    borders: %{
      #           left  inner  right dash
      top:       {"┏╍", "╍┳╍", "╍┓", "╍"},
      header:    {"┇" ,  "┇" ,  "┇", nil},
      separator: {"┣╍", "╍╋╍", "╍┫", "╍"},
      row:       {"┇" ,  "┇" ,  "┇", nil},
      bottom:    {"┗╍", "╍┻╍", "╍┛", "╍"}
    },
    border_widths: %{
      #           left    inner      right
      top:       {[2, 0], [0, 3, 0], [0, 2]},
      header:    {[1, 1], [1, 1, 1], [1, 1]},
      separator: {[2, 0], [0, 3, 0], [0, 2]},
      row:       {[1, 1], [1, 1, 1], [1, 1]},
      bottom:    {[2, 0], [0, 3, 0], [0, 2]}
    },
    border_attrs: %{
      top:       :normal,
      header:    :normal,
      separator: :normal,
      row:       :normal,
      bottom:    :normal
    },
    filler_attrs: %{
      top:       :normal,
      header:    :normal,
      separator: :normal,
      row:       :normal,
      bottom:    :normal
    },
    key_attrs: %{
      top:       :normal,
      header:    [:blue, :light_yellow_background],
      separator: :normal,
      row:       :light_yellow,
      bottom:    :normal
    },
    non_key_attrs: %{
      top:       :normal,
      header:    :normal,
      separator: :normal,
      row:       :normal,
      bottom:    :normal
    }
  },
  dotted_alt: %{
    note: "slightly colored, alternating row colors",
    rank: 125,
    line_types: [:top, :header, :separator, [:even_row, :odd_row], :bottom],
    borders: %{
      #           left  inner  right dash
      top:       {"┏╍", "╍┳╍", "╍┓", "╍"},
      header:    {"┇" ,  "┇" ,  "┇", nil},
      separator: {"┣╍", "╍╋╍", "╍┫", "╍"},
      even_row:  {"┇" ,  "┇" ,  "┇", nil},
      odd_row:   {"┇" ,  "┇" ,  "┇", nil},
      bottom:    {"┗╍", "╍┻╍", "╍┛", "╍"}
    },
    border_widths: %{
      #           left    inner      right
      top:       {[2, 0], [0, 3, 0], [0, 2]},
      header:    {[1, 1], [1, 1, 1], [1, 1]},
      separator: {[2, 0], [0, 3, 0], [0, 2]},
      even_row:  {[1, 1], [1, 1, 1], [1, 1]},
      odd_row:   {[1, 1], [1, 1, 1], [1, 1]},
      bottom:    {[2, 0], [0, 3, 0], [0, 2]}
    },
    border_attrs: %{
      top:       :normal,
      header:    :normal,
      separator: :normal,
      even_row:  :normal,
      odd_row:   :normal,
      bottom:    :normal
    },
    filler_attrs: %{
      top:       :normal,
      header:    :normal,
      separator: :normal,
      even_row:  :light_blue_background,
      odd_row:   :normal,
      bottom:    :normal
    },
    key_attrs: %{
      top:       :normal,
      header:    [:blue, :light_yellow_background],
      separator: :normal,
      even_row:  [:light_yellow, :light_blue_background],
      odd_row:   :light_yellow,
      bottom:    :normal
    },
    non_key_attrs: %{
      top:       :normal,
      header:    :normal,
      separator: :normal,
      even_row:  [:normal, :light_blue_background],
      odd_row:   :normal,
      bottom:    :normal
    }
  },
  dashed: %{
    note: "no colors",
    rank: 130,
    line_types: [:top, :header, :separator, [:row], :bottom],
    borders: %{
      #           left  inner  right dash
      top:       {"+-", "-+-", "-+", "-"},
      header:    {"|" ,  "|" ,  "|", nil},
      separator: {"+-", "-+-", "-+", "-"},
      row:       {"|" ,  "|" ,  "|", nil},
      bottom:    {"+-", "-+-", "-+", "-"}
    },
    border_widths: %{
      #           left    inner      right
      top:       {[2, 0], [0, 3, 0], [0, 2]},
      header:    {[1, 1], [1, 1, 1], [1, 1]},
      separator: {[2, 0], [0, 3, 0], [0, 2]},
      row:       {[1, 1], [1, 1, 1], [1, 1]},
      bottom:    {[2, 0], [0, 3, 0], [0, 2]}
    },
    border_attrs: %{
      top:       :normal,
      header:    :normal,
      separator: :normal,
      row:       :normal,
      bottom:    :normal
    },
    filler_attrs: %{
      top:       :normal,
      header:    :normal,
      separator: :normal,
      row:       :normal,
      bottom:    :normal
    },
    key_attrs: %{
      top:       :normal,
      header:    :normal,
      separator: :normal,
      row:       :normal,
      bottom:    :normal
    },
    non_key_attrs: %{
      top:       :normal,
      header:    :normal,
      separator: :normal,
      row:       :normal,
      bottom:    :normal
    }
  },
  plain: %{
    note: "slightly colored",
    rank: 140,
    line_types: [:top, :header, :separator, [:row], :bottom],
    borders: %{
      #           left  inner  right dash
      top:       {"┌─", "─┬─", "─┐", "─"},
      header:    {"│" ,  "│" ,  "│", nil},
      separator: {"├─", "─┼─", "─┤", "─"},
      row:       {"│" ,  "│" ,  "│", nil},
      bottom:    {"└─", "─┴─", "─┘", "─"}
    },
    border_widths: %{
      #           left    inner      right
      top:       {[2, 0], [0, 3, 0], [0, 2]},
      header:    {[1, 1], [1, 1, 1], [1, 1]},
      separator: {[2, 0], [0, 3, 0], [0, 2]},
      row:       {[1, 1], [1, 1, 1], [1, 1]},
      bottom:    {[2, 0], [0, 3, 0], [0, 2]}
    },
    border_attrs: %{
      top:       :light_yellow,
      header:    :light_yellow,
      separator: :light_yellow,
      row:       :light_yellow,
      bottom:    :light_yellow
    },
    filler_attrs: %{
      top:       :normal,
      header:    :normal,
      separator: :normal,
      row:       :normal,
      bottom:    :normal
    },
    key_attrs: %{
      top:       :light_yellow,
      header:    [:light_yellow, :underline],
      separator: :light_yellow,
      row:       :light_yellow,
      bottom:    :light_yellow
    },
    non_key_attrs: %{
      top:       :light_yellow,
      header:    :light_yellow,
      separator: :light_yellow,
      row:       :normal,
      bottom:    :light_yellow
    }
  },
  test: %{
    note: "no colors",
    rank: 150,
    line_types: [:top, :header, :separator, [:row], :bottom],
    borders: %{
      #           left  inner  right dash
      top:       {"┌─", "─┬─", "─┐", "─"},
      header:    {"│" ,  "│" ,  "│", nil},
      separator: {"├─", "─┼─", "─┤", "─"},
      row:       {"│" ,  "│" ,  "│", nil},
      bottom:    {"└─", "─┴─", "─┘", "─"}
    },
    border_widths: %{
      #           left    inner      right
      top:       {[2, 0], [0, 3, 0], [0, 2]},
      header:    {[1, 1], [1, 1, 1], [1, 1]},
      separator: {[2, 0], [0, 3, 0], [0, 2]},
      row:       {[1, 1], [1, 1, 1], [1, 1]},
      bottom:    {[2, 0], [0, 3, 0], [0, 2]}
    },
    border_attrs: %{
      top:       :normal,
      header:    :normal,
      separator: :normal,
      row:       :normal,
      bottom:    :normal
    },
    filler_attrs: %{
      top:       :normal,
      header:    :normal,
      separator: :normal,
      row:       :normal,
      bottom:    :normal
    },
    key_attrs: %{
      top:       :normal,
      header:    :normal,
      separator: :normal,
      row:       :normal,
      bottom:    :normal
    },
    non_key_attrs: %{
      top:       :normal,
      header:    :normal,
      separator: :normal,
      row:       :normal,
      bottom:    :normal
    }
  },
  bare: %{
    note: "no colors",
    rank: 160,
    line_types: [:header, :separator, [:row]],
    borders: %{
      #           left inner  right dash
      top:       {"",   ""  , "",   "" },
      header:    {"",   "|" , "",   nil},
      separator: {"",  "-+-", "",   "-"},
      row:       {"",   "|" , "",   nil},
      bottom:    {"",   ""  , "",   "" }
    },
    border_widths: %{
      #           left    inner      right
      top:       {[0, 0], [0, 0, 0], [0, 0]},
      header:    {[0, 0], [1, 1, 1], [0, 0]},
      separator: {[0, 0], [0, 3, 0], [0, 0]},
      row:       {[0, 0], [1, 1, 1], [0, 0]},
      bottom:    {[0, 0], [0, 0, 0], [0, 0]}
    },
    border_attrs: %{
      top:       :normal,
      header:    :normal,
      separator: :normal,
      row:       :normal,
      bottom:    :normal
    },
    filler_attrs: %{
      top:       :normal,
      header:    :normal,
      separator: :normal,
      row:       :normal,
      bottom:    :normal
    },
    key_attrs: %{
      top:       :normal,
      header:    :normal,
      separator: :normal,
      row:       :normal,
      bottom:    :normal
    },
    non_key_attrs: %{
      top:       :normal,
      header:    :normal,
      separator: :normal,
      row:       :normal,
      bottom:    :normal
    }
  },
  barish: %{
    note: "like bare but colored",
    rank: 170,
    line_types: [:header, :separator, [:row]],
    borders: %{
      #           left inner  right dash
      top:       {"",   ""  , "",   "" },
      header:    {"",   "|" , "",   nil},
      separator: {"",  "-+-", "",   "-"},
      row:       {"",   "|" , "",   nil},
      bottom:    {"",   ""  , "",   "" }
    },
    border_widths: %{
      #           left    inner      right
      top:       {[0, 0], [0, 0, 0], [0, 0]},
      header:    {[0, 0], [1, 1, 1], [0, 0]},
      separator: {[0, 0], [0, 3, 0], [0, 0]},
      row:       {[0, 0], [1, 1, 1], [0, 0]},
      bottom:    {[0, 0], [0, 0, 0], [0, 0]}
    },
    border_attrs: %{
      top:       :light_yellow,
      header:    :light_yellow,
      separator: :light_yellow,
      row:       :light_yellow,
      bottom:    :light_yellow
    },
    filler_attrs: %{
      top:       :normal,
      header:    :normal,
      separator: :normal,
      row:       :normal,
      bottom:    :normal
    },
    key_attrs: %{
      top:       :light_yellow,
      header:    :light_green,
      separator: :light_yellow,
      row:       :light_cyan,
      bottom:    :light_yellow
    },
    non_key_attrs: %{
      top:       :light_yellow,
      header:    :normal,
      separator: :light_yellow,
      row:       :normal,
      bottom:    :light_yellow
    }
  },
  green_padded: %{
    note: "like green but with extra padding",
    rank: 180,
    line_types: [:top, :header, :separator, [:row], :bottom],
    borders: %{
      #           left   inner    right  dash
      top:       {"╔══", "══╦══", "══╗", "═"},
      header:    {"║"  ,   "║"  ,   "║", nil},
      separator: {"╠══", "══╬══", "══╣", "═"},
      row:       {"║"  ,   "║"  ,   "║", nil},
      bottom:    {"╚══", "══╩══", "══╝", "═"}
    },
    border_widths: %{
      #           left    inner      right
      top:       {[3, 0], [0, 5, 0], [0, 3]},
      header:    {[1, 2], [2, 1, 2], [2, 1]},
      separator: {[3, 0], [0, 5, 0], [0, 3]},
      row:       {[1, 2], [2, 1, 2], [2, 1]},
      bottom:    {[3, 0], [0, 5, 0], [0, 3]}
    },
    border_attrs: %{
      top:       [:light_yellow, :light_green_background],
      header:    [:light_yellow, :light_green_background],
      separator: [:light_yellow, :light_green_background],
      row:       [:light_yellow, :light_green_background],
      bottom:    [:light_yellow, :light_green_background]
    },
    filler_attrs: %{
      top:       :light_green_background,
      header:    :light_green_background,
      separator: :light_green_background,
      row:       :light_green_background,
      bottom:    :light_green_background
    },
    key_attrs: %{
      top:       [:light_yellow, :light_green_background],
      header:    [:light_yellow, :light_red_background],
      separator: [:light_yellow, :light_green_background],
      row:       [:light_blue, :light_green_background],
      bottom:    [:light_yellow, :light_green_background]
    },
    non_key_attrs: %{
      top:       [:light_yellow, :light_green_background],
      header:    [:light_red, :light_green_background],
      separator: [:light_yellow, :light_green_background],
      row:       [:black, :light_green_background],
      bottom:    [:light_yellow, :light_green_background]
    }
  },
  green_unpadded: %{
    note: "like green but without padding",
    rank: 190,
    line_types: [:top, :header, :separator, [:row], :bottom],
    borders: %{
      #           left inner right dash
      top:       {"╔", "╦",  "╗",  "═"},
      header:    {"║", "║",  "║",  nil},
      separator: {"╠", "╬",  "╣",  "═"},
      row:       {"║", "║",  "║",  nil},
      bottom:    {"╚", "╩",  "╝",  "═"}
    },
    border_widths: %{
      #           left    inner      right
      top:       {[1, 0], [0, 1, 0], [0, 1]},
      header:    {[1, 0], [0, 1, 0], [0, 1]},
      separator: {[1, 0], [0, 1, 0], [0, 1]},
      row:       {[1, 0], [0, 1, 0], [0, 1]},
      bottom:    {[1, 0], [0, 1, 0], [0, 1]}
    },
    border_attrs: %{
      top:       [:light_yellow, :light_green_background],
      header:    [:light_yellow, :light_green_background],
      separator: [:light_yellow, :light_green_background],
      row:       [:light_yellow, :light_green_background],
      bottom:    [:light_yellow, :light_green_background]
    },
    filler_attrs: %{
      top:       :light_green_background,
      header:    :light_green_background,
      separator: :light_green_background,
      row:       :light_green_background,
      bottom:    :light_green_background
    },
    key_attrs: %{
      top:       [:light_yellow, :light_green_background],
      header:    [:light_yellow, :light_red_background],
      separator: [:light_yellow, :light_green_background],
      row:       [:light_blue, :light_green_background],
      bottom:    [:light_yellow, :light_green_background]
    },
    non_key_attrs: %{
      top:       [:light_yellow, :light_green_background],
      header:    [:light_red, :light_green_background],
      separator: [:light_yellow, :light_green_background],
      row:       [:black, :light_green_background],
      bottom:    [:light_yellow, :light_green_background]
    }
  },
  GREEN_PADDED: %{
    note: "like GREEN but with extra padding",
    rank: 200,
    line_types: [:top, :header, :separator, [:row], :bottom],
    borders: %{
      #           left   inner    right  dash
      top:       {"╔══", "══╦══", "══╗", "═"},
      header:    {"║"  ,   "║"  ,   "║", nil},
      separator: {"╠══", "══╬══", "══╣", "═"},
      row:       {"║"  ,   "║"  ,   "║", nil},
      bottom:    {"╚══", "══╩══", "══╝", "═"}
    },
    border_widths: %{
      #           left    inner      right
      top:       {[3, 0], [0, 5, 0], [0, 3]},
      header:    {[1, 2], [2, 1, 2], [2, 1]},
      separator: {[3, 0], [0, 5, 0], [0, 3]},
      row:       {[1, 2], [2, 1, 2], [2, 1]},
      bottom:    {[3, 0], [0, 5, 0], [0, 3]}
    },
    border_attrs: %{
      top:       [:light_green, :light_green_background],
      header:    [:light_green, :light_green_background],
      separator: [:light_green, :light_green_background],
      row:       [:light_green, :light_green_background],
      bottom:    [:light_green, :light_green_background]
    },
    filler_attrs: %{
      top:       :normal,
      header:    :normal,
      separator: :normal,
      row:       :normal,
      bottom:    :normal
    },
    key_attrs: %{
      top:       [:light_green, :light_green_background],
      header:    :light_red,
      separator: [:light_green, :light_green_background],
      row:       :light_green,
      bottom:    [:light_green, :light_green_background]
    },
    non_key_attrs: %{
      top:       [:light_green, :light_green_background],
      header:    :light_magenta,
      separator: [:light_green, :light_green_background],
      row:       :normal,
      bottom:    [:light_green, :light_green_background]
    }
  },
  GREEN_UNPADDED: %{
    note: "like GREEN but without padding",
    rank: 210,
    line_types: [:top, :header, :separator, [:row], :bottom],
    borders: %{
      #           left inner right dash
      top:       {"╔", "╦",  "╗",  "═"},
      header:    {"║", "║",  "║",  nil},
      separator: {"╠", "╬",  "╣",  "═"},
      row:       {"║", "║",  "║",  nil},
      bottom:    {"╚", "╩",  "╝",  "═"}
    },
    border_widths: %{
      #           left    inner      right
      top:       {[1, 0], [0, 1, 0], [0, 1]},
      header:    {[1, 0], [0, 1, 0], [0, 1]},
      separator: {[1, 0], [0, 1, 0], [0, 1]},
      row:       {[1, 0], [0, 1, 0], [0, 1]},
      bottom:    {[1, 0], [0, 1, 0], [0, 1]}
    },
    border_attrs: %{
      top:       [:light_green, :light_green_background],
      header:    [:light_green, :light_green_background],
      separator: [:light_green, :light_green_background],
      row:       [:light_green, :light_green_background],
      bottom:    [:light_green, :light_green_background]
    },
    filler_attrs: %{
      top:       :normal,
      header:    :normal,
      separator: :normal,
      row:       :normal,
      bottom:    :normal
    },
    key_attrs: %{
      top:       [:light_green, :light_green_background],
      header:    :light_red,
      separator: [:light_green, :light_green_background],
      row:       :light_green,
      bottom:    [:light_green, :light_green_background]
    },
    non_key_attrs: %{
      top:       [:light_green, :light_green_background],
      header:    :light_magenta,
      separator: [:light_green, :light_green_background],
      row:       :normal,
      bottom:    [:light_green, :light_green_background]
    }
  },
  black_alt: %{
    note: "black header, alternating row colors",
    rank: 220,
    line_types: [:top, :header, :separator, [:even_row, :odd_row]],
    borders: %{
      #           left  inner  right dash
      top:       {"┌─", "─┬─", "─┐", "─"},
      header:    {"│" ,  "│",   "│", nil},
      separator: {"├─", "─┼─", "─┤", "─"},
      even_row:  {"│" ,  "│",   "│", nil},
      odd_row:   {"│" ,  "│",   "│", nil},
      bottom:    {"└─", "─┴─", "─┘", "─"}
    },
    border_widths: %{
      #           left    inner      right
      top:       {[2, 0], [0, 3, 0], [0, 2]},
      header:    {[1, 1], [1, 1, 1], [1, 1]},
      separator: {[2, 0], [0, 3, 0], [0, 2]},
      even_row:  {[1, 1], [1, 1, 1], [1, 1]},
      odd_row:   {[1, 1], [1, 1, 1], [1, 1]},
      bottom:    {[2, 0], [0, 3, 0], [0, 2]}
    },
    border_attrs: %{
      top:       [:black, :black_background],
      header:    [:black, :black_background],
      separator: [:black, :black_background],
      even_row:  [:light_black, :light_black_background],
      odd_row:   [:light_yellow, :light_yellow_background],
      bottom:    [:black, :black_background]
    },
    filler_attrs: %{
      top:       :black_background,
      header:    :black_background,
      separator: :black_background,
      even_row:  :light_black_background,
      odd_row:   :light_yellow_background,
      bottom:    :black_background
    },
    key_attrs: %{
      top:       [:black, :black_background],
      header:    [:light_yellow, :black_background, :underline],
      separator: [:black, :black_background],
      even_row:  [:light_blue, :light_black_background],
      odd_row:   [:light_blue, :light_yellow_background],
      bottom:    [:black, :black_background]
    },
    non_key_attrs: %{
      top:       [:black, :black_background],
      header:    [:light_yellow, :black_background],
      separator: [:black, :black_background],
      even_row:  [:black, :light_black_background],
      odd_row:   [:black, :light_yellow_background],
      bottom:    [:black, :black_background]
    }
  },
  black_mult: %{
    note: "black header, 3 repeating row colors",
    rank: 230,
    line_types: [:top, :header, :separator, [:row_1, :row_2, :row_3]],
    borders: %{
      #           left  inner  right dash
      top:       {"┌─", "─┬─", "─┐", "─"},
      header:    {"│" ,  "│",   "│", nil},
      separator: {"├─", "─┼─", "─┤", "─"},
      row_1:     {"│" ,  "│",   "│", nil},
      row_2:     {"│" ,  "│",   "│", nil},
      row_3:     {"│" ,  "│",   "│", nil},
      bottom:    {"└─", "─┴─", "─┘", "─"}
    },
    border_widths: %{
      #           left    inner      right
      top:       {[2, 0], [0, 3, 0], [0, 2]},
      header:    {[1, 1], [1, 1, 1], [1, 1]},
      separator: {[2, 0], [0, 3, 0], [0, 2]},
      row_1:     {[1, 1], [1, 1, 1], [1, 1]},
      row_2:     {[1, 1], [1, 1, 1], [1, 1]},
      row_3:     {[1, 1], [1, 1, 1], [1, 1]},
      bottom:    {[2, 0], [0, 3, 0], [0, 2]}
    },
    border_attrs: %{
      top:       [:black, :black_background],
      header:    [:black, :black_background],
      separator: [:black, :black_background],
      row_1:     [:light_black, :light_black_background],
      row_2:     [:light_yellow, :light_yellow_background],
      row_3:     [:light_cyan, :light_cyan_background],
      bottom:    [:black, :black_background]
    },
    filler_attrs: %{
      top:       :black_background,
      header:    :black_background,
      separator: :black_background,
      row_1:     :light_black_background,
      row_2:     :light_yellow_background,
      row_3:     :light_cyan_background,
      bottom:    :black_background
    },
    key_attrs: %{
      top:       [:black, :black_background],
      header:    [:light_yellow, :black_background, :underline],
      separator: [:black, :black_background],
      row_1:     [:light_blue, :light_black_background],
      row_2:     [:light_blue, :light_yellow_background],
      row_3:     [:light_blue, :light_cyan_background],
      bottom:    [:black, :black_background]
    },
    non_key_attrs: %{
      top:       [:black, :black_background],
      header:    [:light_yellow, :black_background],
      separator: [:black, :black_background],
      row_1:     [:black, :light_black_background],
      row_2:     [:black, :light_yellow_background],
      row_3:     [:black, :light_cyan_background],
      bottom:    [:black, :black_background]
    }
  },
  green_alt: %{
    note: "green header, alternating row colors",
    rank: 240,
    line_types: [:top, :header, :separator, [:even_row, :odd_row]],
    borders: %{
      #           left  inner  right dash
      top:       {"┌─", "─┬─", "─┐", "─"},
      header:    {"│" ,  "│",   "│", nil},
      separator: {"├─", "─┼─", "─┤", "─"},
      even_row:  {"│" ,  "│",   "│", nil},
      odd_row:   {"│" ,  "│",   "│", nil},
      bottom:    {"└─", "─┴─", "─┘", "─"}
    },
    border_widths: %{
      #           left    inner      right
      top:       {[2, 0], [0, 3, 0], [0, 2]},
      header:    {[1, 1], [1, 1, 1], [1, 1]},
      separator: {[2, 0], [0, 3, 0], [0, 2]},
      even_row:  {[1, 1], [1, 1, 1], [1, 1]},
      odd_row:   {[1, 1], [1, 1, 1], [1, 1]},
      bottom:    {[2, 0], [0, 3, 0], [0, 2]}
    },
    border_attrs: %{
      top:       [:green, :green_background],
      header:    [:green, :green_background],
      separator: [:green, :green_background],
      even_row:  [:light_green, :light_green_background],
      odd_row:   [:light_yellow, :light_yellow_background],
      bottom:    [:green, :green_background]
    },
    filler_attrs: %{
      top:       :green_background,
      header:    :green_background,
      separator: :green_background,
      even_row:  :light_green_background,
      odd_row:   :light_yellow_background,
      bottom:    :green_background
    },
    key_attrs: %{
      top:       [:green, :green_background],
      header:    [:light_yellow, :green_background, :underline],
      separator: [:green, :green_background],
      even_row:  [:light_blue, :light_green_background],
      odd_row:   [:light_blue, :light_yellow_background],
      bottom:    [:green, :green_background]
    },
    non_key_attrs: %{
      top:       [:green, :green_background],
      header:    [:light_yellow, :green_background],
      separator: [:green, :green_background],
      even_row:  [:black, :light_green_background],
      odd_row:   [:black, :light_yellow_background],
      bottom:    [:green, :green_background]
    }
  },
  green_mult: %{
    note: "green header, 3 repeating row colors",
    rank: 250,
    line_types: [:top, :header, :separator, [:row_1, :row_2, :row_3]],
    borders: %{
      #           left  inner  right dash
      top:       {"┌─", "─┬─", "─┐", "─"},
      header:    {"│" ,  "│",   "│", nil},
      separator: {"├─", "─┼─", "─┤", "─"},
      row_1:     {"│" ,  "│",   "│", nil},
      row_2:     {"│" ,  "│",   "│", nil},
      row_3:     {"│" ,  "│",   "│", nil},
      bottom:    {"└─", "─┴─", "─┘", "─"}
    },
    border_widths: %{
      #           left    inner      right
      top:       {[2, 0], [0, 3, 0], [0, 2]},
      header:    {[1, 1], [1, 1, 1], [1, 1]},
      separator: {[2, 0], [0, 3, 0], [0, 2]},
      row_1:     {[1, 1], [1, 1, 1], [1, 1]},
      row_2:     {[1, 1], [1, 1, 1], [1, 1]},
      row_3:     {[1, 1], [1, 1, 1], [1, 1]},
      bottom:    {[2, 0], [0, 3, 0], [0, 2]}
    },
    border_attrs: %{
      top:       [:green, :green_background],
      header:    [:green, :green_background],
      separator: [:green, :green_background],
      row_1:     [:light_green, :light_green_background],
      row_2:     [:light_yellow, :light_yellow_background],
      row_3:     [:light_cyan, :light_cyan_background],
      bottom:    [:green, :green_background]
    },
    filler_attrs: %{
      top:       :green_background,
      header:    :green_background,
      separator: :green_background,
      row_1:     :light_green_background,
      row_2:     :light_yellow_background,
      row_3:     :light_cyan_background,
      bottom:    :green_background
    },
    key_attrs: %{
      top:       [:green, :green_background],
      header:    [:light_yellow, :green_background, :underline],
      separator: [:green, :green_background],
      row_1:     [:light_blue, :light_green_background],
      row_2:     [:light_blue, :light_yellow_background],
      row_3:     [:light_blue, :light_cyan_background],
      bottom:    [:green, :green_background]
    },
    non_key_attrs: %{
      top:       [:green, :green_background],
      header:    [:light_yellow, :green_background],
      separator: [:green, :green_background],
      row_1:     [:black, :light_green_background],
      row_2:     [:black, :light_yellow_background],
      row_3:     [:black, :light_cyan_background],
      bottom:    [:green, :green_background]
    }
  }
}

#
# And access this configuration in your application as:
#
#     Application.get_env(:io_ansi_table, :key)
#
# Or configure a 3rd-party app:
#
#     config :logger, level: :info
#

# It is also possible to import configuration files, relative to this
# directory. For example, you can emulate configuration per environment
# by uncommenting the line below and defining dev.exs, test.exs and such.
# Configuration from the imported file will override the ones defined
# here (which is why it is important to import them last).
#
#     import_config "#{Mix.env}.exs"
