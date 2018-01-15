defmodule IO.ANSI.Table.Column do
  # @moduledoc """
  # Functions related to the columns of a table.
  # """
  @moduledoc false

  use PersistConfig

  alias IO.ANSI.Table.{Line, Row, Spec}

  @type align_attr :: :left | :center | :right
  @type align_spec :: any | {align_attr, any}
  @type attr :: align_attr | sort_attr
  @type sort_attr :: MapSorter.SortSpec.sort_dir
  @type sort_spec :: MapSorter.SortSpec.t
  @type sort_symbol :: {sort_attr, String.t} | {:pos, atom | [atom]}
  @type spec :: align_spec | sort_spec
  @type spread :: [width]
  @type t :: [String.t]
  @type width :: non_neg_integer

  @ansi_escape_char "\e"
  @ansi_escape_codes ~r/\e\[([0-9]{1,3}(;[0-9]{1,3})*)?[m|K]/
  @max_width_range Application.get_env(@app, :max_width_range)
  @upper_max_width @max_width_range.last

  @spec left_margin(Spec.t) :: Spec.t
  def left_margin(spec) do
    margin = String.duplicate(" ", spec.margins[:left] || 0)
    %{spec | left_margin: margin}
  end

  @spec align_attrs(Spec.t) :: Spec.t
  def align_attrs(spec) do
    attrs = Enum.map(spec.headers, &find_attr(&1, spec.align_specs, :left))
    %{spec | align_attrs: attrs}
  end

  @spec sort_attrs(Spec.t) :: Spec.t
  def sort_attrs(spec) do
    attrs = Enum.map(spec.headers, &find_attr(&1, spec.sort_specs, :asc))
    %{spec | sort_attrs: attrs}
  end

  @doc """
  Returns the `specs` attribute of a `header`.

  ## Examples

      iex> alias IO.ANSI.Table.Column
      iex> sort_specs = ["dept", desc: "hired"]
      iex> {
      ...>   Column.find_attr("dept" , sort_specs, :asc),
      ...>   Column.find_attr("hired", sort_specs, :asc),
      ...>   Column.find_attr("job"  , sort_specs, :asc)
      ...> }
      {:asc, :desc, nil}
  """
  @spec find_attr(any, [spec], attr) :: attr
  def find_attr(header, specs, default_attr) do
    Enum.find_value(specs, fn
      {attr, key} when key == header -> attr
      key when key == header -> default_attr
      _ -> nil
    end)
  end

  @spec column_widths(Spec.t) :: Spec.t
  def column_widths(spec) do
    widths =
      [spec.headings | spec.rows]
      |> transpose()
      |> widths(spec.max_width)
    %{spec | column_widths: widths}
  end

  @doc """
  Returns a list of column widths capped by `maximum width`.

  ## Examples

      iex> alias IO.ANSI.Table.Column
      iex> data = [["cat", "wombat", "elk"], ["mongoose", "ant", "gnu"]]
      iex> Column.widths(data)
      [6, 8]

      iex> alias IO.ANSI.Table.Column
      iex> data = [["cat", "wombat", "elk"], ["mongoose", "ant", "gnu"]]
      iex> Column.widths(data, 7)
      [6, 7]

      iex> alias IO.ANSI.Table.Column
      iex> data = [["\e[32m\e[42mCHEETAH\e[0m", "elk"], ["mongoose", "ant"]]
      iex> Column.widths(data)
      [7, 8]
  """
  @spec widths([t], width) :: [width]
  def widths(columns, max_width \\ @upper_max_width) do
    for column <- columns do
      column |> Enum.map(&column_width/1) |> Enum.max |> min(max_width)
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
      ...>   Column.spread(10, "\e[32m\e[42mCHEETAH\e[0m", :left  ),
      ...>   Column.spread(10, "\e[32m\e[42mCHEETAH\e[0m", :center),
      ...>   Column.spread(10, "\e[32m\e[42mCHEETAH\e[0m", :right )
      ...> }
      iex> # not {[0, 7, 3], [1, 7, 2], [3, 7, 0]} but...
      {[0, 21, 3], [1, 21, 2], [3, 21, 0]}
  """
  @spec spread(width, Line.elem, align_attr) :: spread
  def spread(width, elem, _align_attr = :left) do
    elem_width = column_width(elem) |> min(width)
    [0, String.length(elem), width - elem_width]
  end
  def spread(width, elem, _align_attr = :right) do
    elem_width = column_width(elem) |> min(width)
    [width - elem_width, String.length(elem), 0]
  end
  def spread(width, elem, _align_attr = :center) do
    elem_width = column_width(elem) |> min(width)
    left_width = div(width - elem_width, 2)
    right_width = width - left_width - elem_width
    [left_width, String.length(elem), right_width]
  end
  def spread(width, elem, _align_attr), do: spread(width, elem, :left)

  ## Private functions

  @spec column_width(String.t) :: non_neg_integer
  defp column_width(@ansi_escape_char <> _rest = string) do
    string |> String.replace(@ansi_escape_codes, "") |> String.length()
  end
  defp column_width(string), do: String.length(string)

  #     iex> alias IO.ANSI.Table.Column
  #     iex> rows = [
  #     ...>   ["1", "2", "3"],
  #     ...>   ["4", "5", "6"]
  #     ...> ]
  #     iex> Column.transpose(rows)
  #     [["1", "4"], ["2", "5"], ["3", "6"]]
  # """
  @spec transpose([Row.t]) :: [t]
  defp transpose(rows) do
    rows |> Stream.zip() |> Enum.map(&Tuple.to_list/1)
  end
end
