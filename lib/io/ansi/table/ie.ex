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
  #   print_people(:dotted_mult, 9)
  #   print_people_as_keywords(:green_mult)
  #   print_people_as_keywords(:green_mult, 9)
  #   styles()
  #   styles(:light_green)
  #   Style.styles()
  #   print_people([:pretty_alt, :dotted_alt, :medium_alt])
  #   print_people()

  alias IO.ANSI.Table
  alias IO.ANSI.Table.Style

  require MapSorter

  @align_specs [center: :date_of_birth, right: :weight]
  @headers [:name, :date_of_birth, :likes, :height, :weight, :bmi]
  @header_fixes %{~r[Bmi] => "BMI"}
  @margins [top: 1, bottom: 0]
  @people [
    %{
      name: "Mike", likes: "ski, arts", date_of_birth: "1992-04-15",
      height: ~s[6' 0"], weight: "176 lb", bmi: 23.9
    },
    %{
      name: "Mary", likes: "travels"  , date_of_birth: "1992-04-15",
      height: ~s[5' 6"], weight: "166 lb", bmi: 26.8
    },
    %{
      name: "Ann" , likes: "reading"  , date_of_birth: "1992-04-15",
      height: ~s[6' 1"], weight: "187 lb", bmi: 24.7
    },
    %{
      name: "Ray" , likes: "cycling"  , date_of_birth: "1977-08-28",
      height: ~s[6' 0"], weight: "141 lb", bmi: 19.1
    },
    %{
      name: "Bill", likes: "karate"   , date_of_birth: "1977-08-28",
      height: ~s[5' 8"], weight: "119 lb", bmi: 18.1
    },
    %{
      name: "Joe" , likes: "boxing"   , date_of_birth: "1977-08-28",
      height: "1.82 m" , weight: "69 kg" , bmi: 20.8
    },
    %{
      name: "Jill", likes: "cooking"  , date_of_birth: "1976-09-28",
      height: "1.76 m" , weight: "80 kg" , bmi: 25.8
    }
  ]
  @sort_specs [:date_of_birth, desc: :likes]

  defmacro __using__(_options) do
    quote do
      import IO.ANSI.Table.IE
      alias IO.ANSI.Table
      alias IO.ANSI.Table.{Column, Config, Formatter, Heading}
      alias IO.ANSI.Table.{Line, Line_type, Row, Spec, Style}
      require MapSorter
      :ok
    end
  end

  def people(), do: @people

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
    |> length
  end

  def people_sorted(), do: MapSorter.sort(@people, @sort_specs)

  def people_sorted_as_keywords() do
    MapSorter.sort(people_as_keywords(), @sort_specs)
  end
end
