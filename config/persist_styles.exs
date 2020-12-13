import Config

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
      top:       :light_white,
      header:    [:gold, :underline],
      separator: :light_white,
      row:       :chartreuse,
      bottom:    :light_white
    ],
    non_key_attrs: [
      top:       :light_white,
      header:    :gold,
      separator: :light_white,
      row:       :light_white,
      bottom:    :light_white
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
      even_row:  :blue_background,
      odd_row:   :normal,
      bottom:    :normal
    ],
    key_attrs: [
      top:       :light_white,
      header:    [:gold, :underline],
      separator: :light_white,
      even_row:  [:chartreuse, :blue_background],
      odd_row:   :chartreuse,
      bottom:    :light_white
    ],
    non_key_attrs: [
      top:       :light_white,
      header:    :gold,
      separator: :light_white,
      even_row:  [:light_white, :blue_background],
      odd_row:   :light_white,
      bottom:    :light_white
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
      row_1:     :blue_background,
      row_2:     :red_background,
      row_3:     :normal,
      bottom:    :normal
    ],
    key_attrs: [
      top:       :light_white,
      header:    [:gold, :underline],
      separator: :light_white,
      row_1:     [:chartreuse, :blue_background],
      row_2:     [:chartreuse, :red_background],
      row_3:     :chartreuse,
      bottom:    :light_white
    ],
    non_key_attrs: [
      top:       :light_white,
      header:    :gold,
      separator: :light_white,
      row_1:     [:light_white, :blue_background],
      row_2:     [:light_white, :red_background],
      row_3:     :light_white,
      bottom:    :light_white
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
    border_attrs: :gold,
    filler_attrs: :normal,
    key_attrs: [
      top:       :gold,
      header:    [:canary, :underline],
      separator: :gold,
      row:       :aqua,
      bottom:    :gold
    ],
    non_key_attrs: [
      top:       :gold,
      header:    :canary,
      separator: :gold,
      row:       :gold,
      bottom:    :gold
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
    border_attrs: :gold,
    filler_attrs: [
      top:       :normal,
      header:    :normal,
      separator: :normal,
      even_row:  :blue_background,
      odd_row:   :normal,
      bottom:    :normal
    ],
    key_attrs: [
      top:       :gold,
      header:    [:canary, :underline],
      separator: :gold,
      even_row:  [:aqua, :blue_background],
      odd_row:   :aqua,
      bottom:    :gold
    ],
    non_key_attrs: [
      top:       :gold,
      header:    :canary,
      separator: :gold,
      even_row:  [:gold, :blue_background],
      odd_row:   :gold,
      bottom:    :gold
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
    border_attrs: :gold,
    filler_attrs: [
      top:       :normal,
      header:    :normal,
      separator: :normal,
      row_1:     :blue_background,
      row_2:     :red_background,
      row_3:     :normal,
      bottom:    :normal
    ],
    key_attrs: [
      top:       :gold,
      header:    [:canary, :underline],
      separator: :gold,
      row_1:     [:aqua, :blue_background],
      row_2:     [:aqua, :red_background],
      row_3:     :aqua,
      bottom:    :gold
    ],
    non_key_attrs: [
      top:       :gold,
      header:    :canary,
      separator: :gold,
      row_1:     [:gold, :blue_background],
      row_2:     [:gold, :red_background],
      row_3:     :gold,
      bottom:    :gold
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
    border_attrs: :chartreuse,
    filler_attrs: :normal,
    key_attrs: [
      top:       :chartreuse,
      header:    [:light_white, :psychedelic_purple_background],
      separator: :chartreuse,
      row:       :light_white,
      bottom:    :chartreuse
    ],
    non_key_attrs: [
      top:       :chartreuse,
      header:    :chartreuse,
      separator: :chartreuse,
      row:       :chartreuse,
      bottom:    :chartreuse
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
    border_attrs: :chartreuse,
    filler_attrs: [
      top:       :normal,
      header:    :normal,
      separator: :normal,
      even_row:  :blue_background,
      odd_row:   :normal,
      bottom:    :normal
    ],
    key_attrs: [
      top:       :chartreuse,
      header:    [:light_white, :psychedelic_purple_background],
      separator: :chartreuse,
      even_row:  [:light_white, :blue_background],
      odd_row:   :light_white,
      bottom:    :chartreuse
    ],
    non_key_attrs: [
      top:       :chartreuse,
      header:    :chartreuse,
      separator: :chartreuse,
      even_row:  [:chartreuse, :blue_background],
      odd_row:   :chartreuse,
      bottom:    :chartreuse
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
    border_attrs: :chartreuse,
    filler_attrs: [
      top:       :normal,
      header:    :normal,
      separator: :normal,
      row_1:     :blue_background,
      row_2:     :red_background,
      row_3:     :normal,
      bottom:    :normal
    ],
    key_attrs: [
      top:       :chartreuse,
      header:    [:light_white, :psychedelic_purple_background],
      separator: :chartreuse,
      row_1:     [:light_white, :blue_background],
      row_2:     [:light_white, :red_background],
      row_3:     :light_white,
      bottom:    :chartreuse
    ],
    non_key_attrs: [
      top:       :chartreuse,
      header:    :chartreuse,
      separator: :chartreuse,
      row_1:     [:chartreuse, :blue_background],
      row_2:     [:chartreuse, :red_background],
      row_3:     :chartreuse,
      bottom:    :chartreuse
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
    border_attrs: :fuchsia,
    filler_attrs: :normal,
    key_attrs: [
      top:       :fuchsia,
      header:    :deep_sky_blue,
      separator: :fuchsia,
      row:       :light_white,
      bottom:    :fuchsia
    ],
    non_key_attrs: [
      top:       :fuchsia,
      header:    :pale_green,
      separator: :fuchsia,
      row:       :gold,
      bottom:    :fuchsia
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
    border_attrs: :fuchsia,
    filler_attrs: [
      top:       :normal,
      header:    :normal,
      separator: :normal,
      even_row:  :blue_background,
      odd_row:   :normal,
      bottom:    :normal
    ],
    key_attrs: [
      top:       :fuchsia,
      header:    :deep_sky_blue,
      separator: :fuchsia,
      even_row:  [:light_white, :blue_background],
      odd_row:   :light_white,
      bottom:    :fuchsia
    ],
    non_key_attrs: [
      top:       :fuchsia,
      header:    :pale_green,
      separator: :fuchsia,
      even_row:  [:gold, :blue_background],
      odd_row:   :gold,
      bottom:    :fuchsia
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
    border_attrs: :fuchsia,
    filler_attrs: [
      top:       :normal,
      header:    :normal,
      separator: :normal,
      row_1:     :blue_background,
      row_2:     :red_background,
      row_3:     :normal,
      bottom:    :normal
    ],
    key_attrs: [
      top:       :fuchsia,
      header:    :deep_sky_blue,
      separator: :fuchsia,
      row_1:     [:light_white, :blue_background],
      row_2:     [:light_white, :red_background],
      row_3:     :light_white,
      bottom:    :fuchsia
    ],
    non_key_attrs: [
      top:       :fuchsia,
      header:    :pale_green,
      separator: :fuchsia,
      row_1:     [:gold, :blue_background],
      row_2:     [:gold, :red_background],
      row_3:     :gold,
      bottom:    :fuchsia
    ]
  },
  cyan: %{
    note: "cyan background",
    rank: 50,
    borders: [
      #           left  inner  right dash
      top:       ["╔═", "═╦═", "═╗", "═"],
      header:    ["║" ,  "║" ,  "║", nil],
      separator: ["╠═", "═╬═", "═╣", "═"],
      row:       ["║" ,  "║" ,  "║", nil],
      bottom:    ["╚═", "═╩═", "═╝", "═"]
    ],
    border_attrs: [:light_white, :cyan_background],
    filler_attrs: :cyan_background,
    key_attrs: [
      top:       [:light_white, :cyan_background],
      header:    [:light_white, :blue_background],
      separator: [:light_white, :cyan_background],
      row:       [:light_white, :cyan_background],
      bottom:    [:light_white, :cyan_background]
    ],
    non_key_attrs: [
      top:       [:light_white, :cyan_background],
      header:    [:light_white, :cyan_background],
      separator: [:light_white, :cyan_background],
      row:       [:black, :cyan_background],
      bottom:    [:light_white, :cyan_background]
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
    border_attrs: [:blue, :light_yellow_background],
    filler_attrs: :light_yellow_background,
    key_attrs: [
      top:       [:blue, :light_yellow_background],
      header:    [:light_white, :blue_background],
      separator: [:blue, :light_yellow_background],
      row:       [:blue, :light_yellow_background],
      bottom:    [:blue, :light_yellow_background]
    ],
    non_key_attrs: [
      top:       [:blue, :light_yellow_background],
      header:    [:blue, :light_yellow_background],
      separator: [:blue, :light_yellow_background],
      row:       [:black, :light_yellow_background],
      bottom:    [:blue, :light_yellow_background]
    ]
  },
  green: %{
    note: "green background",
    rank: 70,
    borders: [
      #           left  inner  right dash
      top:       ["╔═", "═╦═", "═╗", "═"],
      header:    ["║" ,  "║" ,  "║", nil],
      separator: ["╠═", "═╬═", "═╣", "═"],
      row:       ["║" ,  "║" ,  "║", nil],
      bottom:    ["╚═", "═╩═", "═╝", "═"]
    ],
    border_attrs: [:light_white, :green_background],
    filler_attrs: :green_background,
    key_attrs: [
      top:       [:light_white, :green_background],
      header:    [:light_white, :light_red_background],
      separator: [:light_white, :green_background],
      row:       [:light_white, :green_background],
      bottom:    [:light_white, :green_background]
    ],
    non_key_attrs: [
      top:       [:light_white, :green_background],
      header:    [:light_white, :green_background],
      separator: [:light_white, :green_background],
      row:       [:black, :green_background],
      bottom:    [:light_white, :green_background]
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
      header:    :light_white,
      separator: [:light_cyan, :light_cyan_background],
      row:       :light_white,
      bottom:    [:light_cyan, :light_cyan_background]
    ],
    non_key_attrs: [
      top:       [:light_cyan, :light_cyan_background],
      header:    :light_cyan,
      separator: [:light_cyan, :light_cyan_background],
      row:       :light_cyan,
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
      header:    :light_white,
      separator: [:light_yellow, :light_yellow_background],
      row:       :light_white,
      bottom:    [:light_yellow, :light_yellow_background]
    ],
    non_key_attrs: [
      top:       [:light_yellow, :light_yellow_background],
      header:    :light_yellow,
      separator: [:light_yellow, :light_yellow_background],
      row:       :light_yellow,
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
      header:    :light_white,
      separator: [:light_green, :light_green_background],
      row:       :light_white,
      bottom:    [:light_green, :light_green_background]
    ],
    non_key_attrs: [
      top:       [:light_green, :light_green_background],
      header:    :light_green,
      separator: [:light_green, :light_green_background],
      row:       :light_green,
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
    filler_attrs: :green_background,
    key_attrs: [
      top:       [:black, :light_yellow_background],
      header:    [:light_red, :reverse, :light_yellow_background],
      separator: [:black, :light_yellow_background],
      row:       [:blue, :light_yellow_background],
      bottom:    [:black, :light_yellow_background]
    ],
    non_key_attrs: [
      top:       [:black, :light_yellow_background],
      header:    [:magenta, :light_white_background],
      separator: [:black, :light_yellow_background],
      row:       [:black, :light_yellow_background],
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
    border_attrs: :light_white,
    filler_attrs: :normal,
    key_attrs: [
      top:       :light_white,
      header:    [:light_white, :dark_green_background],
      separator: :light_white,
      row:       :spring_green,
      bottom:    :light_white
    ],
    non_key_attrs: :light_white,
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
    border_attrs: :light_white,
    filler_attrs: [
      top:       :normal,
      header:    :normal,
      separator: :normal,
      even_row:  :blue_background,
      odd_row:   :normal,
      bottom:    :normal
    ],
    key_attrs: [
      top:       :light_white,
      header:    [:light_white, :dark_green_background],
      separator: :light_white,
      even_row:  [:spring_green, :blue_background],
      odd_row:   :spring_green,
      bottom:    :light_white
    ],
    non_key_attrs: [
      top:       :light_white,
      header:    :light_white,
      separator: :light_white,
      even_row:  [:light_white, :blue_background],
      odd_row:   :light_white,
      bottom:    :light_white
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
    border_attrs: :light_white,
    filler_attrs: [
      top:       :normal,
      header:    :normal,
      separator: :normal,
      row_1:     :blue_background,
      row_2:     :red_background,
      row_3:     :normal,
      bottom:    :normal
    ],
    key_attrs: [
      top:       :light_white,
      header:    [:light_white, :dark_green_background],
      separator: :light_white,
      row_1:     [:spring_green, :blue_background],
      row_2:     [:spring_green, :red_background],
      row_3:     [:spring_green, :normal],
      bottom:    :light_white
    ],
    non_key_attrs: [
      top:       :light_white,
      header:    :light_white,
      separator: :light_white,
      row_1:     [:light_white, :blue_background],
      row_2:     [:light_white, :red_background],
      row_3:     :light_white,
      bottom:    :light_white
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
    border_attrs: [:light_white, :green_background],
    filler_attrs: :green_background,
    key_attrs: [
      top:       [:light_white, :green_background],
      header:    [:light_white, :light_red_background],
      separator: [:light_white, :green_background],
      row:       [:light_white, :green_background],
      bottom:    [:light_white, :green_background]
    ],
    non_key_attrs: [
      top:       [:light_white, :green_background],
      header:    [:light_white, :green_background],
      separator: [:light_white, :green_background],
      row:       [:black, :green_background],
      bottom:    [:light_white, :green_background]
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
    border_attrs: [:light_white, :green_background],
    filler_attrs: :green_background,
    key_attrs: [
      top:       [:light_white, :green_background],
      header:    [:light_white, :light_red_background],
      separator: [:light_white, :green_background],
      row:       [:light_white, :green_background],
      bottom:    [:light_white, :green_background]
    ],
    non_key_attrs: [
      top:       [:light_white, :green_background],
      header:    [:light_white, :green_background],
      separator: [:light_white, :green_background],
      row:       [:black, :green_background],
      bottom:    [:light_white, :green_background]
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
      header:    :light_white,
      separator: [:light_green, :light_green_background],
      row:       :light_white,
      bottom:    [:light_green, :light_green_background]
    ],
    non_key_attrs: [
      top:       [:light_green, :light_green_background],
      header:    :light_green,
      separator: [:light_green, :light_green_background],
      row:       :light_green,
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
      header:    :light_white,
      separator: [:light_green, :light_green_background],
      row:       :light_white,
      bottom:    [:light_green, :light_green_background]
    ],
    non_key_attrs: [
      top:       [:light_green, :light_green_background],
      header:    :light_green,
      separator: [:light_green, :light_green_background],
      row:       :light_green,
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
      top:       [:dark_cyan, :dark_cyan_background],
      header:    [:dark_cyan, :dark_cyan_background],
      separator: [:dark_cyan, :dark_cyan_background],
      even_row:  [:aqua, :aqua_background],
      odd_row:   [:chartreuse_yellow, :chartreuse_yellow_background]
    ],
    filler_attrs: [
      top:       :dark_cyan_background,
      header:    :dark_cyan_background,
      separator: :dark_cyan_background,
      even_row:  :aqua_background,
      odd_row:   :chartreuse_yellow_background
    ],
    key_attrs: [
      top:       [:dark_cyan, :dark_cyan_background],
      header:    [:light_white, :dark_cyan_background, :underline],
      separator: [:dark_cyan, :dark_cyan_background],
      even_row:  [:free_speech_red, :aqua_background],
      odd_row:   [:free_speech_red, :chartreuse_yellow_background]
    ],
    non_key_attrs: [
      top:       [:dark_cyan, :dark_cyan_background],
      header:    [:light_white, :dark_cyan_background],
      separator: [:dark_cyan, :dark_cyan_background],
      even_row:  [:black, :aqua_background],
      odd_row:   [:black, :chartreuse_yellow_background]
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
      top:       [:dark_cyan, :dark_cyan_background],
      header:    [:dark_cyan, :dark_cyan_background],
      separator: [:dark_cyan, :dark_cyan_background],
      row_1:     [:aqua, :aqua_background],
      row_2:     [:screamin_green, :screamin_green_background],
      row_3:     [:chartreuse_yellow, :chartreuse_yellow_background]
    ],
    filler_attrs: [
      top:       :dark_cyan_background,
      header:    :dark_cyan_background,
      separator: :dark_cyan_background,
      row_1:     :aqua_background,
      row_2:     :screamin_green_background,
      row_3:     :chartreuse_yellow_background
    ],
    key_attrs: [
      top:       [:dark_cyan, :dark_cyan_background],
      header:    [:light_white, :dark_cyan_background, :underline],
      separator: [:dark_cyan, :dark_cyan_background],
      row_1:     [:free_speech_red, :aqua_background],
      row_2:     [:free_speech_red, :screamin_green_background],
      row_3:     [:free_speech_red, :chartreuse_yellow_background]
    ],
    non_key_attrs: [
      top:       [:dark_cyan, :dark_cyan_background],
      header:    [:light_white, :dark_cyan_background],
      separator: [:dark_cyan, :dark_cyan_background],
      row_1:     [:black, :aqua_background],
      row_2:     [:black, :screamin_green_background],
      row_3:     [:black, :chartreuse_yellow_background]
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
      top:       [:dark_green, :dark_green_background],
      header:    [:dark_green, :dark_green_background],
      separator: [:dark_green, :dark_green_background],
      even_row:  [:aqua, :aqua_background],
      odd_row:   [:chartreuse_yellow, :chartreuse_yellow_background]
    ],
    filler_attrs: [
      top:       :dark_green_background,
      header:    :dark_green_background,
      separator: :dark_green_background,
      even_row:  :aqua_background,
      odd_row:   :chartreuse_yellow_background
    ],
    key_attrs: [
      top:       [:dark_green, :dark_green_background],
      header:    [:light_white, :dark_green_background, :underline],
      separator: [:dark_green, :dark_green_background],
      even_row:  [:free_speech_red, :aqua_background],
      odd_row:   [:free_speech_red, :chartreuse_yellow_background]
    ],
    non_key_attrs: [
      top:       [:dark_green, :dark_green_background],
      header:    [:light_white, :dark_green_background],
      separator: [:dark_green, :dark_green_background],
      even_row:  [:black, :aqua_background],
      odd_row:   [:black, :chartreuse_yellow_background]
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
      top:       [:dark_green, :dark_green_background],
      header:    [:dark_green, :dark_green_background],
      separator: [:dark_green, :dark_green_background],
      row_1:     [:aqua, :aqua_background],
      row_2:     [:screamin_green, :screamin_green_background],
      row_3:     [:chartreuse_yellow, :chartreuse_yellow_background]
    ],
    filler_attrs: [
      top:       :dark_green_background,
      header:    :dark_green_background,
      separator: :dark_green_background,
      row_1:     :aqua_background,
      row_2:     :screamin_green_background,
      row_3:     :chartreuse_yellow_background
    ],
    key_attrs: [
      top:       [:dark_green, :dark_green_background],
      header:    [:light_white, :dark_green_background, :underline],
      separator: [:dark_green, :dark_green_background],
      row_1:     [:free_speech_red, :aqua_background],
      row_2:     [:free_speech_red, :screamin_green_background],
      row_3:     [:free_speech_red, :chartreuse_yellow_background]
    ],
    non_key_attrs: [
      top:       [:dark_green, :dark_green_background],
      header:    [:light_white, :dark_green_background],
      separator: [:dark_green, :dark_green_background],
      row_1:     [:black, :aqua_background],
      row_2:     [:black, :screamin_green_background],
      row_3:     [:black, :chartreuse_yellow_background]
    ]
  },
  game: %{
    note: "game board",
    rank: 255,
    borders: [
      #        left inner right dash
      header: ["",  "",   "",   nil],
      row:    ["",  "",   "",   nil],
    ],
    border_attrs: :normal,
    filler_attrs: :normal,
    key_attrs: [
      header: :normal,
      row:    :normal
    ],
    non_key_attrs: [
      header: :normal,
      row:    :normal
    ]
  }
]
