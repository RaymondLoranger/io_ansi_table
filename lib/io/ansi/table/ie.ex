defmodule IO.ANSI.Table.IE do
  @moduledoc false

  # Functions for iex session...
  #
  # Examples:
  #   use IO.ANSI.Table.IE
  #   people()
  #   people_sorted()
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
  #   print_people([:pretty_alt, :dotted_alt, :medium_alt])
  #   print_people()
  #   Application.put_env(:io_ansi_table, :async, true)
  #   r(Table)
  #   print_people([:pretty_alt, :dotted_alt, :medium_alt])
  #   print_people()

  alias IO.ANSI.Table
  alias IO.ANSI.Table.Style

  require MapSorter

  @align_specs [center: :dob, right: :weight]
  @headers [:name, :dob, :likes, :bmi]
  @header_fixes %{"Dob" => "DOB", "Bmi" => "BMI"}
  @islands [
    %{:row =>  1, 1 => "]", 2 => "]", 3 => " ", 4 => " ", 5  => " ",
                  6 => " ", 7 => " ", 8 => " ", 9 => "_", :A => "_"},
    %{:row =>  2, 1 => " ", 2 => "]", 3 => " ", 4 => " ", 5  => " ",
                  6 => " ", 7 => " ", 8 => " ", 9 => " ", :A => " "},
    %{:row =>  3, 1 => "]", 2 => " ", 3 => " ", 4 => "_", 5  => " ",
                  6 => " ", 7 => "L", 8 => " ", 9 => " ", :A => " "},
    %{:row =>  4, 1 => " ", 2 => " ", 3 => "_", 4 => " ", 5  => " ",
                  6 => " ", 7 => "L", 8 => " ", 9 => " ", :A => " "},
    %{:row =>  5, 1 => " ", 2 => " ", 3 => " ", 4 => " ", 5  => " ",
                  6 => " ", 7 => "L", 8 => "L", 9 => " ", :A => " "},
    %{:row =>  6, 1 => " ", 2 => " ", 3 => "S", 4 => "S", 5  => " ",
                  6 => " ", 7 => " ", 8 => " ", 9 => " ", :A => " "},
    %{:row =>  7, 1 => " ", 2 => "S", 3 => " ", 4 => " ", 5  => " ",
                  6 => " ", 7 => " ", 8 => " ", 9 => " ", :A => "_"},
    %{:row =>  8, 1 => " ", 2 => " ", 3 => " ", 4 => " ", 5  => " ",
                  6 => " ", 7 => " ", 8 => " ", 9 => " ", :A => " "},
    %{:row =>  9, 1 => " ", 2 => " ", 3 => " ", 4 => " ", 5  => "■",
                  6 => " ", 7 => " ", 8 => " ", 9 => "●", :A => " "},
    %{:row => 10, 1 => " ", 2 => " ", 3 => " ", 4 => " ", 5  => "■",
                  6 => "■", 7 => " ", 8 => " ", 9 => " ", :A => " "}
  ]
  @margins [top: 1, bottom: 0]
  # Using @people with struct dobs requires to...
  # config :map_sorter, sorting_on_structs?: true
  # mix deps.compile map_sorter
  @people [ # struct dobs
    %{name: "Mike", likes: "ski, arts", dob: ~D[1992-04-15], bmi: 23.9},
    %{name: "Mary", likes: "travels"  , dob: ~D[1992-04-15], bmi: 26.8},
    %{name: "Ann" , likes: "reading"  , dob: ~D[1992-04-15], bmi: 24.7},
    %{name: "Ray" , likes: "cycling"  , dob: ~D[1977-08-28], bmi: 19.1},
    %{name: "Bill", likes: "karate"   , dob: ~D[1977-08-28], bmi: 18.1},
    %{name: "Joe" , likes: "boxing"   , dob: ~D[1977-08-28], bmi: 20.8},
    %{name: "Jill", likes: "cooking"  , dob: ~D[1976-09-28], bmi: 25.8}
  ]
  @people [ # string dobs
    %{name: "Mike", likes: "ski, arts", dob: "1992-04-15", bmi: 23.9},
    %{name: "Mary", likes: "travels"  , dob: "1992-04-15", bmi: 26.8},
    %{name: "Ann" , likes: "reading"  , dob: "1992-04-15", bmi: 24.7},
    %{name: "Ray" , likes: "cycling"  , dob: "1977-08-28", bmi: 19.1},
    %{name: "Bill", likes: "karate"   , dob: "1977-08-28", bmi: 18.1},
    %{name: "Joe" , likes: "boxing"   , dob: "1977-08-28", bmi: 20.8},
    %{name: "Jill", likes: "cooking"  , dob: "1976-09-28", bmi: 25.8}
  ]
  @sort_specs [:dob, desc: :likes]
  @sort_symbols  [asc: "▲", desc: "▼", pos: :trailing]

  defmacro __using__(_options) do
    quote do
      import unquote(__MODULE__)
      alias unquote(__MODULE__)
      alias IO.ANSI.Table
      alias IO.ANSI.Table.{Column, Config, Formatter, Heading}
      alias IO.ANSI.Table.{Line, Line_type, Row, Server, Spec, Style}
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
      @people, bell: true, count: length(@people), style: style,
      headers: @headers, header_fixes: @header_fixes,
      sort_specs: @sort_specs, align_specs: @align_specs,
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
      @islands, bell: false, count: 10, style: style,
      headers: [:row, 1, 2, 3, 4, 5, 6, 7, 8, 9, :A],
      header_fixes: %{"Row" => "", "A" => "10"},
      sort_specs: [:row], align_specs: [right: :row],
      margins: @margins
    )
  end

  def print_people_as_keywords(style) do
    Table.format(
      people_as_keywords(), bell: true, count: length(@people), style: style,
      headers: @headers, header_fixes: @header_fixes,
      sort_specs: @sort_specs, align_specs: @align_specs,
      margins: @margins
    )
  end

  def print_people(style, max_width) do
    Table.format(
      @people, bell: true, count: length(@people), style: style,
      headers: @headers, header_fixes: @header_fixes,
      sort_specs: @sort_specs, align_specs: @align_specs,
      margins: @margins, max_width: max_width
    )
  end

  def print_people_as_keywords(style, max_width) do
    Table.format(
      people_as_keywords(), bell: true, count: length(@people), style: style,
      headers: @headers, header_fixes: @header_fixes,
      sort_specs: @sort_specs, align_specs: @align_specs,
      margins: @margins, max_width: max_width
    )
  end

  def styles(color \\ :light_magenta) do
    chardata = [color, " &style&filler", :reset, " - &rank - &note"]
    fragments = IO.ANSI.format(chardata)
    "#{fragments}"
    |> Style.texts(&IO.puts/1)
    |> length()
  end

  def people_sorted(), do: MapSorter.sort(@people, @sort_specs)

  def people_sorted_as_keywords() do
    MapSorter.sort(people_as_keywords(), @sort_specs)
  end
end
