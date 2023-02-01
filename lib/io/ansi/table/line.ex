defmodule IO.ANSI.Table.Line do
  @moduledoc """
  Formats the lines of a table.
  """

  use PersistConfig

  alias IO.ANSI.Plus, as: ANSI
  alias IO.ANSI.Table.{Column, LineType, Spec, Style}

  @typedoc "Line element"
  @type elem :: String.t()
  @typedoc "Line item"
  @type item :: String.t()

  @ansi_enabled get_env(:ansi_enabled, true)

  @doc """
  Deploys `elements` by interlacing them with `filler` and `borders`
  (left, inner and right).

  ## Examples

      iex> alias IO.ANSI.Table.Line
      iex> elements = ["Number", "Created at", "Title"]
      iex> borders = ["+-", "-+-", "-+"]
      iex> Line.items(elements, borders)
      [
        "", "+-"        , "", # filler, left border, filler
        "", "Number"    , "", # filler, element, filler
        "", "-+-"       , "", # filler, inner border, filler
        "", "Created at", "", # filler, element, filler
        "", "-+-"       , "", # filler, inner border, filler
        "", "Title"     , "", # filler, element, filler
        "", "-+"        , ""  # filler, right border, filler
      ]
  """
  @spec items([elem], [Style.border()], String.t) :: [item]
  def items(elems, borders, filler \\ "") do
    deploy(elems, delimiters(borders, filler))
  end

  @doc """
  Deploys the style attributes of a given line `type` and table `spec`.

  ## Examples

      iex> alias IO.ANSI.Table.Line
      iex> # We use a map instead of a %Spec{} for conciseness.
      iex> spec = %{style: :medium, sort_attrs: [nil, :asc, nil]}
      iex> type = :header
      iex> Line.item_attrs(type, spec)
      [
        :normal, :gold                , :normal, # left border
        :normal, :canary              , :normal, # non-key column
        :normal, :gold                , :normal, # inner border
        :normal, [:canary, :underline], :normal, # key column
        :normal, :gold                , :normal, # inner border
        :normal, :canary              , :normal, # non-key column
        :normal, :gold                , :normal  # right border
      ]
  """
  @spec item_attrs(LineType.t(), Spec.t()) :: [Style.attr()]
  def item_attrs(type, spec) do
    # Wrap attributes in braces to prevent flattening...
    border_attr = {Style.border_attr(spec.style, type)}
    filler_attr = {Style.filler_attr(spec.style, type)}
    key_attr = {Style.key_attr(spec.style, type)}
    non_key_attr = {Style.non_key_attr(spec.style, type)}

    spec.sort_attrs
    |> Enum.map(&if &1 in [:asc, :desc], do: key_attr, else: non_key_attr)
    |> deploy(delimiters(border_attr, filler_attr))
    |> Enum.map(fn {attr} -> attr end) # unwrap attributes
  end

  @doc """
  Deploys the widths of `elements` for a given line `type` and table `spec`.

  ## Examples

      iex> alias IO.ANSI.Table.Line
      iex> # We use a map instead of a %Spec{} for conciseness.
      iex> spec = %{
      ...>   style: :medium,
      ...>   align_attrs: [:right, :center, nil],
      ...>   column_widths: [7, 13, 9]
      ...> }
      iex> dashes = ["═══════", "═════════════", "═════════"]
      iex> elems = ["Number", "Created at", "Title"]
      iex> {Line.item_widths(dashes, :top, spec),
      ...>  Line.item_widths(elems, :header, spec)}
      {[0, 2, 0,  0, 7, 0,  0, 3, 0,  0, 13, 0,  0, 3, 0,  0, 9, 0,  0, 2, 0],
       [0, 1, 1,  1, 6, 0,  1, 1, 1,  1, 10, 2,  1, 1, 1,  0, 5, 4,  1, 1, 0]}
  """
  @spec item_widths([elem], LineType.t(), Spec.t()) :: [Column.width()]
  def item_widths(elems, type, spec) do
    Enum.zip([spec.column_widths, elems, spec.align_attrs])
    |> Enum.map(fn {width, elem, attr} -> Column.spread(width, elem, attr) end)
    |> deploy(Style.border_spreads(spec.style, type))
  end

  @doc ~S"""
  Returns an Erlang I/O format (see `:io.format/2`) reflecting `item widths` and
  `item attributes`.

  It consists of a string with control sequences and embedded
  [ANSI codes](https://en.wikipedia.org/wiki/ANSI_escape_code)
  (escape sequences), if emitting ANSI codes is enabled.

  Here are a few ANSI codes:

    - light yellow - `\e[93m`
    - light cyan   - `\e[96m`
    - reset        - `\e[0m`

  ## Examples

      iex> alias IO.ANSI.Table.Line
      iex> item_widths = [2, 0, 6]
      iex> item_attrs = [:light_yellow, :normal, :light_cyan]
      iex> Line.format(item_widths, item_attrs, true)
      "\e[93m~-2ts\e[0m~-0ts\e[96m~-6ts\e[0m~n"
  """
  @spec format([Column.width()], [Style.attr()], boolean) :: String.t()
  def format(item_widths, item_attrs, ansi_enabled? \\ @ansi_enabled) do
    ansidata_list =
      Enum.zip(item_widths, item_attrs)
      |> Enum.map(fn
        {width, :normal} -> "~-#{width}ts" # t for Unicode translation
        {width, attr} -> ANSI.format([attr, "~-#{width}ts"], ansi_enabled?)
      end)

    "#{ansidata_list}~n" # => string embedded with ANSI escape sequences
  end

  ## Private functions

  # @doc """
  # Deploys `elements` by interlacing them with `delimiters`
  # (left, inner and right).

  # The inner `delimiter` is inserted between all `elements` and
  # the result is then surrounded by the left and right `delimiters`.

  # Returns a flattened list in case any `element` or `delimiter` is a list!

  # ## Examples

  #     iex> alias IO.ANSI.Table.Line
  #     iex> elems = ["Number", "Created at", "Title"]
  #     iex> delimiters = ["<", "=", ">"]
  #     iex> Line.deploy(elems, delimiters)
  #     ["<", "Number", "=", "Created at", "=", "Title", ">"]

  #     iex> alias IO.ANSI.Table.Line
  #     iex> column_spreads = [[1, 6, 0], [1, 10, 2], [0, 5, 4]]
  #     iex> border_spreads = [[0, 1, 1], [1, 1, 1], [1, 1, 0]]
  #     iex> Line.deploy(column_spreads, border_spreads)
  #     [0, 1, 1,  1, 6, 0,  1, 1, 1,  1, 10, 2,  1, 1, 1,  0, 5, 4,  1, 1, 0]

  #     iex> alias IO.ANSI.Table.Line
  #     iex> elems = ["Number", "Created at", "Title"]
  #     iex> border_delimiters = [
  #     ...>   [    ["", "+-" , ""], ""],
  #     ...>   ["", ["", "-+-", ""], ""],
  #     ...>   ["", ["", "-+" , ""]    ]
  #     ...> ]
  #     iex> Line.deploy(elems, border_delimiters)
  #     [
  #       "", "+-"        , "",
  #       "", "Number"    , "",
  #       "", "-+-"       , "",
  #       "", "Created at", "",
  #       "", "-+-"       , "",
  #       "", "Title"     , "",
  #       "", "-+"        , ""
  #     ]

  #     iex> alias IO.ANSI.Table.Line
  #     iex> border_attrs = [{:canary}, {[:canary, :underline]}, {:canary}]
  #     iex> attr_delimiters = [
  #     ...>   [           [{:normal}, {:gold}, {:normal}], {:normal}],
  #     ...>   [{:normal}, [{:normal}, {:gold}, {:normal}], {:normal}],
  #     ...>   [{:normal}, [{:normal}, {:gold}, {:normal}]           ]
  #     ...> ]
  #     iex> Line.deploy(border_attrs, attr_delimiters)
  #     [
  #       {:normal}, {:gold}                , {:normal},
  #       {:normal}, {:canary}              , {:normal},
  #       {:normal}, {:gold}                , {:normal},
  #       {:normal}, {[:canary, :underline]}, {:normal},
  #       {:normal}, {:gold}                , {:normal},
  #       {:normal}, {:canary}              , {:normal},
  #       {:normal}, {:gold}                , {:normal}
  #     ]
  # """
  @spec deploy([any], [any]) :: [any]
  defp deploy(elems, [left, inner, right] = _delimiters) do
    [left] ++ Enum.intersperse(elems, inner) ++ [right] |> List.flatten()
  end

  # @doc """
  # Returns a list of "delimiters" (left, inner and right).

  # ## Examples

  #     iex> alias IO.ANSI.Table.Line
  #     iex> Line.delimiters(["+-", "-+-", "-+"], "")
  #     [
  #       [    ["", "+-" , ""], ""],
  #       ["", ["", "-+-", ""], ""],
  #       ["", ["", "-+" , ""]    ]
  #     ]

  #     iex> alias IO.ANSI.Table.Line
  #     iex> Line.delimiters(["╔═", "═╦═", "═╗"], "~")
  #     [
  #       [     ["~", "╔═" , "~"], "~"],
  #       ["~", ["~", "═╦═", "~"], "~"],
  #       ["~", ["~", "═╗" , "~"]     ]
  #     ]

  #     iex> alias IO.ANSI.Table.Line
  #     iex> Line.delimiters(:gold, :normal)
  #     [
  #       [         [:normal, :gold, :normal], :normal],
  #       [:normal, [:normal, :gold, :normal], :normal],
  #       [:normal, [:normal, :gold, :normal]         ]
  #     ]

  #     iex> alias IO.ANSI.Table.Line
  #     iex> Line.delimiters({[:gold, :underline]}, {:normal})
  #     [
  #       [           [{:normal}, {[:gold, :underline]}, {:normal}], {:normal}],
  #       [{:normal}, [{:normal}, {[:gold, :underline]}, {:normal}], {:normal}],
  #       [{:normal}, [{:normal}, {[:gold, :underline]}, {:normal}]           ]
  #     ]

  #     iex> alias IO.ANSI.Table.Line
  #     iex> Line.delimiters('what', %{})
  #     [
  #       [     [%{}, 'what', %{}], %{}],
  #       [%{}, [%{}, 'what', %{}], %{}],
  #       [%{}, [%{}, 'what', %{}]     ]
  #     ]
  # """
  @spec delimiters(any, any) :: [any]
  defp delimiters([left, inner, right] = _borders, filler) do
    [
      [        [filler, left,  filler], filler], # left delimiter
      [filler, [filler, inner, filler], filler], # inner delimiter
      [filler, [filler, right, filler]        ]  # right delimiter
    ]
  end

  defp delimiters(border_attr, filler_attr) do
    delimiters([border_attr, border_attr, border_attr], filler_attr)
  end
end
