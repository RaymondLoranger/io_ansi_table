
defmodule IO.ANSI.Table.Formatter.Helper do
  @moduledoc """
  Prints a table of rows with headers, applying a table style (configurable).
  """

  alias IO.ANSI.Table.{Formatter, Formatter.Helper, Style}

  Mix.Project.config[:config_path] |> Mix.Config.read! |> Mix.Config.persist
  @external_resource Path.expand Mix.Project.config[:config_path]
  @app               Mix.Project.config[:app]
  @ansi_enabled      Application.get_env @app, :ansi_enabled

  defstruct rows: nil, headers: nil, column_types: nil, align_attrs: nil,
    left_margin: nil, column_widths: nil, style: nil

  @type align_attr :: :left | :center | :right
  @type column_type :: :key | :non_key
  @type elem :: String.t
  @type header :: String.t
  @type item :: String.t
  @type item_width :: non_neg_integer
  @type t :: %Helper{
    rows: [Formatter.row] | nil,
    headers: [header] | nil,
    column_types: [column_type] | nil,
    align_attrs: [align_attr] | nil,
    left_margin: String.t | nil,
    column_widths: [Formatter.column_width] | nil,
    style: Style.t | nil
  }

  @doc """
  Takes a list of `rows` (string sublists), a list of `headers`, a list
  of `key headers`, a map of `header fixes`, a map of `align attributes`,
  a keyword list of `margins`, a list of `column widths`, a table `style`
  and whether to ring the `bell`.

  Prints a table to STDOUT of the strings in each `row`.
  The columns are identified by successive `headers`.

  ## Table styles

  #{Style.texts "  - `&style`&filler - &note\n"}

  ## Examples

      alias IO.ANSI.Table.Formatter.Helper
      capitals = [
        ["Ottawa", "Canada" , "1,142,700"],
        ["Zagreb", "Croatia",   "685,500"],
        ["Paris" , "France" , "9,854,000"]
      ]
      headers = ['city', 'country', 'population']
      key_headers = ['country']
      header_fixes = %{}
      align_attrs = %{'population' => :right}
      margins = [top: 2, bottom: 2, left: 2]
      column_widths = [6, 7, 10]
      style = :medium
      bell? = true
      Helper.print_table(
        capitals, headers, key_headers,
        header_fixes, align_attrs, margins, column_widths, style, bell?
      )
  ## ![print_table_capitals](images/print_table_capitals.png)
      iex> alias ExUnit.CaptureIO
      iex> alias IO.ANSI.Table.Formatter.Helper
      iex> capitals = [
      ...>   ["Ottawa", "Canada" , "1,142,700"],
      ...>   ["Zagreb", "Croatia",   "685,500"],
      ...>   ["Paris" , "France" , "9,854,000"]
      ...> ]
      iex> headers = ['city', :country, "population"]
      iex> key_headers = [:country]
      iex> header_fixes = %{}
      iex> align_attrs = %{"population" => :right}
      iex> margins = [top: 2, bottom: 2, left: 3]
      iex> column_widths = [6, 7, 10]
      iex> style = :dashed
      iex> bell? = false
      iex> CaptureIO.capture_io fn ->
      ...>   Helper.print_table(
      ...>     capitals, headers, key_headers,
      ...>     header_fixes, align_attrs, margins, column_widths, style, bell?
      ...>   )
      ...> end
      "\\n\\n" <> \"""
         +--------+---------+------------+
         | City   | Country | Population |
         +--------+---------+------------+
         | Ottawa | Canada  |  1,142,700 |
         | Zagreb | Croatia |    685,500 |
         | Paris  | France  |  9,854,000 |
         +--------+---------+------------+
      \""" <> "\\n\\n"
  """
  @spec print_table(
    [Formatter.row], [Formatter.collection_key], [Formatter.collection_key],
    map, map, Keyword.t, [Formatter.column_width], Style.t, boolean
  ) :: :ok
  def print_table(
    rows, headers, key_headers,
    header_fixes, align_attrs, margins, column_widths, style, bell?
  )
  do
    left_margin = String.duplicate " ", margins[:left]
    align_attrs = Enum.map headers, &Map.get(align_attrs, &1, :left)
    column_types = Enum.map headers, & &1 in key_headers && :key || :non_key
    headers = Enum.map headers, &Formatter.titlecase(&1, header_fixes)
    helper = %Helper{
      rows: rows, headers: headers, column_types: column_types,
      align_attrs: align_attrs, left_margin: left_margin,
      column_widths: column_widths, style: style
    }
    IO.write String.duplicate "\n", margins[:top]
    Enum.each Style.line_types(style), &write(helper, &1)
    IO.write String.duplicate "\n", margins[:bottom]
    IO.write bell? && "\a" || ""
  end

  @doc """
  Writes one or many table lines depending on the line `type` given.

  ## Line types

    - `:top`       - top line
    - `:header`    - line of table header(s)
    - `:separator` - separator line
    - `row types`  - list of _related_ row type(s)
    - `:bottom`    - bottom line

  ## Row types

    - `:row`      - single row type
    - `:even_row` - first alternating row type
    - `:odd_row`  - second alternating row type
    - `:row_1`    - first row type of repeating group of 3
    - `:row_2`    - second row type of repeating group of 3
    - `:row_3`    - third row type of repeating group of 3

  ## Examples

      alias IO.ANSI.Table.Formatter.Helper
      helper = %Helper{
        rows: [
          ["Ottawa", "Canada" , "1,142,700"],
          ["Zagreb", "Croatia",   "685,500"],
          ["Paris" , "France" , "9,854,000"]
        ],
        headers: ["City", "Country", "Population"],
        column_types: [:non_key, :key, :non_key],
        align_attrs: [:left, :left, :right],
        left_margin: "\s\s\s",
        column_widths: [6, 7, 10],
        style: :pretty_alt
      }
      Enum.each [:top, :header, :separator], &Helper.write(helper, &1)
  ## ![write_header](images/write_header.png)
      Helper.write helper, [:even_row, :odd_row]
  ## ![write_rows](images/write_rows.png)
  """
  @spec write(t, Style.line_type | [Style.row_type]) :: :ok
  def write(
    %Helper{column_widths: column_widths, style: style} = helper,
    type
  ) when type in [:top, :separator, :bottom]
  do
    column_widths
    |> Enum.map(&String.duplicate Style.dash(style, type), &1)
    |> write(type, helper)
  end
  def write(
    %Helper{headers: headers} = helper,
    type
  ) when type == :header
  do
    write(headers, type, helper)
  end
  def write(
    %Helper{rows: rows} = helper,
    type
  ) when is_list(type)
  do
    rows
    |> Stream.zip(Stream.cycle type)
    |> Enum.each(&write elem(&1, 0), elem(&1, 1), helper)
  end

  @spec write([elem], Style.line_type | Style.row_type, t) :: :ok
  defp write(
    elems, type,
    %Helper{
      rows: _rows, headers: _headers, column_types: column_types,
      align_attrs: align_attrs, left_margin: left_margin,
      column_widths: column_widths, style: style
    }
  )
  do
    items = items(elems, Style.borders(style, type))
    item_attrs = item_attrs(column_types, style, type)
    item_widths = item_widths(
      column_widths, elems, align_attrs, Style.border_widths(style, type)
    )
    IO.write left_margin
    :io.format(format(item_widths, item_attrs), items)
  end

  @doc """
  Takes an enumerable and a tuple of 3 `delimiters` (left, inner and right).

  Expands the `elements` in the enumerable by combining the `delimiters`.

  The inner `delimiter` is inserted between all `elements` and
  the result is then surrounded by the left and right `delimiters`.

  Returns a flattened list in case any `element` or `delimiter` is a list.

  ## Examples

      iex> alias IO.ANSI.Table.Formatter.Helper
      iex> elements = ["Number", "Created At", "Title"]
      iex> delimiters = {"<", "~", ">"}
      iex> Helper.expand(elements, delimiters)
      ["<", "Number", "~", "Created At", "~", "Title", ">"]

      iex> alias IO.ANSI.Table.Formatter.Helper
      iex> elements = ["Number", "Created At", "Title"]
      iex> delimiters = {["<", " "], [" ", "~", " "], [" ", ">"]}
      iex> Helper.expand(elements, delimiters)
      [ "<", " ",
        "Number",
        " ", "~", " ",
        "Created At",
        " ", "~", " ",
        "Title",
        " ", ">"
      ]

      iex> alias IO.ANSI.Table.Formatter.Helper
      iex> elements = [6, 10, 5]
      iex> delimiters = {[1, 1], [1, 1, 1], [1, 1]}
      iex> Helper.expand(elements, delimiters)
      [1, 1, 6, 1, 1, 1, 10, 1, 1, 1, 5, 1, 1]
  """
  @spec expand(Enumerable.t, {any, any, any}) :: [any]
  def expand(elems, {left, inner, right}) do
    List.flatten [left] ++ Enum.intersperse(elems, inner) ++ [right]
  end

  @doc """
  Takes a list of `elements` and a tuple of 3 `borders` (left, inner
  and right).

  Expands the list of `elements` by combining "fillers" and `borders`.

  ## Examples

      iex> alias IO.ANSI.Table.Formatter.Helper
      iex> elements = ["Number", "Created At", "Title"]
      iex> borders = {"<", "~", ">"}
      iex> Helper.items(elements, borders)
      [ "<", "",              # left border, filler
        "", "Number", "",     # filler, element, filler
        "", "~", "",          # filler, inner border, filler
        "", "Created At", "", # filler, element, filler
        "", "~", "",          # filler, inner border, filler
        "", "Title", "",      # filler, element, filler
        "", ">"               # filler, right border
      ]
  """
  @spec items([elem], Style.borders) :: [item]
  def items(elems, {left_border, inner_border, right_border}) do
    expand elems, {
      [    [    left_border,  ""], ""],
      ["", ["", inner_border, ""], ""],
      ["", ["", right_border    ]    ]
    }
  end

  @doc """
  Returns the list of attributes based on the given `column types`,
  table `style` and line/row `type`.

  ## Examples

      iex> alias IO.ANSI.Table.Formatter.Helper
      iex> column_types = [:non_key, :key, :non_key]
      iex> style = :medium
      iex> type = :header
      iex> Helper.item_attrs(column_types, style, type)
      [ :light_yellow, :normal,                       # left border
        :normal, :light_green, :normal,               # non key column
        :normal, :light_yellow, :normal,              # inner border
        :normal, [:light_green, :underline], :normal, # key column
        :normal, :light_yellow, :normal,              # inner border
        :normal, :light_green, :normal,               # non key column
        :normal, :light_yellow                        # right border
      ]

      iex> alias IO.ANSI.Table.Formatter.Helper
      iex> column_types = [:non_key, :key, :non_key]
      iex> style = :dark
      iex> type = :row
      iex> Helper.item_attrs(column_types, style, type)
      [ :light_green, :normal,            # left border
        :normal, :light_green, :normal,   # non key column
        :normal, :light_green, :normal,   # inner border
        :normal, :light_magenta, :normal, # key column
        :normal, :light_green, :normal,   # inner border
        :normal, :light_green, :normal,   # non key column
        :normal, :light_green             # right border
      ]
  """
  @spec item_attrs([column_type], Style.t, Style.line_type | Style.row_type) ::
    [Style.attr]
  def item_attrs(column_types, style, type) do
    # wrap attributes in braces to prevent flattening
    border_attr  = {Style.border_attr(style, type)}
    filler_attr  = {Style.filler_attr(style, type)}
    key_attr     = {Style.key_attr(style, type)}
    non_key_attr = {Style.non_key_attr(style, type)}
    column_types
    |> Enum.map(& &1 == :key && key_attr || non_key_attr)
    |> expand({
      [             [             border_attr, filler_attr], filler_attr],
      [filler_attr, [filler_attr, border_attr, filler_attr], filler_attr],
      [filler_attr, [filler_attr, border_attr             ]             ]
    })
    |> Enum.map(& elem &1, 0) # unwrap attributes
  end

  @doc """
  Takes a list of `column widths`, a list of `elements`, a list of
  `align attributes` and a tuple of 3 multipart `border widths`
  (left, inner and right):

    - `left`  - widths of left border and "filler"
    - `inner` - widths of "filler", inner border and "filler"
    - `right` - widths of "filler" and right border

  Returns the widths of `elements` and their "fillers" combined with
  `border widths`.

  ## Examples

      iex> alias IO.ANSI.Table.Formatter.Helper
      iex> column_widths = [7, 13, 11]
      iex> elems = ["Number", "Created At", "Title"]
      iex> align_attrs = [:right, :center, :left]
      iex> border_widths = {[1, 1], [1, 1, 1], [1, 1]}
      iex> Helper.item_widths(column_widths, elems, align_attrs, border_widths)
      [1, 1, 1, 6, 0, 1, 1, 1, 1, 10, 2, 1, 1, 1, 0, 5, 6, 1, 1]
  """
  @spec item_widths(
    [Formatter.column_width], [elem], [align_attr],
    Style.border_widths
  ) :: [item_width]
  def item_widths(
    column_widths, elems, align_attrs,
    {left_border_widths, inner_border_widths, right_border_widths}
  )
  do
    Stream.zip([column_widths, elems, align_attrs])
    |> Stream.map(&column_widths &1)
    |> expand({left_border_widths, inner_border_widths, right_border_widths})
  end

  @spec column_widths({Formatter.column_width, elem, align_attr}) ::
    [non_neg_integer]
  defp column_widths {column_width, elem, :left} do
    elem_width = min String.length(elem), column_width
    left_filler_width = 0
    right_filler_width = column_width - elem_width
    [left_filler_width, elem_width, right_filler_width]
  end
  defp column_widths {column_width, elem, :right} do
    elem_width = min String.length(elem), column_width
    left_filler_width = column_width - elem_width
    right_filler_width = 0
    [left_filler_width, elem_width, right_filler_width]
  end
  defp column_widths {column_width, elem, :center} do
    elem_width = min String.length(elem), column_width
    left_filler_width = div column_width - elem_width, 2
    right_filler_width = column_width - left_filler_width - elem_width
    [left_filler_width, elem_width, right_filler_width]
  end
  defp column_widths {column_width, elem, _faulty} do
    column_widths {column_width, elem, :left}
  end

  @doc ~S"""
  Takes a list of `item widths` and a list of corresponding
  `item attributes`.

  Returns an Erlang io format reflecting these `item widths` and
  `item attributes`. It consists of a string with embedded
  [ANSI color codes](https://gist.github.com/chrisopedia/8754917)
  (escape sequences).

  Here are a few ANSI color codes:

    - light yellow - \\e[93m
    - light cyan   - \\e[96m
    - reset        - \\e[0m

  ## Examples

      iex> alias IO.ANSI.Table.Formatter.Helper
      iex> item_widths = [2, 0, 6]
      iex> item_attrs = [:light_yellow, :normal, :light_cyan]
      iex> Helper.format(item_widths, item_attrs)
      "\e[93m~-2ts\e[0m~-0ts\e[96m~-6ts\e[0m~n"
  """
  @spec format([non_neg_integer], [Style.attr]) :: String.t
  def format(item_widths, item_attrs) do
    fragments = # => chardata (list of strings and/or improper lists)
      item_widths
      |> Enum.zip(item_attrs)
      |> Enum.map(fn {width, attr} ->
        case attr do
          :normal -> "~-#{width}ts" # t for Unicode translation
          _ -> IO.ANSI.format [attr, "~-#{width}ts"], @ansi_enabled
        end
      end)
    "#{fragments}~n" # => string embedded with ANSI escape sequences
  end
end
