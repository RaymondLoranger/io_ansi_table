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

# Example to adjust table position (up to 3 ways):
#
#     config :io_ansi_table, margins: [
#       top:    1, # line(s) before table
#       bottom: 1, # line(s) after table
#       left:   2  # space(s) left of table
#     ]

# Example of headers and key header to provide:
#
#     config :io_ansi_table, headers: [
#       "number", "created_at", "updated_at", "id", "title"
#     ]
#     config :io_ansi_table, key_header: "created_at"

config :io_ansi_table, ansi_enabled: true # table formatting in colors

config :io_ansi_table, default_margins: [ # default table position:
  top:    0, # line(s) before table
  bottom: 0, # line(s) after table
  left:   0  # space(s) left of table
]

config :io_ansi_table, line_types: [
  :top, :header, :separator, :data, :bottom
]

config :io_ansi_table, table_styles: %{
  light: %{
    note: "",
    rank: 10,
    borders: %{
      #           left  inner  right dash
      top:       {"┌─", "─┬─", "─┐", "─"},
      header:    {"│" ,  "│",   "│", nil},
      separator: {"├─", "─┼─", "─┤", "─"},
      data:      {"│" ,  "│",   "│", nil},
      bottom:    {"└─", "─┴─", "─┘", "─"}
    },
    border_widths: %{
      #           left    inner      right
      top:       {[2, 0], [0, 3, 0], [0, 2]},
      header:    {[1, 1], [1, 1, 1], [1, 1]},
      separator: {[2, 0], [0, 3, 0], [0, 2]},
      data:      {[1, 1], [1, 1, 1], [1, 1]},
      bottom:    {[2, 0], [0, 3, 0], [0, 2]}
    },
    attrs: %{
      border: :light_white,
      filler: :normal,
      header: {
        [:light_yellow, :underline], # key
        :light_yellow                # non key
      },
      data: {
        :light_cyan, # key
        :normal      # non key
      }
    }
  },
  medium: %{
    note: "",
    rank: 20,
    borders: %{
      #           left  inner  right dash
      top:       {"╔═", "═╤═", "═╗", "═"},
      header:    {"║",   "│" ,  "║", nil},
      separator: {"╟─", "─┼─", "─╢", "─"},
      data:      {"║" ,  "│" ,  "║", nil},
      bottom:    {"╚═", "═╧═", "═╝", "═"}
    },
    border_widths: %{
      #           left    inner      right
      top:       {[2, 0], [0, 3, 0], [0, 2]},
      header:    {[1, 1], [1, 1, 1], [1, 1]},
      separator: {[2, 0], [0, 3, 0], [0, 2]},
      data:      {[1, 1], [1, 1, 1], [1, 1]},
      bottom:    {[2, 0], [0, 3, 0], [0, 2]}
    },
    attrs: %{
      border: :light_yellow,
      filler: :normal,
      header: {
        [:light_green, :underline], # key
        :light_green                # non key
      },
      data: {
        :light_cyan, # key
        :normal      # non key
      }
    }
  },
  dark: %{
    note: "",
    rank: 30,
    borders: %{
      #           left  inner  right dash
      top:       {"╔═", "═╦═", "═╗", "═"},
      header:    {"║" ,  "║" ,  "║", nil},
      separator: {"╠═", "═╬═", "═╣", "═"},
      data:      {"║" ,  "║" ,  "║", nil},
      bottom:    {"╚═", "═╩═", "═╝", "═"}
    },
    border_widths: %{
      #           left    inner      right
      top:       {[2, 0], [0, 3, 0], [0, 2]},
      header:    {[1, 1], [1, 1, 1], [1, 1]},
      separator: {[2, 0], [0, 3, 0], [0, 2]},
      data:      {[1, 1], [1, 1, 1], [1, 1]},
      bottom:    {[2, 0], [0, 3, 0], [0, 2]}
    },
    attrs: %{
      border: :light_green,
      filler: :normal,
      header: {
        [:light_white, :light_red_background], # key
        :light_red                             # non key
      },
      data: {
        :light_magenta, # key
        :light_yellow   # non key
      }
    }
  },
  cyan: %{
    note: "light cyan background",
    rank: 40,
    borders: %{
      #           left  inner  right dash
      top:       {"╔═", "═╦═", "═╗", "═"},
      header:    {"║" ,  "║" ,  "║", nil},
      separator: {"╠═", "═╬═", "═╣", "═"},
      data:      {"║" ,  "║" ,  "║", nil},
      bottom:    {"╚═", "═╩═", "═╝", "═"}
    },
    border_widths: %{
      #           left    inner      right
      top:       {[2, 0], [0, 3, 0], [0, 2]},
      header:    {[1, 1], [1, 1, 1], [1, 1]},
      separator: {[2, 0], [0, 3, 0], [0, 2]},
      data:      {[1, 1], [1, 1, 1], [1, 1]},
      bottom:    {[2, 0], [0, 3, 0], [0, 2]}
    },
    attrs: %{
      border: [:light_blue, :light_cyan_background],
      filler: :light_cyan_background,
      header: {
        [:light_yellow, :light_red_background], # key
        [:light_red, :light_cyan_background  ]  # non key
      },
      data: {
        [:light_blue, :light_cyan_background], # key
        [:black, :light_cyan_background     ]  # non key
      }
    }
  },
  yellow: %{
    note: "light yellow background",
    rank: 50,
    borders: %{
      #           left  inner  right dash
      top:       {"╔═", "═╦═", "═╗", "═"},
      header:    {"║" ,  "║" ,  "║", nil},
      separator: {"╠═", "═╬═", "═╣", "═"},
      data:      {"║" ,  "║" ,  "║", nil},
      bottom:    {"╚═", "═╩═", "═╝", "═"}
    },
    border_widths: %{
      #           left    inner      right
      top:       {[2, 0], [0, 3, 0], [0, 2]},
      header:    {[1, 1], [1, 1, 1], [1, 1]},
      separator: {[2, 0], [0, 3, 0], [0, 2]},
      data:      {[1, 1], [1, 1, 1], [1, 1]},
      bottom:    {[2, 0], [0, 3, 0], [0, 2]}
    },
    attrs: %{
      border: [:green, :light_yellow_background],
      filler: :light_yellow_background,
      header: {
        [:light_white, :light_red_background ], # key
        [:light_red, :light_yellow_background]  # non key
      },
      data: {
        [:light_blue, :light_yellow_background], # key
        [:black, :light_yellow_background     ]  # non key
      }
    }
  },
  green: %{
    note: "light green background",
    rank: 60,
    borders: %{
      #           left  inner  right dash
      top:       {"╔═", "═╦═", "═╗", "═"},
      header:    {"║" ,  "║" ,  "║", nil},
      separator: {"╠═", "═╬═", "═╣", "═"},
      data:      {"║" ,  "║" ,  "║", nil},
      bottom:    {"╚═", "═╩═", "═╝", "═"}
    },
    border_widths: %{
      #           left    inner      right
      top:       {[2, 0], [0, 3, 0], [0, 2]},
      header:    {[1, 1], [1, 1, 1], [1, 1]},
      separator: {[2, 0], [0, 3, 0], [0, 2]},
      data:      {[1, 1], [1, 1, 1], [1, 1]},
      bottom:    {[2, 0], [0, 3, 0], [0, 2]}
    },
    attrs: %{
      border: [:light_yellow, :light_green_background],
      filler: :light_green_background,
      header: {
        [:light_yellow, :light_red_background], # key
        [:light_red, :light_green_background ]  # non key
      },
      data: {
        [:light_blue, :light_green_background], # key
        [:black, :light_green_background     ]  # non key
      }
    }
  },
  CYAN: %{
    note: "light cyan border",
    rank: 70,
    borders: %{
      #           left  inner  right dash
      top:       {"╔═", "═╦═", "═╗", "═"},
      header:    {"║" ,  "║" ,  "║", nil},
      separator: {"╠═", "═╬═", "═╣", "═"},
      data:      {"║" ,  "║" ,  "║", nil},
      bottom:    {"╚═", "═╩═", "═╝", "═"}
    },
    border_widths: %{
      #           left    inner      right
      top:       {[2, 0], [0, 3, 0], [0, 2]},
      header:    {[1, 1], [1, 1, 1], [1, 1]},
      separator: {[2, 0], [0, 3, 0], [0, 2]},
      data:      {[1, 1], [1, 1, 1], [1, 1]},
      bottom:    {[2, 0], [0, 3, 0], [0, 2]}
    },
    attrs: %{
      border: [:light_cyan, :light_cyan_background],
      filler: :normal,
      header: {
        [:light_white, :light_blue_background], # key
        :light_green                            # non key
      },
      data: {
        :light_yellow, # key
        :normal        # non key
      }
    }
  },
  YELLOW: %{
    note: "light yellow border",
    rank: 80,
    borders: %{
      #           left  inner  right dash
      top:       {"╔═", "═╦═", "═╗", "═"},
      header:    {"║" ,  "║" ,  "║", nil},
      separator: {"╠═", "═╬═", "═╣", "═"},
      data:      {"║" ,  "║" ,  "║", nil},
      bottom:    {"╚═", "═╩═", "═╝", "═"}
    },
    border_widths: %{
      #           left    inner      right
      top:       {[2, 0], [0, 3, 0], [0, 2]},
      header:    {[1, 1], [1, 1, 1], [1, 1]},
      separator: {[2, 0], [0, 3, 0], [0, 2]},
      data:      {[1, 1], [1, 1, 1], [1, 1]},
      bottom:    {[2, 0], [0, 3, 0], [0, 2]}
    },
    attrs: %{
      border: [:light_yellow, :light_yellow_background],
      filler: :normal,
      header: {
        [:light_white, :light_blue_background], # key
        :light_green                            # non key
      },
      data: {
        :light_yellow, # key
        :normal        # non key
      }
    }
  },
  GREEN: %{
    note: "light green border",
    rank: 90,
    borders: %{
      #           left  inner  right dash
      top:       {"╔═", "═╦═", "═╗", "═"},
      header:    {"║" ,  "║" ,  "║", nil},
      separator: {"╠═", "═╬═", "═╣", "═"},
      data:      {"║" ,  "║" ,  "║", nil},
      bottom:    {"╚═", "═╩═", "═╝", "═"}
    },
    border_widths: %{
      #           left    inner      right
      top:       {[2, 0], [0, 3, 0], [0, 2]},
      header:    {[1, 1], [1, 1, 1], [1, 1]},
      separator: {[2, 0], [0, 3, 0], [0, 2]},
      data:      {[1, 1], [1, 1, 1], [1, 1]},
      bottom:    {[2, 0], [0, 3, 0], [0, 2]}
    },
    attrs: %{
      border: [:light_green, :light_green_background],
      filler: :normal,
      header: {
        [:light_cyan, :reverse], # key
        :light_cyan              # non key
      },
      data: {
        :light_green, # key
        :normal       # non key
      }
    }
  },
  mixed: %{
    note: "fillers revealed",
    rank: 100,
    borders: %{
      #           left  inner  right dash
      top:       {"╔═", "═╦═", "═╗", "═"},
      header:    {"║" ,  "║" ,  "║", nil},
      separator: {"╠═", "═╬═", "═╣", "═"},
      data:      {"║" ,  "║" ,  "║", nil},
      bottom:    {"╚═", "═╩═", "═╝", "═"}
    },
    border_widths: %{
      #           left    inner      right
      top:       {[2, 0], [0, 3, 0], [0, 2]},
      header:    {[1, 1], [1, 1, 1], [1, 1]},
      separator: {[2, 0], [0, 3, 0], [0, 2]},
      data:      {[1, 1], [1, 1, 1], [1, 1]},
      bottom:    {[2, 0], [0, 3, 0], [0, 2]}
    },
    attrs: %{
      border: [:black, :light_yellow_background],
      filler: :light_green_background,
      header: {
        [:light_red, :reverse, :light_yellow_background], # key
        [:light_magenta, :light_white_background       ]  # non key
      },
      data: {
        [:light_blue, :light_yellow_background ], # key
        [:light_black, :light_yellow_background]  # non key
      }
    }
  },
  dotted: %{
    note: "slightly colored",
    rank: 110,
    borders: %{
      #           left  inner  right dash
      top:       {"┏╍", "╍┳╍", "╍┓", "╍"},
      header:    {"┇" ,  "┇" ,  "┇", nil},
      separator: {"┣╍", "╍╋╍", "╍┫", "╍"},
      data:      {"┇" ,  "┇" ,  "┇", nil},
      bottom:    {"┗╍", "╍┻╍", "╍┛", "╍"}
    },
    border_widths: %{
      #           left    inner      right
      top:       {[2, 0], [0, 3, 0], [0, 2]},
      header:    {[1, 1], [1, 1, 1], [1, 1]},
      separator: {[2, 0], [0, 3, 0], [0, 2]},
      data:      {[1, 1], [1, 1, 1], [1, 1]},
      bottom:    {[2, 0], [0, 3, 0], [0, 2]}
    },
    attrs: %{
      border: :normal,
      filler: :normal,
      header: {
        [:blue, :light_yellow_background], # key
        :normal                            # non key
      },
      data: {
        :light_yellow, # key
        :normal        # non key
      }
    }
  },
  dashed: %{
    note: "no colors",
    rank: 120,
    borders: %{
      #           left  inner  right dash
      top:       {"+-", "-+-", "-+", "-"},
      header:    {"|" ,  "|" ,  "|", nil},
      separator: {"+-", "-+-", "-+", "-"},
      data:      {"|" ,  "|" ,  "|", nil},
      bottom:    {"+-", "-+-", "-+", "-"}
    },
    border_widths: %{
      #           left    inner      right
      top:       {[2, 0], [0, 3, 0], [0, 2]},
      header:    {[1, 1], [1, 1, 1], [1, 1]},
      separator: {[2, 0], [0, 3, 0], [0, 2]},
      data:      {[1, 1], [1, 1, 1], [1, 1]},
      bottom:    {[2, 0], [0, 3, 0], [0, 2]}
    },
    attrs: %{
      border: :normal,
      filler: :normal,
      header: {
        :normal, # key
        :normal  # non key
      },
      data: {
        :normal, # key
        :normal  # non key
      }
    }
  },
  plain: %{
    note: "slightly colored",
    rank: 130,
    borders: %{
      #           left  inner  right dash
      top:       {"┌─", "─┬─", "─┐", "─"},
      header:    {"│" ,  "│" ,  "│", nil},
      separator: {"├─", "─┼─", "─┤", "─"},
      data:      {"│" ,  "│" ,  "│", nil},
      bottom:    {"└─", "─┴─", "─┘", "─"}
    },
    border_widths: %{
      #           left    inner      right
      top:       {[2, 0], [0, 3, 0], [0, 2]},
      header:    {[1, 1], [1, 1, 1], [1, 1]},
      separator: {[2, 0], [0, 3, 0], [0, 2]},
      data:      {[1, 1], [1, 1, 1], [1, 1]},
      bottom:    {[2, 0], [0, 3, 0], [0, 2]}
    },
    attrs: %{
      border: :light_yellow,
      filler: :normal,
      header: {
        [:light_yellow, :underline], # key
        :light_yellow                # non key
      },
      data: {
        :light_yellow, # key
        :normal        # non key
      }
    }
  },
  test: %{
    note: "no colors",
    rank: 140,
    borders: %{
      #           left  inner  right dash
      top:       {"┌─", "─┬─", "─┐", "─"},
      header:    {"│" ,  "│" ,  "│", nil},
      separator: {"├─", "─┼─", "─┤", "─"},
      data:      {"│" ,  "│" ,  "│", nil},
      bottom:    {"└─", "─┴─", "─┘", "─"}
    },
    border_widths: %{
      #           left    inner      right
      top:       {[2, 0], [0, 3, 0], [0, 2]},
      header:    {[1, 1], [1, 1, 1], [1, 1]},
      separator: {[2, 0], [0, 3, 0], [0, 2]},
      data:      {[1, 1], [1, 1, 1], [1, 1]},
      bottom:    {[2, 0], [0, 3, 0], [0, 2]}
    },
    attrs: %{
      border: :normal,
      filler: :normal,
      header: {
        :normal, # key
        :normal  # non key
      },
      data: {
        :normal, # key
        :normal  # non key
      }
    }
  },
  bare: %{
    note: "no colors",
    rank: 150,
    borders: %{
      #           left inner  right dash
      top:       {"",   ""  , "",   "" },
      header:    {"",   "|" , "",   nil},
      separator: {"",  "-+-", "",   "-"},
      data:      {"",   "|" , "",   nil},
      bottom:    {"",   ""  , "",   "" }
    },
    border_widths: %{
      #           left    inner      right
      top:       {[0, 0], [0, 0, 0], [0, 0]},
      header:    {[0, 0], [1, 1, 1], [0, 0]},
      separator: {[0, 0], [0, 3, 0], [0, 0]},
      data:      {[0, 0], [1, 1, 1], [0, 0]},
      bottom:    {[0, 0], [0, 0, 0], [0, 0]}
    },
    attrs: %{
      border: :normal,
      filler: :normal,
      header: {
        :normal, # key
        :normal  # non key
      },
      data: {
        :normal, # key
        :normal  # non key
      }
    }
  },
  barish: %{
    note: "like bare but colored",
    rank: 160,
    borders: %{
      #           left inner  right dash
      top:       {"",   ""  , "",   "" },
      header:    {"",   "|" , "",   nil},
      separator: {"",  "-+-", "",   "-"},
      data:      {"",   "|" , "",   nil},
      bottom:    {"",   ""  , "",   "" }
    },
    border_widths: %{
      #           left    inner      right
      top:       {[0, 0], [0, 0, 0], [0, 0]},
      header:    {[0, 0], [1, 1, 1], [0, 0]},
      separator: {[0, 0], [0, 3, 0], [0, 0]},
      data:      {[0, 0], [1, 1, 1], [0, 0]},
      bottom:    {[0, 0], [0, 0, 0], [0, 0]}
    },
    attrs: %{
      border: :light_yellow,
      filler: :normal,
      header: {
        :light_green, # key
        :normal       # non key
      },
      data: {
        :light_cyan, # key
        :normal      # non key
      }
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
