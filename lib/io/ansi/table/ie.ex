defmodule IO.ANSI.Table.IE do
  @moduledoc false

  # Functions for iex session...
  #
  # Examples:
  #   use IO.ANSI.Table.IE
  #   people()
  #   people_sorted() # to test sorting on structs, see below..
  #   people_as_keywords()
  #   people_sorted_as_keywords()
  #   print_people(:dotted_mult)
  #   put_env(:pretty_alt)
  #   people() |> Table.format()
  #   GenServer.stop(Server, :shutdown)
  #   people() |> Table.format()
  #   print_people(:dotted_mult)
  #   print_people(:dotted_mult, 9)
  #   print_people_as_keywords(:green_mult)
  #   print_people_as_keywords(:green_mult, 9)
  #   styles()
  #   styles(:light_green)
  #   Style.styles()
  #   print_islands([:medium, :medium_alt, :medium_mult])
  #   print_islands()
  #   print_islands(:game)
  #   print_people([:pretty_alt, :dotted_alt, :medium_alt])
  #   print_people()
  #   Application.put_env(:io_ansi_table, :async, true)
  #   r(Table)
  #   print_people([:pretty_alt, :dotted_alt, :medium_alt])
  #   print_people()

  alias IO.ANSI.Plus, as: ANSI
  alias IO.ANSI.Table
  alias IO.ANSI.Table.Style

  require MapSorter

  @align_specs [center: :dob, right: :weight]
  @headers [:name, :dob, :likes, :bmi]
  @header_fixes %{"Dob" => "DOB", "Bmi" => "BMI"}

  @i "#{ANSI.format([:sandy_brown, :sandy_brown_background, "isl"], true)}"
  @f "#{ANSI.format([:islamic_green, :islamic_green_background, "for"], true)}"
  @w "#{ANSI.format([:dodger_blue, :dodger_blue_background, "wat"], true)}"
  @h "#{ANSI.format([:islamic_green, :islamic_green_background, "hit"], true)}"
  @m "#{ANSI.format([:mortar, :mortar_background, "mis"], true)}"

  @islands [
    %{:row =>  1, 1 => @i, 2 => @f, 3 => @w, 4 => @w, 5  => @w,
                  6 => @w, 7 => @w, 8 => @w, 9 => @w, :A => @w},
    %{:row =>  2, 1 => @w, 2 => @f, 3 => @w, 4 => @w, 5  => @w,
                  6 => @w, 7 => @w, 8 => @w, 9 => @w, :A => @w},
    %{:row =>  3, 1 => @i, 2 => @f, 3 => @w, 4 => @w, 5  => @w,
                  6 => @w, 7 => @i, 8 => @w, 9 => @w, :A => @w},
    %{:row =>  4, 1 => @w, 2 => @w, 3 => @w, 4 => @w, 5  => @w,
                  6 => @w, 7 => @i, 8 => @w, 9 => @w, :A => @w},
    %{:row =>  5, 1 => @w, 2 => @w, 3 => @w, 4 => @w, 5  => @w,
                  6 => @w, 7 => @f, 8 => @i, 9 => @w, :A => @w},
    %{:row =>  6, 1 => @w, 2 => @w, 3 => @i, 4 => @i, 5  => @w,
                  6 => @w, 7 => @w, 8 => @w, 9 => @w, :A => @w},
    %{:row =>  7, 1 => @w, 2 => @i, 3 => @i, 4 => @w, 5  => @w,
                  6 => @w, 7 => @w, 8 => @w, 9 => @w, :A => @w},
    %{:row =>  8, 1 => @w, 2 => @w, 3 => @w, 4 => @w, 5  => @w,
                  6 => @w, 7 => @w, 8 => @w, 9 => @w, :A => @w},
    %{:row =>  9, 1 => @w, 2 => @w, 3 => @w, 4 => @w, 5  => @i,
                  6 => @i, 7 => @w, 8 => @w, 9 => @f, :A => @w},
    %{:row => 10, 1 => @w, 2 => @w, 3 => @w, 4 => @w, 5  => @i,
                  6 => @i, 7 => @w, 8 => @w, 9 => @w, :A => @w}
  ]

  @attacks [
    %{:row =>  1, 1 => @w, 2 => @m, 3 => @w, 4 => @w, 5  => @w,
                  6 => @w, 7 => @w, 8 => @w, 9 => @w, :A => @w},
    %{:row =>  2, 1 => @w, 2 => @w, 3 => @w, 4 => @w, 5  => @w,
                  6 => @w, 7 => @w, 8 => @w, 9 => @w, :A => @w},
    %{:row =>  3, 1 => @w, 2 => @w, 3 => @w, 4 => @h, 5  => @h,
                  6 => @w, 7 => @w, 8 => @w, 9 => @w, :A => @w},
    %{:row =>  4, 1 => @w, 2 => @w, 3 => @w, 4 => @w, 5  => @w,
                  6 => @w, 7 => @h, 8 => @w, 9 => @w, :A => @w},
    %{:row =>  5, 1 => @w, 2 => @w, 3 => @m, 4 => @w, 5  => @w,
                  6 => @w, 7 => @w, 8 => @h, 9 => @w, :A => @w},
    %{:row =>  6, 1 => @w, 2 => @w, 3 => @w, 4 => @w, 5  => @w,
                  6 => @w, 7 => @w, 8 => @w, 9 => @w, :A => @w},
    %{:row =>  7, 1 => @w, 2 => @w, 3 => @w, 4 => @w, 5  => @w,
                  6 => @w, 7 => @w, 8 => @w, 9 => @w, :A => @m},
    %{:row =>  8, 1 => @w, 2 => @w, 3 => @w, 4 => @m, 5  => @w,
                  6 => @w, 7 => @w, 8 => @w, 9 => @w, :A => @w},
    %{:row =>  9, 1 => @w, 2 => @w, 3 => @h, 4 => @m, 5  => @w,
                  6 => @w, 7 => @w, 8 => @w, 9 => @w, :A => @w},
    %{:row => 10, 1 => @w, 2 => @w, 3 => @w, 4 => @w, 5  => @w,
                  6 => @w, 7 => @w, 8 => @w, 9 => @w, :A => @w}
  ]

  @margins [top: 1, bottom: 0]

  # Using @people with struct dob's requires to...
  # - config :map_sorter, sorting_on_structs?: true
  # - mix deps.compile map_sorter

  # struct dob's...
  @people [
    %{name: "Mike", likes: "ski, arts", dob: ~D[1992-04-15], bmi: 23.9},
    %{name: "Mary", likes: "travels"  , dob: ~D[1992-04-15], bmi: 26.8},
    %{name: "Ann" , likes: "reading"  , dob: ~D[1992-04-15], bmi: 24.7},
    %{name: "Ray" , likes: "cycling"  , dob: ~D[1977-08-28], bmi: 19.1},
    %{name: "Bill", likes: "karate"   , dob: ~D[1977-08-28], bmi: 18.1},
    %{name: "Joe" , likes: "boxing"   , dob: ~D[1977-08-28], bmi: 20.8},
    %{name: "Jill", likes: "cooking"  , dob: ~D[1976-09-28], bmi: 25.8}
  ]

  # string dob's...
  @people [
    %{name: "Mike", likes: "ski, arts", dob: "1992-04-15", bmi: 23.9},
    %{name: "Mary", likes: "travels"  , dob: "1992-04-15", bmi: 26.8},
    %{name: "Ann" , likes: "reading"  , dob: "1992-04-15", bmi: 24.7},
    %{name: "Ray" , likes: "cycling"  , dob: "1977-08-28", bmi: 19.1},
    %{name: "Bill", likes: "karate"   , dob: "1977-08-28", bmi: 18.1},
    %{name: "Joe" , likes: "boxing"   , dob: "1977-08-28", bmi: 20.8},
    %{name: "Jill", likes: "cooking"  , dob: "1976-09-28", bmi: 25.8}
  ]

  @sort_specs [:dob, desc: :likes]
  @sort_symbols [asc: "▲", desc: "▼", pos: :trailing]

  defmacro __using__(_options) do
    quote do
      import unquote(__MODULE__)
      alias unquote(__MODULE__)
      alias IO.ANSI.Plus, as: ANSI
      alias IO.ANSI.Table.{App, Column, Config, Formatter, Heading}
      alias IO.ANSI.Table.{Line_Type, Line, Options, Row, Server, Spec, Style}
      alias IO.ANSI.Table
      require MapSorter
      :ok
    end
  end

  def people(), do: @people()

  def people_as_keywords(), do: Enum.map(@people, &Keyword.new/1)

  def print_people(styles \\ Style.styles())

  def print_people(styles) when is_list(styles) do
    Enum.each(styles, &print_people/1)
  end

  def print_people(style) do
    Table.format(
      @people,
      bell: true,
      count: length(@people),
      style: style,
      headers: @headers,
      header_fixes: @header_fixes,
      sort_specs: @sort_specs,
      align_specs: @align_specs,
      margins: @margins
    )
  end

  def put_env(style) do
    Application.put_env(:io_ansi_table, :bell, true)
    Application.put_env(:io_ansi_table, :count, length(@people))
    Application.put_env(:io_ansi_table, :style, style)
    Application.put_env(:io_ansi_table, :headers, @headers)
    Application.put_env(:io_ansi_table, :header_fixes, @header_fixes)
    Application.put_env(:io_ansi_table, :sort_specs, @sort_specs)
    Application.put_env(:io_ansi_table, :align_specs, @align_specs)
    Application.put_env(:io_ansi_table, :margins, @margins)
    Application.put_env(:io_ansi_table, :sort_symbols, @sort_symbols)
  end

  def print_islands(styles \\ Style.styles())

  def print_islands(styles) when is_list(styles) do
    Enum.each(styles, &print_islands/1)
  end

  def print_islands(style) do
    Table.format(
      @islands,
      bell: false,
      count: 10,
      style: style,
      headers: [:row, 1, 2, 3, 4, 5, 6, 7, 8, 9, :A],
      header_fixes: %{"Row" => "", "A" => "10"},
      align_specs: [
        right: :row,
        center: 1,
        center: 2,
        center: 3,
        center: 4,
        center: 5,
        center: 6,
        center: 7,
        center: 8,
        center: 9,
        center: :A
      ],
      sort_specs: [:row],
      sort_symbols: [asc: ""],
      margins: @margins
    )

    Table.format(
      @attacks,
      bell: false,
      count: 10,
      style: style,
      headers: [:row, 1, 2, 3, 4, 5, 6, 7, 8, 9, :A],
      header_fixes: %{"Row" => "", "A" => "10"},
      align_specs: [
        right: :row,
        center: 1,
        center: 2,
        center: 3,
        center: 4,
        center: 5,
        center: 6,
        center: 7,
        center: 8,
        center: 9,
        center: :A
      ],
      sort_specs: [:row],
      sort_symbols: [asc: ""],
      margins: [left: 35, top: -11]
    )
  end

  def print_people_as_keywords(style) do
    Table.format(
      people_as_keywords(),
      bell: true,
      count: length(@people),
      style: style,
      headers: @headers,
      header_fixes: @header_fixes,
      sort_specs: @sort_specs,
      align_specs: @align_specs,
      margins: @margins
    )
  end

  def print_people(style, max_width) do
    Table.format(
      @people,
      bell: true,
      count: length(@people),
      style: style,
      headers: @headers,
      header_fixes: @header_fixes,
      sort_specs: @sort_specs,
      align_specs: @align_specs,
      margins: @margins,
      max_width: max_width
    )
  end

  def print_people_as_keywords(style, max_width) do
    Table.format(
      people_as_keywords(),
      bell: true,
      count: length(@people),
      style: style,
      headers: @headers,
      header_fixes: @header_fixes,
      sort_specs: @sort_specs,
      align_specs: @align_specs,
      margins: @margins,
      max_width: max_width
    )
  end

  def styles(color \\ :light_magenta) do
    chardata = [color, " &style&filler", :reset, " - &rank - &note"]
    ansidata = ANSI.format(chardata)

    "#{ansidata}"
    |> Style.texts(&IO.puts/1)
    |> length()
  end

  @dialyzer {:nowarn_function, people_sorted: 0}
  def people_sorted() do
    MapSorter.sort(@people, @sort_specs)
  end

  @dialyzer {:nowarn_function, people_sorted_as_keywords: 0}
  def people_sorted_as_keywords() do
    MapSorter.sort(people_as_keywords(), @sort_specs)
  end
end
