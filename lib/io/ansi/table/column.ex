defmodule IO.ANSI.Table.Column do
  @moduledoc """
  Functions related to the columns of a table.
  """

  use PersistConfig

  alias IO.ANSI.Table.{Header, Line}

  @ansi_escape "\e"

  # "\e[1;31mHello" => bold with red foreground
  # "\e[2;37;41mWorld => dimmed white foreground with red background
  @ansi_escape_codes ~r/\e\[([0-9]{1,3}(;[0-9]{1,3})*)?[m|K]/

  @typedoc """
  A list of 3 contiguous widths: left width, inner width and right width
  """
  @type spread :: [width]
  @typedoc "Table column"
  @type t :: [String.t()]
  @typedoc "Column width"
  @type width :: non_neg_integer

  @doc ~S'''
  Returns a list of widths for the given `columns`, capped at `max_width`.

  ## Examples

      iex> alias IO.ANSI.Table.Column
      iex> #          <-------column 1------->  <--------column 2-------->
      iex> columns = [["cat", "wombat", "elk"], ["mongoose", "ant", "gnu"]]
      iex> Column.widths(columns, 99)
      [6, 8]

      iex> alias IO.ANSI.Table.Column
      iex> columns = [["cat", "wombat", "elk"], ["mongoose", "ant", "gnu"]]
      iex> Column.widths(columns, 7)
      [6, 7]

      iex> alias IO.ANSI.Table.Column
      iex> # Embedded ANSI escape codes are ignored...
      iex> columns = [["\e[32m\e[42mCHEETAH\e[0m", "elk"], ["mongoose", "ant"]]
      iex> Column.widths(columns, 99)
      [7, 8]

      iex> alias IO.ANSI.Table.Column
      iex> columns = [["\e[32m\e[42mCHEETAH\e[0m", "elk"], ["mongoose", "ant"]]
      iex> Column.widths(columns, 6)
      [6, 6]
  '''
  @spec widths([t], width) :: [width]
  def widths(columns, max_width)
      when is_list(columns) and is_integer(max_width) and max_width >= 0 do
    for column <- columns do
      Enum.map(column, &width/1) |> Enum.max() |> min(max_width)
    end
  end

  @doc ~S'''
  Spreads a `column_width` given an `elem` and its `align_attr`.

  ## Examples

      iex> alias IO.ANSI.Table.Column
      iex> {
      ...>   Column.spread(7, "name", :left  ),
      ...>   Column.spread(7, "name", :center),
      ...>   Column.spread(7, "name", :right )
      ...> }
      {[0, 4, 3], [1, 4, 2], [3, 4, 0]}

      iex> alias IO.ANSI.Table.Column
      iex> {
      ...>   Column.spread(3, "name", :left  ),
      ...>   Column.spread(3, "name", :center),
      ...>   Column.spread(3, "name", :right )
      ...> }
      {[0, 3, 0], [0, 3, 0], [0, 3, 0]}

      iex> alias IO.ANSI.Table.Column
      iex> # All codepoints must be formatted by `:io.format/2`.
      iex> {
      ...>   Column.spread(10, "\e[32m\e[42mCHEETAH\e[0m", :left  ),
      ...>   Column.spread(10, "\e[32m\e[42mCHEETAH\e[0m", :center),
      ...>   Column.spread(10, "\e[32m\e[42mCHEETAH\e[0m", :right )
      ...> }
      {[0, 21, 3], [1, 21, 2], [3, 21, 0]}

      iex> alias IO.ANSI.Table.Column
      iex> {
      ...>   Column.spread(7, "\e[32m\e[42mCHEETAH\e[0m", :left  ),
      ...>   Column.spread(7, "\e[32m\e[42mCHEETAH\e[0m", :center),
      ...>   Column.spread(7, "\e[32m\e[42mCHEETAH\e[0m", :right )
      ...> }
      {[0, 21, 0], [0, 21, 0], [0, 21, 0]}
  '''
  @spec spread(width, Line.elem(), Header.align_attr()) :: spread
  def spread(column_width, elem, _align_attr = :left) do
    elem_width = width(elem) |> min(column_width)
    [0, io_width(elem, elem_width), column_width - elem_width]
  end

  def spread(column_width, elem, _align_attr = :right) do
    elem_width = width(elem) |> min(column_width)
    [column_width - elem_width, io_width(elem, elem_width), 0]
  end

  def spread(column_width, elem, _align_attr = :center) do
    elem_width = width(elem) |> min(column_width)
    left_width = div(column_width - elem_width, 2)
    right_width = column_width - left_width - elem_width
    [left_width, io_width(elem, elem_width), right_width]
  end

  def spread(column_width, elem, _align_attr) do
    spread(column_width, elem, :left)
  end

  @doc ~S'''
  The "visible" width of an element (ignoring embedded ANSI escape codes).

  See function `Islands.Grid.to_maps/2` for examples of such elements.

  ## Examples

      iex> alias IO.ANSI.Table.Column
      iex> # ansi_escape_codes = ~r/\e\[([0-9]{1,3}(;[0-9]{1,3})*)?[m|K]/
      iex> improper_list =
      ...>   [[[[[] | "\e[38;5;34m"] | "\e[48;5;34m"], ">a<"] | "\e[0m"]
      iex> elem = IO.iodata_to_binary(improper_list)
      iex> # => "\e[38;5;34m\e[48;5;34m>a<\e[0m"
      iex> Column.width(elem)
      3 # length of ">a<"

      iex> alias IO.ANSI.Table.Column
      iex> Column.width("Hello!")
      6
  '''
  @spec width(String.t()) :: non_neg_integer
  def width(@ansi_escape <> _rest = elem) do
    String.replace(elem, @ansi_escape_codes, "") |> String.length()
  end

  def width(elem), do: String.length(elem)

  @doc ~S'''
  The field width to be used in an Erlang I/O format.
  All embedded ANSI escape codes are considered here.

  ## Examples

      iex> alias IO.ANSI.Table.Column
      iex> # ansi_escape_codes = ~r/\e\[([0-9]{1,3}(;[0-9]{1,3})*)?[m|K]/
      iex> improper_list =
      ...>   [[[[[] | "\e[38;5;34m"] | "\e[48;5;34m"], ">a<"] | "\e[0m"]
      iex> elem = IO.iodata_to_binary(improper_list)
      iex> # => "\e[38;5;34m\e[48;5;34m>a<\e[0m"
      iex> Column.io_width(elem, 3)
      27 # \e is one codepoint

      iex> alias IO.ANSI.Table.Column
      iex> Column.io_width("Hello!", 6)
      6

      iex> alias IO.ANSI.Table.Column
      iex> Column.io_width("Hello!", 7)
      7
  '''
  @spec io_width(String.t(), non_neg_integer) :: non_neg_integer
  def io_width(@ansi_escape <> _rest = elem, _elem_width) do
    String.length(elem)
  end

  def io_width(_elem, elem_width), do: elem_width
end
