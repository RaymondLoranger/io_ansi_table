defmodule IO.ANSI.Table.Column do
  @moduledoc """
  Functions related to the columns of a table.
  """

  use PersistConfig

  alias IO.ANSI.Table.{Header, Line}

  @ansi_escape_char "\e"
  @ansi_escape_codes ~r/\e\[([0-9]{1,3}(;[0-9]{1,3})*)?[m|K]/

  # spread :: [left_width, inner_width, right_width]
  @type spread :: [width]
  @type t :: [String.t()]
  @type width :: non_neg_integer

  @doc """
  Returns a list of column widths capped by `maximum width`.

  ## Examples

      iex> alias IO.ANSI.Table.Column
      iex> data = [["cat", "wombat", "elk"], ["mongoose", "ant", "gnu"]]
      iex> Column.widths(data, 99)
      [6, 8]

      iex> alias IO.ANSI.Table.Column
      iex> data = [["cat", "wombat", "elk"], ["mongoose", "ant", "gnu"]]
      iex> Column.widths(data, 7)
      [6, 7]

      iex> alias IO.ANSI.Table.Column
      iex> data = [["\e[32m\e[42mCHEETAH\e[0m", "elk"], ["mongoose", "ant"]]
      iex> Column.widths(data, 99)
      [7, 8]

      iex> alias IO.ANSI.Table.Column
      iex> data = [["\e[32m\e[42mCHEETAH\e[0m", "elk"], ["mongoose", "ant"]]
      iex> Column.widths(data, 6)
      [6, 6]
  """
  @spec widths([t], width) :: [width]
  def widths(columns, max_width) do
    for column <- columns do
      column |> Enum.map(&width/1) |> Enum.max() |> min(max_width)
    end
  end

  @doc """
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
  """
  @spec spread(width, Line.elem(), Header.align_attr()) :: spread
  def spread(width, elem, _align_attr = :left) do
    elem_width = elem |> width() |> min(width)
    [0, io_width(elem, elem_width), width - elem_width]
  end

  def spread(width, elem, _align_attr = :right) do
    elem_width = elem |> width() |> min(width)
    [width - elem_width, io_width(elem, elem_width), 0]
  end

  def spread(width, elem, _align_attr = :center) do
    elem_width = elem |> width() |> min(width)
    left_width = div(width - elem_width, 2)
    right_width = width - left_width - elem_width
    [left_width, io_width(elem, elem_width), right_width]
  end

  def spread(width, elem, _align_attr), do: spread(width, elem, :left)

  ## Private functions

  # The "visible" width of an element (ignoring ANSI codes)...
  @spec width(String.t()) :: non_neg_integer
  defp width(@ansi_escape_char <> _rest = elem) do
    elem |> String.replace(@ansi_escape_codes, "") |> String.length()
  end

  defp width(elem), do: String.length(elem)

  # The field width to be used in an Erlang io format...
  @spec io_width(String.t(), non_neg_integer) :: non_neg_integer
  defp io_width(@ansi_escape_char <> _rest = elem, _elem_width) do
    # We do not cap the width of an element with ANSI codes...
    String.length(elem)
  end

  defp io_width(_elem, elem_width), do: elem_width
end
