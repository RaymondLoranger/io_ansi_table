# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config

config :elixir, ansi_enabled: true # to allow mix messages in colors...

# Examples of configuration to provide for the :io_ansi_table app:
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
#       top:    1, # line(s) before table
#       bottom: 1, # line(s) after table
#       left:   3  # space(s) left of table
#     ]
#     config :io_ansi_table, margins: [
#       left: 3 # space(s) left of table
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

config :io_ansi_table, ansi_enabled: true # table formatting in colors
# config :io_ansi_table, async: false # truthy -> cast; falsy -> call
config :io_ansi_table, default_align_specs: [:undefined]
config :io_ansi_table, default_bell: false
config :io_ansi_table, default_count: 11
config :io_ansi_table, default_headers: [:undefined]
config :io_ansi_table, default_header_fixes: %{
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
config :io_ansi_table, default_margins: [ # default table position
  top:    1, # line(s) before table
  bottom: 1, # line(s) after table
  left:   2  # space(s) left of table
]
config :io_ansi_table, default_sort_specs: [:undefined]
config :io_ansi_table, default_sort_symbols: [
  asc: "↑", desc: "↓", pos: :trailing
]
config :io_ansi_table, default_style: :plain
config :io_ansi_table, max_width_range: 7..99
config :io_ansi_table, options: [
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
config :io_ansi_table, row_types: [
  :even_row, :odd_row, :row, :row_1, :row_2, :row_3
]
config :io_ansi_table, rule_types: [:top, :separator, :bottom]
config :io_ansi_table, table_styles: [
  light: %{
    note: "light colors",
    rank: 10,
    borders: [
      #           left  inner  right dash
      top:       ["┌─", "─┬─", "─┐", "─"],
      header:    ["│" ,  "│",   "│", nil],
      separator: ["├─", "─┼─", "─┤", "─"],
      row:       ["│" ,  "│",   "│", nil],
      bottom:    ["└─", "─┴─", "─┘", "─"]
    ],
    border_attrs: :light_white,
    filler_attrs: :normal,
    key_attrs: [
      top:       :normal,
      header:    [:light_yellow, :underline],
      separator: :normal,
      row:       :light_cyan,
      bottom:    :normal
    ],
    non_key_attrs: [
      top:       :normal,
      header:    :light_yellow,
      separator: :normal,
      row:       :normal,
      bottom:    :normal
    ]
  },
  light_alt: %{
    note: "light colors, alternating row colors",
    rank: 15,
    borders: [
      #           left  inner  right dash
      top:       ["┌─", "─┬─", "─┐", "─"],
      header:    ["│" ,  "│",   "│", nil],
      separator: ["├─", "─┼─", "─┤", "─"],
      even_row:  ["│" ,  "│",   "│", nil],
      odd_row:   ["│" ,  "│",   "│", nil],
      bottom:    ["└─", "─┴─", "─┘", "─"]
    ],
    border_attrs: :light_white,
    filler_attrs: [
      top:       :normal,
      header:    :normal,
      separator: :normal,
      even_row:  :light_blue_background,
      odd_row:   :normal,
      bottom:    :normal
    ],
    key_attrs: [
      top:       :normal,
      header:    [:light_yellow, :underline],
      separator: :normal,
      even_row:  [:light_cyan, :light_blue_background],
      odd_row:   :light_cyan,
      bottom:    :normal
    ],
    non_key_attrs: [
      top:       :normal,
      header:    :light_yellow,
      separator: :normal,
      even_row:  [:normal, :light_blue_background],
      odd_row:   :normal,
      bottom:    :normal
    ]
  },
  light_mult: %{
    note: "light colors, 3 repeating row colors",
    rank: 17,
    borders: [
      #           left  inner  right dash
      top:       ["┌─", "─┬─", "─┐", "─"],
      header:    ["│" ,  "│",   "│", nil],
      separator: ["├─", "─┼─", "─┤", "─"],
      row_1:     ["│" ,  "│",   "│", nil],
      row_2:     ["│" ,  "│",   "│", nil],
      row_3:     ["│" ,  "│",   "│", nil],
      bottom:    ["└─", "─┴─", "─┘", "─"]
    ],
    border_attrs: :light_white,
    filler_attrs: [
      top:       :normal,
      header:    :normal,
      separator: :normal,
      row_1:     :light_blue_background,
      row_2:     :magenta_background,
      row_3:     :normal,
      bottom:    :normal
    ],
    key_attrs: [
      top:       :normal,
      header:    [:light_yellow, :underline],
      separator: :normal,
      row_1:     [:light_cyan, :light_blue_background],
      row_2:     [:light_cyan, :magenta_background],
      row_3:     :light_cyan,
      bottom:    :normal
    ],
    non_key_attrs: [
      top:       :normal,
      header:    :light_yellow,
      separator: :normal,
      row_1:     [:normal, :light_blue_background],
      row_2:     [:normal, :magenta_background],
      row_3:     :normal,
      bottom:    :normal
    ]
  },
  medium: %{
    note: "medium colors",
    rank: 20,
    borders: [
      #           left  inner  right dash
      top:       ["╔═", "═╤═", "═╗", "═"],
      header:    ["║",   "│" ,  "║", nil],
      separator: ["╟─", "─┼─", "─╢", "─"],
      row:       ["║" ,  "│" ,  "║", nil],
      bottom:    ["╚═", "═╧═", "═╝", "═"]
    ],
    border_attrs: :light_yellow,
    filler_attrs: :normal,
    key_attrs: [
      top:       :light_yellow,
      header:    [:light_green, :underline],
      separator: :light_yellow,
      row:       :light_cyan,
      bottom:    :light_yellow
    ],
    non_key_attrs: [
      top:       :light_yellow,
      header:    :light_green,
      separator: :light_yellow,
      row:       :light_yellow,
      bottom:    :light_yellow
    ]
  },
  medium_alt: %{
    note: "medium colors, alternating row colors",
    rank: 25,
    borders: [
      #           left  inner  right dash
      top:       ["╔═", "═╤═", "═╗", "═"],
      header:    ["║",   "│" ,  "║", nil],
      separator: ["╟─", "─┼─", "─╢", "─"],
      even_row:  ["║" ,  "│" ,  "║", nil],
      odd_row:   ["║" ,  "│" ,  "║", nil],
      bottom:    ["╚═", "═╧═", "═╝", "═"]
    ],
    border_attrs: :light_yellow,
    filler_attrs: [
      top:       :normal,
      header:    :normal,
      separator: :normal,
      even_row:  :light_blue_background,
      odd_row:   :normal,
      bottom:    :normal
    ],
    key_attrs: [
      top:       :light_yellow,
      header:    [:light_green, :underline],
      separator: :light_yellow,
      even_row:  [:light_cyan, :light_blue_background],
      odd_row:   :light_cyan,
      bottom:    :light_yellow
    ],
    non_key_attrs: [
      top:       :light_yellow,
      header:    :light_green,
      separator: :light_yellow,
      even_row:  [:light_yellow, :light_blue_background],
      odd_row:   :light_yellow,
      bottom:    :light_yellow
    ]
  },
  medium_mult: %{
    note: "medium colors, 3 repeating row colors",
    rank: 27,
    borders: [
      #           left  inner  right dash
      top:       ["╔═", "═╤═", "═╗", "═"],
      header:    ["║",   "│" ,  "║", nil],
      separator: ["╟─", "─┼─", "─╢", "─"],
      row_1:     ["║" ,  "│" ,  "║", nil],
      row_2:     ["║" ,  "│" ,  "║", nil],
      row_3:     ["║" ,  "│" ,  "║", nil],
      bottom:    ["╚═", "═╧═", "═╝", "═"]
    ],
    border_attrs: :light_yellow,
    filler_attrs: [
      top:       :normal,
      header:    :normal,
      separator: :normal,
      row_1:     :light_blue_background,
      row_2:     :magenta_background,
      row_3:     :normal,
      bottom:    :normal
    ],
    key_attrs: [
      top:       :light_yellow,
      header:    [:light_green, :underline],
      separator: :light_yellow,
      row_1:     [:light_cyan, :light_blue_background],
      row_2:     [:light_cyan, :magenta_background],
      row_3:     :light_cyan,
      bottom:    :light_yellow
    ],
    non_key_attrs: [
      top:       :light_yellow,
      header:    :light_green,
      separator: :light_yellow,
      row_1:     [:light_yellow, :light_blue_background],
      row_2:     [:light_yellow, :magenta_background],
      row_3:     :light_yellow,
      bottom:    :light_yellow
    ]
  },
  dark: %{
    note: "dark colors",
    rank: 30,
    borders: [
      #           left  inner  right dash
      top:       ["╔═", "═╦═", "═╗", "═"],
      header:    ["║" ,  "║" ,  "║", nil],
      separator: ["╠═", "═╬═", "═╣", "═"],
      row:       ["║" ,  "║" ,  "║", nil],
      bottom:    ["╚═", "═╩═", "═╝", "═"]
    ],
    border_attrs: :light_green,
    filler_attrs: :normal,
    key_attrs: [
      top:       :light_green,
      header:    [:light_white, :light_red_background],
      separator: :light_green,
      row:       :light_white,
      bottom:    :light_green
    ],
    non_key_attrs: [
      top:       :light_green,
      header:    :light_red,
      separator: :light_green,
      row:       :light_green,
      bottom:    :light_green
    ]
  },
  dark_alt: %{
    note: "dark colors, alternating row colors",
    rank: 35,
    borders: [
      #           left  inner  right dash
      top:       ["╔═", "═╦═", "═╗", "═"],
      header:    ["║" ,  "║" ,  "║", nil],
      separator: ["╠═", "═╬═", "═╣", "═"],
      even_row:  ["║" ,  "║" ,  "║", nil],
      odd_row:   ["║" ,  "║" ,  "║", nil],
      bottom:    ["╚═", "═╩═", "═╝", "═"]
    ],
    border_attrs: :light_green,
    filler_attrs: [
      top:       :normal,
      header:    :normal,
      separator: :normal,
      even_row:  :light_blue_background,
      odd_row:   :normal,
      bottom:    :normal
    ],
    key_attrs: [
      top:       :light_green,
      header:    [:light_white, :light_red_background],
      separator: :light_green,
      even_row:  [:light_white, :light_blue_background],
      odd_row:   :light_white,
      bottom:    :light_green
    ],
    non_key_attrs: [
      top:       :light_green,
      header:    :light_red,
      separator: :light_green,
      even_row:  [:light_green, :light_blue_background],
      odd_row:   :light_green,
      bottom:    :light_green
    ]
  },
  dark_mult: %{
    note: "dark colors, 3 repeating row colors",
    rank: 37,
    borders: [
      #           left  inner  right dash
      top:       ["╔═", "═╦═", "═╗", "═"],
      header:    ["║" ,  "║" ,  "║", nil],
      separator: ["╠═", "═╬═", "═╣", "═"],
      row_1:     ["║" ,  "║" ,  "║", nil],
      row_2:     ["║" ,  "║" ,  "║", nil],
      row_3:     ["║" ,  "║" ,  "║", nil],
      bottom:    ["╚═", "═╩═", "═╝", "═"]
    ],
    border_attrs: :light_green,
    filler_attrs: [
      top:       :normal,
      header:    :normal,
      separator: :normal,
      row_1:     :light_blue_background,
      row_2:     :magenta_background,
      row_3:     :normal,
      bottom:    :normal
    ],
    key_attrs: [
      top:       :light_green,
      header:    [:light_white, :light_red_background],
      separator: :light_green,
      row_1:     [:light_white, :light_blue_background],
      row_2:     [:light_white, :magenta_background],
      row_3:     :light_white,
      bottom:    :light_green
    ],
    non_key_attrs: [
      top:       :light_green,
      header:    :light_red,
      separator: :light_green,
      row_1:     [:light_green, :light_blue_background],
      row_2:     [:light_green, :magenta_background],
      row_3:     :light_green,
      bottom:    :light_green
    ]
  },
  pretty: %{
    note: "multicolored",
    rank: 40,
    borders: [
      #           left  inner  right dash
      top:       ["╔═", "═╦═", "═╗", "═"],
      header:    ["║" ,  "║" ,  "║", nil],
      separator: ["╠═", "═╬═", "═╣", "═"],
      row:       ["║" ,  "║" ,  "║", nil],
      bottom:    ["╚═", "═╩═", "═╝", "═"]
    ],
    border_attrs: :light_magenta,
    filler_attrs: :normal,
    key_attrs: [
      top:       :light_magenta,
      header:    [:light_green, :underline],
      separator: :light_magenta,
      row:       :light_cyan,
      bottom:    :light_magenta
    ],
    non_key_attrs: [
      top:       :light_magenta,
      header:    :light_green,
      separator: :light_magenta,
      row:       :light_yellow,
      bottom:    :light_magenta
    ]
  },
  pretty_alt: %{
    note: "multicolored, alternating row colors",
    rank: 45,
    borders: [
      #           left  inner  right dash
      top:       ["╔═", "═╦═", "═╗", "═"],
      header:    ["║" ,  "║" ,  "║", nil],
      separator: ["╠═", "═╬═", "═╣", "═"],
      even_row:  ["║" ,  "║" ,  "║", nil],
      odd_row:   ["║" ,  "║" ,  "║", nil],
      bottom:    ["╚═", "═╩═", "═╝", "═"]
    ],
    border_attrs: :light_magenta,
    filler_attrs: [
      top:       :normal,
      header:    :normal,
      separator: :normal,
      even_row:  :light_blue_background,
      odd_row:   :normal,
      bottom:    :normal
    ],
    key_attrs: [
      top:       :light_magenta,
      header:    [:light_green, :underline],
      separator: :light_magenta,
      even_row:  [:light_cyan, :light_blue_background],
      odd_row:   :light_cyan,
      bottom:    :light_magenta
    ],
    non_key_attrs: [
      top:       :light_magenta,
      header:    :light_green,
      separator: :light_magenta,
      even_row:  [:light_yellow, :light_blue_background],
      odd_row:   :light_yellow,
      bottom:    :light_magenta
    ]
  },
  pretty_mult: %{
    note: "multicolored, 3 repeating row colors",
    rank: 47,
    borders: [
      #           left  inner  right dash
      top:       ["╔═", "═╦═", "═╗", "═"],
      header:    ["║" ,  "║" ,  "║", nil],
      separator: ["╠═", "═╬═", "═╣", "═"],
      row_1:     ["║" ,  "║" ,  "║", nil],
      row_2:     ["║" ,  "║" ,  "║", nil],
      row_3:     ["║" ,  "║" ,  "║", nil],
      bottom:    ["╚═", "═╩═", "═╝", "═"]
    ],
    border_attrs: :light_magenta,
    filler_attrs: [
      top:       :normal,
      header:    :normal,
      separator: :normal,
      row_1:     :light_blue_background,
      row_2:     :magenta_background,
      row_3:     :normal,
      bottom:    :normal
    ],
    key_attrs: [
      top:       :light_magenta,
      header:    [:light_green, :underline],
      separator: :light_magenta,
      row_1:     [:light_cyan, :light_blue_background],
      row_2:     [:light_cyan, :magenta_background],
      row_3:     :light_cyan,
      bottom:    :light_magenta
    ],
    non_key_attrs: [
      top:       :light_magenta,
      header:    :light_green,
      separator: :light_magenta,
      row_1:     [:light_yellow, :light_blue_background],
      row_2:     [:light_yellow, :magenta_background],
      row_3:     :light_yellow,
      bottom:    :light_magenta
    ]
  },
  cyan: %{
    note: "light cyan background",
    rank: 50,
    borders: [
      #           left  inner  right dash
      top:       ["╔═", "═╦═", "═╗", "═"],
      header:    ["║" ,  "║" ,  "║", nil],
      separator: ["╠═", "═╬═", "═╣", "═"],
      row:       ["║" ,  "║" ,  "║", nil],
      bottom:    ["╚═", "═╩═", "═╝", "═"]
    ],
    border_attrs: [:light_blue, :light_cyan_background],
    filler_attrs: :light_cyan_background,
    key_attrs: [
      top:       [:light_blue, :light_cyan_background],
      header:    [:light_yellow, :light_red_background],
      separator: [:light_blue, :light_cyan_background],
      row:       [:light_blue, :light_cyan_background],
      bottom:    [:light_blue, :light_cyan_background]
    ],
    non_key_attrs: [
      top:       [:light_blue, :light_cyan_background],
      header:    [:light_red, :light_cyan_background],
      separator: [:light_blue, :light_cyan_background],
      row:       [:black, :light_cyan_background],
      bottom:    [:light_blue, :light_cyan_background]
    ]
  },
  yellow: %{
    note: "light yellow background",
    rank: 60,
    borders: [
      #           left  inner  right dash
      top:       ["╔═", "═╦═", "═╗", "═"],
      header:    ["║" ,  "║" ,  "║", nil],
      separator: ["╠═", "═╬═", "═╣", "═"],
      row:       ["║" ,  "║" ,  "║", nil],
      bottom:    ["╚═", "═╩═", "═╝", "═"]
    ],
    border_attrs: [:green, :light_yellow_background],
    filler_attrs: :light_yellow_background,
    key_attrs: [
      top:       [:green, :light_yellow_background],
      header:    [:light_white, :light_red_background],
      separator: [:green, :light_yellow_background],
      row:       [:light_blue, :light_yellow_background],
      bottom:    [:green, :light_yellow_background]
    ],
    non_key_attrs: [
      top:       [:green, :light_yellow_background],
      header:    [:light_red, :light_yellow_background],
      separator: [:green, :light_yellow_background],
      row:       [:black, :light_yellow_background],
      bottom:    [:green, :light_yellow_background]
    ]
  },
  green: %{
    note: "light green background",
    rank: 70,
    borders: [
      #           left  inner  right dash
      top:       ["╔═", "═╦═", "═╗", "═"],
      header:    ["║" ,  "║" ,  "║", nil],
      separator: ["╠═", "═╬═", "═╣", "═"],
      row:       ["║" ,  "║" ,  "║", nil],
      bottom:    ["╚═", "═╩═", "═╝", "═"]
    ],
    border_attrs: [:light_yellow, :light_green_background],
    filler_attrs: :light_green_background,
    key_attrs: [
      top:       [:light_yellow, :light_green_background],
      header:    [:light_yellow, :light_red_background],
      separator: [:light_yellow, :light_green_background],
      row:       [:light_blue, :light_green_background],
      bottom:    [:light_yellow, :light_green_background]
    ],
    non_key_attrs: [
      top:       [:light_yellow, :light_green_background],
      header:    [:light_red, :light_green_background],
      separator: [:light_yellow, :light_green_background],
      row:       [:black, :light_green_background],
      bottom:    [:light_yellow, :light_green_background]
    ]
  },
  cyan_border: %{
    note: "light cyan border",
    rank: 80,
    borders: [
      #           left  inner  right dash
      top:       ["╔═", "═╦═", "═╗", "═"],
      header:    ["║" ,  "║" ,  "║", nil],
      separator: ["╠═", "═╬═", "═╣", "═"],
      row:       ["║" ,  "║" ,  "║", nil],
      bottom:    ["╚═", "═╩═", "═╝", "═"]
    ],
    border_attrs: [:light_cyan, :light_cyan_background],
    filler_attrs: :normal,
    key_attrs: [
      top:       [:light_cyan, :light_cyan_background],
      header:    :light_red,
      separator: [:light_cyan, :light_cyan_background],
      row:       :light_cyan,
      bottom:    [:light_cyan, :light_cyan_background]
    ],
    non_key_attrs: [
      top:       [:light_cyan, :light_cyan_background],
      header:    :light_magenta,
      separator: [:light_cyan, :light_cyan_background],
      row:       :normal,
      bottom:    [:light_cyan, :light_cyan_background]
    ]
  },
  yellow_border: %{
    note: "light yellow border",
    rank: 90,
    borders: [
      #           left  inner  right dash
      top:       ["╔═", "═╦═", "═╗", "═"],
      header:    ["║" ,  "║" ,  "║", nil],
      separator: ["╠═", "═╬═", "═╣", "═"],
      row:       ["║" ,  "║" ,  "║", nil],
      bottom:    ["╚═", "═╩═", "═╝", "═"]
    ],
    border_attrs: [:light_yellow, :light_yellow_background],
    filler_attrs: :normal,
    key_attrs: [
      top:       [:light_yellow, :light_yellow_background],
      header:    :light_red,
      separator: [:light_yellow, :light_yellow_background],
      row:       :light_yellow,
      bottom:    [:light_yellow, :light_yellow_background]
    ],
    non_key_attrs: [
      top:       [:light_yellow, :light_yellow_background],
      header:    :light_magenta,
      separator: [:light_yellow, :light_yellow_background],
      row:       :normal,
      bottom:    [:light_yellow, :light_yellow_background]
    ]
  },
  green_border: %{
    note: "light green border",
    rank: 100,
    borders: [
      #           left  inner  right dash
      top:       ["╔═", "═╦═", "═╗", "═"],
      header:    ["║" ,  "║" ,  "║", nil],
      separator: ["╠═", "═╬═", "═╣", "═"],
      row:       ["║" ,  "║" ,  "║", nil],
      bottom:    ["╚═", "═╩═", "═╝", "═"]
    ],
    border_attrs: [:light_green, :light_green_background],
    filler_attrs: :normal,
    key_attrs: [
      top:       [:light_green, :light_green_background],
      header:    :light_red,
      separator: [:light_green, :light_green_background],
      row:       :light_green,
      bottom:    [:light_green, :light_green_background]
    ],
    non_key_attrs: [
      top:       [:light_green, :light_green_background],
      header:    :light_magenta,
      separator: [:light_green, :light_green_background],
      row:       :normal,
      bottom:    [:light_green, :light_green_background]
    ]
  },
  mixed: %{
    note: "fillers revealed",
    rank: 110,
    borders: [
      #           left  inner  right dash
      top:       ["╔═", "═╦═", "═╗", "═"],
      header:    ["║" ,  "║" ,  "║", nil],
      separator: ["╠═", "═╬═", "═╣", "═"],
      row:       ["║" ,  "║" ,  "║", nil],
      bottom:    ["╚═", "═╩═", "═╝", "═"]
    ],
    border_attrs: [:black, :light_yellow_background],
    filler_attrs: :light_green_background,
    key_attrs: [
      top:       [:black, :light_yellow_background],
      header:    [:light_red, :reverse, :light_yellow_background],
      separator: [:black, :light_yellow_background],
      row:       [:light_blue, :light_yellow_background],
      bottom:    [:black, :light_yellow_background]
    ],
    non_key_attrs: [
      top:       [:black, :light_yellow_background],
      header:    [:light_magenta, :light_white_background],
      separator: [:black, :light_yellow_background],
      row:       [:light_black, :light_yellow_background],
      bottom:    [:black, :light_yellow_background]
    ]
  },
  dotted: %{
    note: "slightly colored",
    rank: 120,
    borders: [
      #           left  inner  right dash
      top:       ["┏╍", "╍┳╍", "╍┓", "╍"],
      header:    ["┇" ,  "┇" ,  "┇", nil],
      separator: ["┣╍", "╍╋╍", "╍┫", "╍"],
      row:       ["┇" ,  "┇" ,  "┇", nil],
      bottom:    ["┗╍", "╍┻╍", "╍┛", "╍"]
    ],
    border_attrs: :normal,
    filler_attrs: :normal,
    key_attrs: [
      top:       :normal,
      header:    [:light_white, :green_background],
      separator: :normal,
      row:       :light_green,
      bottom:    :normal
    ],
    non_key_attrs: :normal,
  },
  dotted_alt: %{
    note: "slightly colored, alternating row colors",
    rank: 125,
    borders: [
      #           left  inner  right dash
      top:       ["┏╍", "╍┳╍", "╍┓", "╍"],
      header:    ["┇" ,  "┇" ,  "┇", nil],
      separator: ["┣╍", "╍╋╍", "╍┫", "╍"],
      even_row:  ["┇" ,  "┇" ,  "┇", nil],
      odd_row:   ["┇" ,  "┇" ,  "┇", nil],
      bottom:    ["┗╍", "╍┻╍", "╍┛", "╍"]
    ],
    border_attrs: :normal,
    filler_attrs: [
      top:       :normal,
      header:    :normal,
      separator: :normal,
      even_row:  :light_blue_background,
      odd_row:   :normal,
      bottom:    :normal
    ],
    key_attrs: [
      top:       :normal,
      header:    [:light_white, :green_background],
      separator: :normal,
      even_row:  [:light_green, :light_blue_background],
      odd_row:   :light_green,
      bottom:    :normal
    ],
    non_key_attrs: [
      top:       :normal,
      header:    :normal,
      separator: :normal,
      even_row:  [:normal, :light_blue_background],
      odd_row:   :normal,
      bottom:    :normal
    ]
  },
  dotted_mult: %{
    note: "slightly colored, 3 repeating row colors",
    rank: 127,
    borders: [
      #           left  inner  right dash
      top:       ["┏╍", "╍┳╍", "╍┓", "╍"],
      header:    ["┇" ,  "┇" ,  "┇", nil],
      separator: ["┣╍", "╍╋╍", "╍┫", "╍"],
      row_1:     ["┇" ,  "┇" ,  "┇", nil],
      row_2:     ["┇" ,  "┇" ,  "┇", nil],
      row_3:     ["┇" ,  "┇" ,  "┇", nil],
      bottom:    ["┗╍", "╍┻╍", "╍┛", "╍"]
    ],
    border_attrs: :normal,
    filler_attrs: [
      top:       :normal,
      header:    :normal,
      separator: :normal,
      row_1:     :light_blue_background,
      row_2:     :magenta_background,
      row_3:     :normal,
      bottom:    :normal
    ],
    key_attrs: [
      top:       :normal,
      header:    [:light_white, :green_background],
      separator: :normal,
      row_1:     [:light_green, :light_blue_background],
      row_2:     [:light_green, :magenta_background],
      row_3:     :light_green,
      bottom:    :normal
    ],
    non_key_attrs: [
      top:       :normal,
      header:    :normal,
      separator: :normal,
      row_1:     [:normal, :light_blue_background],
      row_2:     [:normal, :magenta_background],
      row_3:     :normal,
      bottom:    :normal
    ]
  },
  dashed: %{
    note: "no colors",
    rank: 130,
    borders: [
      #           left  inner  right dash
      top:       ["+-", "-+-", "-+", "-"],
      header:    ["|" ,  "|" ,  "|", nil],
      separator: ["+-", "-+-", "-+", "-"],
      row:       ["|" ,  "|" ,  "|", nil],
      bottom:    ["+-", "-+-", "-+", "-"]
    ],
    border_attrs:  :normal,
    filler_attrs:  :normal,
    key_attrs:     :normal,
    non_key_attrs: :normal
  },
  plain: %{
    note: "slightly colored",
    rank: 140,
    borders: [
      #           left  inner  right dash
      top:       ["┌─", "─┬─", "─┐", "─"],
      header:    ["│" ,  "│" ,  "│", nil],
      separator: ["├─", "─┼─", "─┤", "─"],
      row:       ["│" ,  "│" ,  "│", nil],
      bottom:    ["└─", "─┴─", "─┘", "─"]
    ],
    border_attrs: :light_yellow,
    filler_attrs: :normal,
    key_attrs: [
      top:       :light_yellow,
      header:    [:light_yellow, :underline],
      separator: :light_yellow,
      row:       :light_yellow,
      bottom:    :light_yellow
    ],
    non_key_attrs: [
      top:       :light_yellow,
      header:    :light_yellow,
      separator: :light_yellow,
      row:       :normal,
      bottom:    :light_yellow
    ]
  },
  test: %{
    note: "no colors",
    rank: 150,
    borders: [
      #           left  inner  right dash
      top:       ["┌─", "─┬─", "─┐", "─"],
      header:    ["│" ,  "│" ,  "│", nil],
      separator: ["├─", "─┼─", "─┤", "─"],
      row:       ["│" ,  "│" ,  "│", nil],
      bottom:    ["└─", "─┴─", "─┘", "─"]
    ],
    border_attrs:  :normal,
    filler_attrs:  :normal,
    key_attrs:     :normal,
    non_key_attrs: :normal
  },
  bare: %{
    note: "no colors",
    rank: 160,
    borders: [
      #           left inner  right dash
      header:    ["",   "|" , "",   nil],
      separator: ["",  "-+-", "",   "-"],
      row:       ["",   "|" , "",   nil]
    ],
    border_attrs:  :normal,
    filler_attrs:  :normal,
    key_attrs:     :normal,
    non_key_attrs: :normal
  },
  barish: %{
    note: "like bare but colored",
    rank: 170,
    borders: [
      #           left inner  right dash
      header:    ["",   "|" , "",   nil],
      separator: ["",  "-+-", "",   "-"],
      row:       ["",   "|" , "",   nil]
    ],
    border_attrs: :light_yellow,
    filler_attrs: :normal,
    key_attrs: [
      header:    :light_green,
      separator: :light_yellow,
      row:       :light_cyan
    ],
    non_key_attrs: [
      header:    :normal,
      separator: :light_yellow,
      row:       :normal
    ]
  },
  green_padded: %{
    note: "like green but with extra padding",
    rank: 180,
    borders: [
      #           left   inner    right  dash
      top:       ["╔══", "══╦══", "══╗", "═"],
      header:    ["║"  ,   "║"  ,   "║", nil],
      separator: ["╠══", "══╬══", "══╣", "═"],
      row:       ["║"  ,   "║"  ,   "║", nil],
      bottom:    ["╚══", "══╩══", "══╝", "═"]
    ],
    border_attrs: [:light_yellow, :light_green_background],
    filler_attrs: :light_green_background,
    key_attrs: [
      top:       [:light_yellow, :light_green_background],
      header:    [:light_yellow, :light_red_background],
      separator: [:light_yellow, :light_green_background],
      row:       [:light_blue, :light_green_background],
      bottom:    [:light_yellow, :light_green_background]
    ],
    non_key_attrs: [
      top:       [:light_yellow, :light_green_background],
      header:    [:light_red, :light_green_background],
      separator: [:light_yellow, :light_green_background],
      row:       [:black, :light_green_background],
      bottom:    [:light_yellow, :light_green_background]
    ]
  },
  green_unpadded: %{
    note: "like green but without padding",
    rank: 190,
    borders: [
      #           left inner right dash
      top:       ["╔", "╦",  "╗",  "═"],
      header:    ["║", "║",  "║",  nil],
      separator: ["╠", "╬",  "╣",  "═"],
      row:       ["║", "║",  "║",  nil],
      bottom:    ["╚", "╩",  "╝",  "═"]
    ],
    border_attrs: [:light_yellow, :light_green_background],
    filler_attrs: :light_green_background,
    key_attrs: [
      top:       [:light_yellow, :light_green_background],
      header:    [:light_yellow, :light_red_background],
      separator: [:light_yellow, :light_green_background],
      row:       [:light_blue, :light_green_background],
      bottom:    [:light_yellow, :light_green_background]
    ],
    non_key_attrs: [
      top:       [:light_yellow, :light_green_background],
      header:    [:light_red, :light_green_background],
      separator: [:light_yellow, :light_green_background],
      row:       [:black, :light_green_background],
      bottom:    [:light_yellow, :light_green_background]
    ]
  },
  green_border_padded: %{
    note: "light green border with extra padding",
    rank: 200,
    borders: [
      #           left   inner    right  dash
      top:       ["╔══", "══╦══", "══╗", "═"],
      header:    ["║"  ,   "║"  ,   "║", nil],
      separator: ["╠══", "══╬══", "══╣", "═"],
      row:       ["║"  ,   "║"  ,   "║", nil],
      bottom:    ["╚══", "══╩══", "══╝", "═"]
    ],
    border_attrs: [:light_green, :light_green_background],
    filler_attrs: :normal,
    key_attrs: [
      top:       [:light_green, :light_green_background],
      header:    :light_red,
      separator: [:light_green, :light_green_background],
      row:       :light_green,
      bottom:    [:light_green, :light_green_background]
    ],
    non_key_attrs: [
      top:       [:light_green, :light_green_background],
      header:    :light_magenta,
      separator: [:light_green, :light_green_background],
      row:       :normal,
      bottom:    [:light_green, :light_green_background]
    ]
  },
  green_border_unpadded: %{
    note: "light green border without padding",
    rank: 210,
    borders: [
      #           left inner right dash
      top:       ["╔", "╦",  "╗",  "═"],
      header:    ["║", "║",  "║",  nil],
      separator: ["╠", "╬",  "╣",  "═"],
      row:       ["║", "║",  "║",  nil],
      bottom:    ["╚", "╩",  "╝",  "═"]
    ],
    border_attrs: [:light_green, :light_green_background],
    filler_attrs: :normal,
    key_attrs: [
      top:       [:light_green, :light_green_background],
      header:    :light_red,
      separator: [:light_green, :light_green_background],
      row:       :light_green,
      bottom:    [:light_green, :light_green_background]
    ],
    non_key_attrs: [
      top:       [:light_green, :light_green_background],
      header:    :light_magenta,
      separator: [:light_green, :light_green_background],
      row:       :normal,
      bottom:    [:light_green, :light_green_background]
    ]
  },
  cyan_alt: %{
    note: "cyan header, alternating row colors",
    rank: 220,
    borders: [
      #           left  inner  right dash
      top:       ["┌─", "─┬─", "─┐", "─"],
      header:    ["│" ,  "│",   "│", nil],
      separator: ["├─", "─┼─", "─┤", "─"],
      even_row:  ["│" ,  "│",   "│", nil],
      odd_row:   ["│" ,  "│",   "│", nil]
    ],
    border_attrs: [
      top:       [:cyan, :cyan_background],
      header:    [:cyan, :cyan_background],
      separator: [:cyan, :cyan_background],
      even_row:  [:light_cyan, :light_cyan_background],
      odd_row:   [:light_yellow, :light_yellow_background]
    ],
    filler_attrs: [
      top:       :cyan_background,
      header:    :cyan_background,
      separator: :cyan_background,
      even_row:  :light_cyan_background,
      odd_row:   :light_yellow_background
    ],
    key_attrs: [
      top:       [:cyan, :cyan_background],
      header:    [:light_white, :cyan_background, :underline],
      separator: [:cyan, :cyan_background],
      even_row:  [:light_blue, :light_cyan_background],
      odd_row:   [:light_blue, :light_yellow_background]
    ],
    non_key_attrs: [
      top:       [:cyan, :cyan_background],
      header:    [:light_yellow, :cyan_background],
      separator: [:cyan, :cyan_background],
      even_row:  [:black, :light_cyan_background],
      odd_row:   [:black, :light_yellow_background]
    ]
  },
  cyan_mult: %{
    note: "cyan header, 3 repeating row colors",
    rank: 230,
    borders: [
      #           left  inner  right dash
      top:       ["┌─", "─┬─", "─┐", "─"],
      header:    ["│" ,  "│",   "│", nil],
      separator: ["├─", "─┼─", "─┤", "─"],
      row_1:     ["│" ,  "│",   "│", nil],
      row_2:     ["│" ,  "│",   "│", nil],
      row_3:     ["│" ,  "│",   "│", nil]
    ],
    border_attrs: [
      top:       [:cyan, :cyan_background],
      header:    [:cyan, :cyan_background],
      separator: [:cyan, :cyan_background],
      row_1:     [:light_cyan, :light_cyan_background],
      row_2:     [:light_yellow, :light_yellow_background],
      row_3:     [:light_green, :light_green_background]
    ],
    filler_attrs: [
      top:       :cyan_background,
      header:    :cyan_background,
      separator: :cyan_background,
      row_1:     :light_cyan_background,
      row_2:     :light_yellow_background,
      row_3:     :light_green_background
    ],
    key_attrs: [
      top:       [:cyan, :cyan_background],
      header:    [:light_white, :cyan_background, :underline],
      separator: [:cyan, :cyan_background],
      row_1:     [:light_blue, :light_cyan_background],
      row_2:     [:light_blue, :light_yellow_background],
      row_3:     [:light_blue, :light_green_background]
    ],
    non_key_attrs: [
      top:       [:cyan, :cyan_background],
      header:    [:light_yellow, :cyan_background],
      separator: [:cyan, :cyan_background],
      row_1:     [:black, :light_cyan_background],
      row_2:     [:black, :light_yellow_background],
      row_3:     [:black, :light_green_background]
    ]
  },
  green_alt: %{
    note: "green header, alternating row colors",
    rank: 240,
    borders: [
      #           left  inner  right dash
      top:       ["┌─", "─┬─", "─┐", "─"],
      header:    ["│" ,  "│",   "│", nil],
      separator: ["├─", "─┼─", "─┤", "─"],
      even_row:  ["│" ,  "│",   "│", nil],
      odd_row:   ["│" ,  "│",   "│", nil]
    ],
    border_attrs: [
      top:       [:green, :green_background],
      header:    [:green, :green_background],
      separator: [:green, :green_background],
      even_row:  [:light_green, :light_green_background],
      odd_row:   [:light_yellow, :light_yellow_background]
    ],
    filler_attrs: [
      top:       :green_background,
      header:    :green_background,
      separator: :green_background,
      even_row:  :light_green_background,
      odd_row:   :light_yellow_background
    ],
    key_attrs: [
      top:       [:green, :green_background],
      header:    [:light_white, :green_background, :underline],
      separator: [:green, :green_background],
      even_row:  [:light_blue, :light_green_background],
      odd_row:   [:light_blue, :light_yellow_background]
    ],
    non_key_attrs: [
      top:       [:green, :green_background],
      header:    [:light_yellow, :green_background],
      separator: [:green, :green_background],
      even_row:  [:black, :light_green_background],
      odd_row:   [:black, :light_yellow_background]
    ]
  },
  green_mult: %{
    note: "green header, 3 repeating row colors",
    rank: 250,
    borders: [
      #           left  inner  right dash
      top:       ["┌─", "─┬─", "─┐", "─"],
      header:    ["│" ,  "│",   "│", nil],
      separator: ["├─", "─┼─", "─┤", "─"],
      row_1:     ["│" ,  "│",   "│", nil],
      row_2:     ["│" ,  "│",   "│", nil],
      row_3:     ["│" ,  "│",   "│", nil]
    ],
    border_attrs: [
      top:       [:green, :green_background],
      header:    [:green, :green_background],
      separator: [:green, :green_background],
      row_1:     [:light_green, :light_green_background],
      row_2:     [:light_yellow, :light_yellow_background],
      row_3:     [:light_cyan, :light_cyan_background]
    ],
    filler_attrs: [
      top:       :green_background,
      header:    :green_background,
      separator: :green_background,
      row_1:     :light_green_background,
      row_2:     :light_yellow_background,
      row_3:     :light_cyan_background
    ],
    key_attrs: [
      top:       [:green, :green_background],
      header:    [:light_white, :green_background, :underline],
      separator: [:green, :green_background],
      row_1:     [:light_blue, :light_green_background],
      row_2:     [:light_blue, :light_yellow_background],
      row_3:     [:light_blue, :light_cyan_background]
    ],
    non_key_attrs: [
      top:       [:green, :green_background],
      header:    [:light_yellow, :green_background],
      separator: [:green, :green_background],
      row_1:     [:black, :light_green_background],
      row_2:     [:black, :light_yellow_background],
      row_3:     [:black, :light_cyan_background]
    ]
  },
  game_green: %{
    note: "green headers, 3 repeating row colors",
    rank: 260,
    borders: [
      #           left inner  right dash
      top:       ["╔", "═╤═", "╗",  "═"],
      header:    ["║",  "│" , "║",  nil],
      separator: ["╟", "─┼─", "╢",  "─"],
      row_1:     ["║",  "│" , "║",  nil],
      row_2:     ["║",  "│" , "║",  nil],
      row_3:     ["║",  "│" , "║",  nil],
      bottom:    ["╚", "═╧═", "╝",  "═"]
    ],
    border_attrs: :light_yellow,
    filler_attrs: [
      top:       :normal,
      header:    :normal,
      separator: :normal,
      row_1:     :light_blue_background,
      row_2:     :magenta_background,
      row_3:     :normal,
      bottom:    :normal
    ],
    key_attrs: [
      top:       :light_yellow,
      header:    :light_green,
      separator: :light_yellow,
      row_1:     [:light_green, :light_blue_background],
      row_2:     [:light_green, :magenta_background],
      row_3:     :light_green,
      bottom:    :light_yellow
    ],
    non_key_attrs: [
      top:       :light_yellow,
      header:    :light_green,
      separator: :light_yellow,
      row_1:     [:light_yellow, :light_blue_background],
      row_2:     [:light_yellow, :magenta_background],
      row_3:     :light_yellow,
      bottom:    :light_yellow
    ]
  },
  game_cyan: %{
    note: "cyan headers, 3 repeating row colors",
    rank: 270,
    borders: [
      #           left inner  right dash
      top:       ["╔", "═╤═", "╗",  "═"],
      header:    ["║",  "│" , "║",  nil],
      separator: ["╟", "─┼─", "╢",  "─"],
      row_1:     ["║",  "│" , "║",  nil],
      row_2:     ["║",  "│" , "║",  nil],
      row_3:     ["║",  "│" , "║",  nil],
      bottom:    ["╚", "═╧═", "╝",  "═"]
    ],
    border_attrs: :light_yellow,
    filler_attrs: [
      top:       :normal,
      header:    :normal,
      separator: :normal,
      row_1:     :light_blue_background,
      row_2:     :magenta_background,
      row_3:     :normal,
      bottom:    :normal
    ],
    key_attrs: [
      top:       :light_yellow,
      header:    :light_cyan,
      separator: :light_yellow,
      row_1:     [:light_cyan, :light_blue_background],
      row_2:     [:light_cyan, :magenta_background],
      row_3:     :light_cyan,
      bottom:    :light_yellow
    ],
    non_key_attrs: [
      top:       :light_yellow,
      header:    :light_cyan,
      separator: :light_yellow,
      row_1:     [:light_yellow, :light_blue_background],
      row_2:     [:light_yellow, :magenta_background],
      row_3:     :light_yellow,
      bottom:    :light_yellow
    ]
  },
  game_magenta: %{
    note: "magenta headers, 3 repeating row colors",
    rank: 280,
    borders: [
      #           left inner  right dash
      top:       ["╔", "═╤═", "╗",  "═"],
      header:    ["║",  "│" , "║",  nil],
      separator: ["╟", "─┼─", "╢",  "─"],
      row_1:     ["║",  "│" , "║",  nil],
      row_2:     ["║",  "│" , "║",  nil],
      row_3:     ["║",  "│" , "║",  nil],
      bottom:    ["╚", "═╧═", "╝",  "═"]
    ],
    border_attrs: :light_yellow,
    filler_attrs: [
      top:       :normal,
      header:    :normal,
      separator: :normal,
      row_1:     :light_blue_background,
      row_2:     :magenta_background,
      row_3:     :normal,
      bottom:    :normal
    ],
    key_attrs: [
      top:       :light_yellow,
      header:    :light_magenta,
      separator: :light_yellow,
      row_1:     [:light_magenta, :light_blue_background],
      row_2:     [:light_magenta, :magenta_background],
      row_3:     :light_magenta,
      bottom:    :light_yellow
    ],
    non_key_attrs: [
      top:       :light_yellow,
      header:    :light_magenta,
      separator: :light_yellow,
      row_1:     [:light_yellow, :light_blue_background],
      row_2:     [:light_yellow, :magenta_background],
      row_3:     :light_yellow,
      bottom:    :light_yellow
    ]
  },
  game_yellow: %{
    note: "yellow headers, 3 repeating row colors",
    rank: 290,
    borders: [
      #           left inner  right dash
      top:       ["╔", "═╤═", "╗",  "═"],
      header:    ["║",  "│" , "║",  nil],
      separator: ["╟", "─┼─", "╢",  "─"],
      row_1:     ["║",  "│" , "║",  nil],
      row_2:     ["║",  "│" , "║",  nil],
      row_3:     ["║",  "│" , "║",  nil],
      bottom:    ["╚", "═╧═", "╝",  "═"]
    ],
    border_attrs: :light_yellow,
    filler_attrs: [
      top:       :normal,
      header:    :normal,
      separator: :normal,
      row_1:     :light_blue_background,
      row_2:     :magenta_background,
      row_3:     :normal,
      bottom:    :normal
    ],
    key_attrs: [
      top:       :light_yellow,
      header:    :light_yellow,
      separator: :light_yellow,
      row_1:     [:light_yellow, :light_blue_background],
      row_2:     [:light_yellow, :magenta_background],
      row_3:     :light_yellow,
      bottom:    :light_yellow
    ],
    non_key_attrs: [
      top:       :light_yellow,
      header:    :light_yellow,
      separator: :light_yellow,
      row_1:     [:light_yellow, :light_blue_background],
      row_2:     [:light_yellow, :magenta_background],
      row_3:     :light_yellow,
      bottom:    :light_yellow
    ]
  },
  game_red: %{
    note: "red headers, 3 repeating row colors",
    rank: 300,
    borders: [
      #           left inner  right dash
      top:       ["╔", "═╤═", "╗",  "═"],
      header:    ["║",  "│" , "║",  nil],
      separator: ["╟", "─┼─", "╢",  "─"],
      row_1:     ["║",  "│" , "║",  nil],
      row_2:     ["║",  "│" , "║",  nil],
      row_3:     ["║",  "│" , "║",  nil],
      bottom:    ["╚", "═╧═", "╝",  "═"]
    ],
    border_attrs: :light_yellow,
    filler_attrs: [
      top:       :normal,
      header:    :normal,
      separator: :normal,
      row_1:     :light_blue_background,
      row_2:     :magenta_background,
      row_3:     :normal,
      bottom:    :normal
    ],
    key_attrs: [
      top:       :light_yellow,
      header:    :light_red,
      separator: :light_yellow,
      row_1:     [:light_red, :light_blue_background],
      row_2:     [:light_red, :magenta_background],
      row_3:     :light_red,
      bottom:    :light_yellow
    ],
    non_key_attrs: [
      top:       :light_yellow,
      header:    :light_red,
      separator: :light_yellow,
      row_1:     [:light_yellow, :light_blue_background],
      row_2:     [:light_yellow, :magenta_background],
      row_3:     :light_yellow,
      bottom:    :light_yellow
    ]
  }
]

# Comment out to compile debug, info and warn messages...
config :logger, compile_time_purge_level: :error

# Prevents runtime debug, info and warn messages...
config :logger, level: :error

# Listed by ascending log level...
config :logger, :console, colors: [
  debug: :light_cyan,
  info:  :light_green,
  warn:  :light_yellow,
  error: :light_red
]

# config :map_sorter, sorting_on_structs?: true

#     import_config "#{Mix.env}.exs"
