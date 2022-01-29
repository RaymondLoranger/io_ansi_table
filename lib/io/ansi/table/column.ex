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
  Returns a list of column widths capped by `maximum width`.

  ## Examples

      iex> alias IO.ANSI.Table.Column
      iex> columns = [["cat", "wombat", "elk"], ["mongoose", "ant", "gnu"]]
      iex> Column.widths(columns, 99)
      [6, 8]

      iex> alias IO.ANSI.Table.Column
      iex> columns = [["cat", "wombat", "elk"], ["mongoose", "ant", "gnu"]]
      iex> Column.widths(columns, 7)
      [6, 7]

      iex> alias IO.ANSI.Table.Column
      iex> columns = [["\e[32m\e[42mCHEETAH\e[0m", "elk"], ["mongoose", "ant"]]
      iex> Column.widths(columns, 99)
      [7, 8]

      iex> alias IO.ANSI.Table.Column
      iex> columns = [["\e[32m\e[42mCHEETAH\e[0m", "elk"], ["mongoose", "ant"]]
      iex> Column.widths(columns, 6)
      [6, 6]
  '''
  @spec widths([t], width) :: [width]
  def widths(columns, max_width) do
    for column <- columns do
      Enum.map(column, &width/1) |> Enum.max() |> min(max_width)
    end
  end

  @doc ~S'''
  Spreads a `width` given an `element` and its `align attribute`.

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
  def spread(width, elem, _align_attr = :left) do
    elem_width = width(elem) |> min(width)
    [0, io_width(elem, elem_width), width - elem_width]
  end

  def spread(width, elem, _align_attr = :right) do
    elem_width = width(elem) |> min(width)
    [width - elem_width, io_width(elem, elem_width), 0]
  end

  def spread(width, elem, _align_attr = :center) do
    elem_width = width(elem) |> min(width)
    left_width = div(width - elem_width, 2)
    right_width = width - left_width - elem_width
    [left_width, io_width(elem, elem_width), right_width]
  end

  def spread(width, elem, _align_attr), do: spread(width, elem, :left)

  ## Private functions

  # The "visible" width of an element (ignoring embedded ANSI escape codes)...
  # See function `Islands.Grid.to_maps/2` for an example of such elements.
  @spec width(String.t()) :: non_neg_integer
  defp width(@ansi_escape <> _rest = elem) do
    String.replace(elem, @ansi_escape_codes, "") |> String.length()
  end

  defp width(elem), do: String.length(elem)

  # The field width to be used in an Erlang io format...
  @spec io_width(String.t(), non_neg_integer) :: non_neg_integer
  defp io_width(@ansi_escape <> _rest = elem, _elem_width) do
    # We do not cap the width of an element with embedded ANSI escape codes...
    String.length(elem)
  end

  defp io_width(_elem, elem_width), do: elem_width
end
