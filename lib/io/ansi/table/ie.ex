defmodule IO.ANSI.Table.IE do
  @moduledoc false

  # Example of an IEx session...
  #
  #   use IO.ANSI.Table.IE
  #   styles
  #   styles(:light_green)
  #   Style.styles
  #   people_with_date_dobs
  #   people_with_string_dobs
  #   sort_people(people_with_date_dobs, asc: {:dob, Date}, desc: :likes)
  #   sort_people(people_with_string_dobs, asc: :dob, desc: :likes)
  #   start
  #   format_islands
  #   write_islands
  #   format_islands(:game)
  #   write_islands(:game)
  #   format_islands(:game, 111)
  #   write_islands(:game, 111)
  #   format_people
  #   write_people
  #   format_people(:pretty)
  #   write_people(:pretty)
  #   format_people(:pretty, 111)
  #   write_people(:pretty, 111)
  #   get
  #   stop

  use PersistConfig

  alias IO.ANSI.Plus, as: ANSI
  alias IO.ANSI.Table
  alias IO.ANSI.Table.Style

  @islands get_env(:islands)
  @attacks get_env(:attacks)
  @islands_headers get_env(:islands_headers)
  @islands_options get_env(:islands_options)

  @people_with_date_dobs get_env(:people_with_date_dobs)
  @people_with_string_dobs get_env(:people_with_string_dobs)
  @people %{
    date_dobs: @people_with_date_dobs,
    string_dobs: @people_with_string_dobs
  }
  @people_headers get_env(:people_headers)
  @people_options get_env(:people_options)

  defmacro __using__(_options) do
    quote do
      import unquote(__MODULE__)
      alias unquote(__MODULE__)
      alias IO.ANSI.Plus, as: ANSI

      alias IO.ANSI.Table.Spec.{
        AlignAttrs,
        ColumnWidths,
        Headings,
        LeftMargin,
        Rows,
        SortAttrs
      }

      alias IO.ANSI.Table.{
        Column,
        DynSpecSup,
        Header,
        LineType,
        LineTypes,
        Line,
        Log,
        Options,
        Row,
        SpecRecovery,
        SpecServer,
        SpecSup,
        Spec,
        Style,
        TopSup
      }

      alias IO.ANSI.Table
      require MapSorter
      :ok
    end
  end

  def islands, do: @islands
  def attacks, do: @attacks
  def islands_options, do: @islands_options
  def islands_headers, do: @islands_headers

  def people_with_date_dobs, do: @people_with_date_dobs
  def people_with_string_dobs, do: @people_with_string_dobs
  def people, do: @people
  def people_options, do: @people_options
  def people_headers, do: @people_headers

  # Format people...
  def format_people(style \\ :pretty, times \\ 1)
      when is_atom(style) and is_integer(times) and times >= 1 do
    import Table, only: [format: 2]

    {usecs, _} =
      :timer.tc(fn ->
        for _ <- 1..times do
          format(@people.string_dobs, style: style, spec_name: "string_dobs")
          format(@people.date_dobs, style: style, spec_name: "date_dobs")
        end
      end)

    IO.puts("#{usecs / 1_000_000} sec")
  end

  # Write people...
  def write_people(style \\ :pretty, times \\ 1)
      when is_atom(style) and is_integer(times) and times >= 1 do
    left_spec = Table.get(spec_name: "string_dobs")
    right_spec = Table.get(spec_name: "date_dobs")

    {usecs, _} =
      :timer.tc(fn ->
        for _ <- 1..times do
          Table.write(left_spec, @people_with_string_dobs, style: style)
          Table.write(right_spec, @people_with_date_dobs, style: style)
        end
      end)

    IO.puts("#{usecs / 1_000_000} sec")
  end

  # Format islands...
  def format_islands(style \\ :game, times \\ 1)
      when is_atom(style) and is_integer(times) and times >= 1 do
    {usecs, _} =
      :timer.tc(fn ->
        for _ <- 1..times do
          Table.format(@islands, style: style, spec_name: "left_board")
          Table.format(@attacks, style: style, spec_name: "right_board")
        end
      end)

    IO.puts("#{usecs / 1_000_000} sec")
  end

  # Write islands...
  def write_islands(style \\ :game, times \\ 1)
      when is_atom(style) and is_integer(times) and times >= 1 do
    left_spec = Table.get(spec_name: "left_board")
    right_spec = Table.get(spec_name: "right_board")

    {usecs, _} =
      :timer.tc(fn ->
        for _ <- 1..times do
          Table.write(left_spec, @islands, style: style)
          Table.write(right_spec, @attacks, style: style)
        end
      end)

    IO.puts("#{usecs / 1_000_000} sec")
  end

  # Start servers...
  def start do
    left_board =
      Table.start(
        islands_headers(),
        islands_options() ++
          [margins: [top: 1, bottom: 0, left: 2], spec_name: "left_board"]
      )

    right_board =
      Table.start(
        islands_headers(),
        islands_options() ++
          [margins: [top: -11, bottom: 1, left: 35], spec_name: "right_board"]
      )

    string_dobs =
      Table.start(
        people_headers(),
        people_options() ++
          [
            margins: [top: 1, bottom: 0, left: 2],
            sort_specs: [:dob, desc: :likes],
            spec_name: "string_dobs",
            header_fixes: %{"Dob" => "String DOB", "Bmi" => "BMI"}
          ]
      )

    date_dobs =
      Table.start(
        people_headers(),
        people_options() ++
          [
            margins: [top: -11, bottom: 1, left: 52],
            sort_specs: [{:dob, Date}, desc: :likes],
            spec_name: "date_dobs",
            header_fixes: %{"Dob" => "Date DOB", "Bmi" => "BMI"}
          ]
      )

    [
      left_board: left_board,
      right_board: right_board,
      string_dobs: string_dobs,
      date_dobs: date_dobs
    ]
  end

  # Get server specs...
  def get do
    left_board = Table.get(spec_name: "left_board")
    right_board = Table.get(spec_name: "right_board")
    string_dobs = Table.get(spec_name: "string_dobs")
    date_dobs = Table.get(spec_name: "date_dobs")

    [
      left_board: left_board,
      right_board: right_board,
      string_dobs: string_dobs,
      date_dobs: date_dobs
    ]
  end

  # Stop servers...
  def stop do
    left_board = Table.stop(spec_name: "left_board")
    right_board = Table.stop(spec_name: "right_board")
    string_dobs = Table.stop(spec_name: "string_dobs")
    date_dobs = Table.stop(spec_name: "date_dobs")

    [
      left_board: left_board,
      right_board: right_board,
      string_dobs: string_dobs,
      date_dobs: date_dobs
    ]
  end

  def styles(color \\ :light_magenta) do
    chardata = [color, " &style&filler", :reset, " - &rank - &note"]
    ansidata = ANSI.format(chardata)
    texts = Style.texts("#{ansidata}")
    Enum.each(texts, &IO.puts/1)
    length(texts)
  end

  def sort_people(people, sort_specs) do
    require MapSorter
    MapSorter.sort(people, sort_specs)
  end
end
