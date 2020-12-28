import Config

alias IO.ANSI.Plus, as: ANSI

i = "#{ANSI.format([:sandy_brown, :sandy_brown_background, "isl"], true)}"
f = "#{ANSI.format([:islamic_green, :islamic_green_background, "for"], true)}"
w = "#{ANSI.format([:dodger_blue, :dodger_blue_background, "wat"], true)}"
h = "#{ANSI.format([:islamic_green, :islamic_green_background, "hit"], true)}"
m = "#{ANSI.format([:mortar, :mortar_background, "mis"], true)}"

config :io_ansi_table, islands: [
  %{:row =>  1, 1 => i, 2 => f, 3 => w, 4 => w, 5  => w,
                6 => w, 7 => w, 8 => w, 9 => w, :A => w},
  %{:row =>  2, 1 => w, 2 => f, 3 => w, 4 => w, 5  => w,
                6 => w, 7 => w, 8 => w, 9 => w, :A => w},
  %{:row =>  3, 1 => i, 2 => f, 3 => w, 4 => w, 5  => w,
                6 => w, 7 => i, 8 => w, 9 => w, :A => w},
  %{:row =>  4, 1 => w, 2 => w, 3 => w, 4 => w, 5  => w,
                6 => w, 7 => i, 8 => w, 9 => w, :A => w},
  %{:row =>  5, 1 => w, 2 => w, 3 => w, 4 => w, 5  => w,
                6 => w, 7 => f, 8 => i, 9 => w, :A => w},
  %{:row =>  6, 1 => w, 2 => w, 3 => i, 4 => i, 5  => w,
                6 => w, 7 => w, 8 => w, 9 => w, :A => w},
  %{:row =>  7, 1 => w, 2 => i, 3 => i, 4 => w, 5  => w,
                6 => w, 7 => w, 8 => w, 9 => w, :A => w},
  %{:row =>  8, 1 => w, 2 => w, 3 => w, 4 => w, 5  => w,
                6 => w, 7 => w, 8 => w, 9 => w, :A => w},
  %{:row =>  9, 1 => w, 2 => w, 3 => w, 4 => w, 5  => i,
                6 => i, 7 => w, 8 => w, 9 => f, :A => w},
  %{:row => 10, 1 => w, 2 => w, 3 => w, 4 => w, 5  => i,
                6 => i, 7 => w, 8 => w, 9 => w, :A => w}
]

config :io_ansi_table, attacks: [
  %{:row =>  1, 1 => w, 2 => m, 3 => w, 4 => w, 5  => w,
                6 => w, 7 => w, 8 => w, 9 => w, :A => w},
  %{:row =>  2, 1 => w, 2 => w, 3 => w, 4 => w, 5  => w,
                6 => w, 7 => w, 8 => w, 9 => w, :A => w},
  %{:row =>  3, 1 => w, 2 => w, 3 => w, 4 => h, 5  => h,
                6 => w, 7 => w, 8 => w, 9 => w, :A => w},
  %{:row =>  4, 1 => w, 2 => w, 3 => w, 4 => w, 5  => w,
                6 => w, 7 => h, 8 => w, 9 => w, :A => w},
  %{:row =>  5, 1 => w, 2 => w, 3 => m, 4 => w, 5  => w,
                6 => w, 7 => w, 8 => h, 9 => w, :A => w},
  %{:row =>  6, 1 => w, 2 => w, 3 => w, 4 => w, 5  => w,
                6 => w, 7 => w, 8 => w, 9 => w, :A => w},
  %{:row =>  7, 1 => w, 2 => w, 3 => w, 4 => w, 5  => w,
                6 => w, 7 => w, 8 => w, 9 => w, :A => m},
  %{:row =>  8, 1 => w, 2 => w, 3 => w, 4 => m, 5  => w,
                6 => w, 7 => w, 8 => w, 9 => w, :A => w},
  %{:row =>  9, 1 => w, 2 => w, 3 => h, 4 => m, 5  => w,
                6 => w, 7 => w, 8 => w, 9 => w, :A => w},
  %{:row => 10, 1 => w, 2 => w, 3 => w, 4 => w, 5  => w,
                6 => w, 7 => w, 8 => w, 9 => w, :A => w}
]

config :io_ansi_table, islands_headers: [:row, 1, 2, 3, 4, 5, 6, 7, 8, 9, :A]

config :io_ansi_table, islands_options: [
  header_fixes: %{"Row" => "", "A" => "10"},
  align_specs: [right: :row,
    center: 1, center: 2, center: 3, center: 4, center: 5,
    center: 6, center: 7, center: 8, center: 9, center: :A
  ],
  sort_specs: [:row],
  sort_symbols: [asc: "", desc: "", pos: :trailing]
]

config :io_ansi_table, people_with_date_dobs: [
  %{name: "Mike", likes: "ski, arts", dob: ~D[1992-04-15], bmi: 23.9},
  %{name: "Mary", likes: "travels"  , dob: ~D[1992-04-15], bmi: 26.8},
  %{name: "Ann" , likes: "reading"  , dob: ~D[1992-04-15], bmi: 24.7},
  %{name: "Ray" , likes: "cycling"  , dob: ~D[1977-08-28], bmi: 19.1},
  %{name: "Bill", likes: "karate"   , dob: ~D[1977-08-28], bmi: 18.1},
  %{name: "Joe" , likes: "boxing"   , dob: ~D[1977-08-28], bmi: 20.8},
  %{name: "Jill", likes: "cooking"  , dob: ~D[1976-09-28], bmi: 25.8}
]

config :io_ansi_table, people_with_string_dobs: [
  %{name: "Mike", likes: "ski, arts", dob: "1992-04-15", bmi: 23.9},
  %{name: "Mary", likes: "travels"  , dob: "1992-04-15", bmi: 26.8},
  %{name: "Ann" , likes: "reading"  , dob: "1992-04-15", bmi: 24.7},
  %{name: "Ray" , likes: "cycling"  , dob: "1977-08-28", bmi: 19.1},
  %{name: "Bill", likes: "karate"   , dob: "1977-08-28", bmi: 18.1},
  %{name: "Joe" , likes: "boxing"   , dob: "1977-08-28", bmi: 20.8},
  %{name: "Jill", likes: "cooking"  , dob: "1976-09-28", bmi: 25.8}
]

config :io_ansi_table, people_headers: [:name, :dob, :likes, :bmi]

config :io_ansi_table, people_options: [
  bell: true,
  align_specs: [center: :dob, right: :bmi],
  sort_symbols: [asc: " ▲ ", desc: " ▼ ", pos: [:leading, :trailing]]
]
