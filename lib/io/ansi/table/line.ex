defmodule IO.ANSI.Table.Line do
  # @moduledoc """
  # Formats the line of a table.
  # """
  @moduledoc false

  use PersistConfig

  alias IO.ANSI.Table.{Column, LineType, Spec, Style}

  @type elem :: String.t
  @typep item :: String.t
  @typep delimiter :: any

  @ansi_enabled Application.get_env(@app, :ansi_enabled)

  @doc """
  Deploys `elements` by mixing "fillers" and `borders` (left, inner and right).

  ## Examples

      iex> alias IO.ANSI.Table.Line
      iex> elements = ["Number", "Created at", "Title"]
      iex> Line.items(elements, ["<", "=", ">"])
      [
        "", "<"         , "", # filler, left border, filler
        "", "Number"    , "", # filler, element, filler
        "", "="         , "", # filler, inner border, filler
        "", "Created at", "", # filler, element, filler
        "", "="         , "", # filler, inner border, filler
        "", "Title"     , "", # filler, element, filler
        "", ">"         , ""  # filler, right border, filler
      ]
  """
  @spec items([elem], [Style.border]) :: [item]
  def items(elems, [left, inner, right] = _borders) do
    deploy(elems, delimiters(left, inner, right))
  end

  @doc """
  Deploys the style attributes of a given line `type` and table `spec`.

  ## Examples

      iex> alias IO.ANSI.Table.Line
      iex> spec = %{style: :medium, sort_attrs: [nil, :asc, nil]}
      iex> type = :header
      iex> Line.item_attrs(type, spec)
      [
        :normal, :light_yellow             , :normal, # left border
        :normal, :light_green              , :normal, # non key column
        :normal, :light_yellow             , :normal, # inner border
        :normal, [:light_green, :underline], :normal, # key column
        :normal, :light_yellow             , :normal, # inner border
        :normal, :light_green              , :normal, # non key column
        :normal, :light_yellow             , :normal  # right border
      ]
  """
  @spec item_attrs(LineType.t, Spec.t) :: [Style.attr]
  def item_attrs(type, spec) do
    # Wrap attributes in braces to prevent flattening...
    border_attr = {Style.border_attr(spec.style, type)}
    filler_attr = {Style.filler_attr(spec.style, type)}
    key_attr = {Style.key_attr(spec.style, type)}
    non_key_attr = {Style.non_key_attr(spec.style, type)}
    spec.sort_attrs
    |> Enum.map(& &1 in [:asc, :desc] && key_attr || non_key_attr)
    |> deploy(delimiters(border_attr, filler_attr))
    |> Enum.map(fn {attr} -> attr end) # unwrap attributes
  end

  @doc """
  Deploys widths of `elements` for a given line `type` and table `spec`.

  ## Examples

      iex> alias IO.ANSI.Table.Line
      iex> spec = %{
      ...>   style: :medium,
      ...>   align_attrs: [:right, :center, nil],
      ...>   column_widths: [7, 13, 11]
      ...> }
      iex> type = :header
      iex> elems = ["Number", "Created at", "Title"]
      iex> Line.item_widths(elems, type, spec)
      [0, 1, 1, 1, 6, 0, 1, 1, 1, 1, 10, 2, 1, 1, 1, 0, 5, 6, 1, 1, 0]
  """
  @spec item_widths([elem], LineType.t, Spec.t) :: [Column.width]
  def item_widths(elems, type, spec) do
    Stream.zip([spec.column_widths, elems, spec.align_attrs])
    |> Enum.map(fn {width, elem, attr} -> Column.spread(width, elem, attr) end)
    |> deploy(Style.border_spreads(spec.style, type))
  end

  @doc ~S"""
  Returns an Erlang io format reflecting `item widths` and `item attributes`.
  It consists of a string with embedded
  [ANSI codes](https://gist.github.com/chrisopedia/8754917)
  (escape sequences), if emitting ANSI codes is enabled.

  Here are a few ANSI codes:

    - light yellow - \\e[93m
    - light cyan   - \\e[96m
    - reset        - \\e[0m

  ## Examples

      iex> alias IO.ANSI.Table.Line
      iex> item_widths = [2, 0, 6]
      iex> item_attrs = [:light_yellow, :normal, :light_cyan]
      iex> Line.format(item_widths, item_attrs, true)
      "\e[93m~-2ts\e[0m~-0ts\e[96m~-6ts\e[0m~n"
  """
  @spec format([Column.width], [Style.attr], boolean) :: String.t
  def format(item_widths, item_attrs, ansi_enabled? \\ @ansi_enabled) do
    item_widths
    |> Enum.zip(item_attrs)
    |> Enum.map(&fragment(&1, ansi_enabled?))
    |> (&"#{&1}~n").() # => string embedded with ANSI escape sequences
  end

  ## Private functions

  @spec fragment(tuple, boolean) :: IO.chardata
  defp fragment({width, :normal}, _ansi_enabled?) do
    "~-#{width}ts" # t for Unicode translation
  end
  defp fragment({width, attr}, ansi_enabled?) do
    IO.ANSI.format([attr, "~-#{width}ts"], ansi_enabled?)
  end

  # @doc """
  # Deploys `elements` by mixing `delimiters` (left, inner and right).

  # The inner `delimiter` is inserted between all `elements` and
  # the result is then surrounded by the left and right `delimiters`.

  # Returns a flattened list in case any `element` or `delimiter` is a list.

  # ## Examples

  #     iex> alias IO.ANSI.Table.Line
  #     iex> elems = ["Number", "Created at", "Title"]
  #     iex> delimiters = ["<", "=", ">"]
  #     iex> Line.deploy(elems, delimiters)
  #     ["<", "Number", "=", "Created at", "=", "Title", ">"]

  #     iex> alias IO.ANSI.Table.Line
  #     iex> elems = [["", "Title", ""], ["", "Author", ""], ["", "Year", ""]]
  #     iex> delimiters = [["", "<", ""], ["", "=", ""], ["", ">", ""]]
  #     iex> Line.deploy(elems, delimiters)
  #     [
  #       "", "<"     , "",
  #       "", "Title" , "",
  #       "", "="     , "",
  #       "", "Author", "",
  #       "", "="     , "",
  #       "", "Year"  , "",
  #       "", ">"     , ""
  #     ]

  #     iex> alias IO.ANSI.Table.Line
  #     iex> elems = [6, 10, 5]
  #     iex> delimiters = [[0,1, 1], [1, 1, 1], [1, 1, 0]]
  #     iex> Line.deploy(elems, delimiters)
  #     [0, 1, 1, 6, 1, 1, 1, 10, 1, 1, 1, 5, 1, 1, 0]
  # """
  @spec deploy([elem], [delimiter]) :: [any]
  defp deploy(elems, [left, inner, right] = _delimiters) do
    # [left] ++ Enum.intersperse(elems, inner) ++ [right] |> List.flatten()
    [left | [Enum.intersperse(elems, inner) | [right]]] |> List.flatten()
  end

  @spec delimiters(any, any) :: [any]
  defp delimiters(uniq, filler), do: delimiters(uniq, uniq, uniq, filler)

  @spec delimiters(any, any, any, any) :: [any]
  defp delimiters(left, inner, right, filler \\ "") do
    [
      [        [filler, left , filler], filler],
      [filler, [filler, inner, filler], filler],
      [filler, [filler, right, filler]        ]
    ]
  end
end
