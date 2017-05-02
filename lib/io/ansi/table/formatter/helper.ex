
defmodule IO.ANSI.Table.Formatter.Helper do
  @moduledoc """
  Prints a table of rows with headers, applying a table style (configurable).
  """

  alias IO.ANSI.Table.{Formatter, Formatter.Helper, Style}

  Mix.Project.config[:config_path] |> Mix.Config.read! |> Mix.Config.persist
  @external_resource Path.expand Mix.Project.config[:config_path]
  @app               Mix.Project.config[:app]
  @ansi_enabled      Application.get_env(@app, :ansi_enabled)

  defstruct rows: nil, headers: nil, key_headers: nil,
    header_fixes: nil, margin: nil, widths: nil, style: nil

  @type t :: %Helper{
    rows: [Formatter.row] | nil,
    headers: [Formatter.collection_key] | nil,
    key_headers: [Formatter.collection_key] | nil,
    header_fixes: map | nil,
    margin: String.t | nil,
    widths: [Formatter.column_width] | nil,
    style: Style.t | nil
  }

  @doc """
  Creates a table formatter helper (struct).
  """
  @spec new(
    [Formatter.row], [Formatter.collection_key], [Formatter.collection_key],
    map, String.t, [Formatter.column_width], Style.t
  ) :: Helper.t
  def new(
    rows, headers, key_headers,
    header_fixes, margin, widths, style
  )
  do
    %Helper{
      rows: rows, headers: headers, key_headers: key_headers,
      header_fixes: header_fixes, margin: margin, widths: widths, style: style
    }
  end

  @doc """
  Takes a list of `rows` (string sublists), a list of `headers`, a list
  of `key headers`, a map of `header fixes`, a keyword list of `margins`,
  a list of column `widths`, a table `style` and whether to ring the `bell`.

  Prints a table to STDOUT of the strings in each `row`.
  The columns are identified by successive `headers`.

  ## Table styles

  #{Style.texts "  - `&style`&filler - &note\n"}

  ## Examples

      alias IO.ANSI.Table.Formatter.Helper
      capitals = [
        ["Ottawa", "Canada" , "1,142,700"],
        ["Zagreb", "Croatia", "  685,500"],
        ["Paris" , "France" , "9,854,000"]
      ]
      headers = ['city', 'country', 'population']
      key_headers = ['country']
      header_fixes = %{}
      margins = [top: 2, bottom: 2, left: 2]
      widths = [6, 7, 10]
      table_style = :medium
      bell = true
      Helper.print_table(
        capitals, headers, key_headers,
        header_fixes, margins, widths, table_style, bell
      )
  ## ![print_table_capitals](images/print_table_capitals.png)
      iex> alias IO.ANSI.Table.Formatter.Helper
      iex> alias ExUnit.CaptureIO
      iex> capitals = [
      ...>   ["Ottawa", "Canada" , "1,142,700"],
      ...>   ["Zagreb", "Croatia", "  685,500"],
      ...>   ["Paris" , "France" , "9,854,000"]
      ...> ]
      iex> headers = ['city', :country, "population"]
      iex> key_headers = [:country]
      iex> header_fixes = %{}
      iex> margins = [top: 2, bottom: 2, left: 3]
      iex> widths = [6, 7, 10]
      iex> table_style = :dashed
      iex> bell = false
      iex> CaptureIO.capture_io fn ->
      ...>   Helper.print_table(
      ...>     capitals, headers, key_headers,
      ...>     header_fixes, margins, widths, table_style, bell
      ...>   )
      ...> end
      "\\n\\n" <> \"""
         +--------+---------+------------+
         | City   | Country | Population |
         +--------+---------+------------+
         | Ottawa | Canada  | 1,142,700  |
         | Zagreb | Croatia |   685,500  |
         | Paris  | France  | 9,854,000  |
         +--------+---------+------------+
      \""" <> "\\n\\n"
  """
  @spec print_table(
    [Formatter.row], [Formatter.collection_key], [Formatter.collection_key],
    map, Keyword.t, [Formatter.column_width], Style.t, boolean
  ) :: :ok
  def print_table(
    rows, headers, key_headers,
    header_fixes, margins, widths, style, bell
  )
  do
    margin = String.duplicate " ", margins[:left]
    helper = new(
      rows, headers, key_headers, header_fixes, margin, widths, style
    )
    IO.write String.duplicate("\n", margins[:top])
    Enum.each Style.line_types(style), &write(helper, &1)
    IO.write String.duplicate("\n", margins[:bottom])
    IO.write bell && "\a" || ""
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
          ["Zagreb", "Croatia", "  685,500"],
          ["Paris" , "France" , "9,854,000"]
        ],
        headers: ["city", "country", "population"],
        key_headers: ["country"],
        header_fixes: %{},
        margin: "\s\s\s",
        widths: [6, 7, 10],
        style: :pretty_alt
      }
      Enum.each [:top, :header, :separator], &Helper.write(helper, &1)
  ## ![write_header](images/write_header.png)
      Helper.write helper, [:even_row, :odd_row]
  ## ![write_rows](images/write_rows.png)
  """
  @spec write(Helper.t, Style.line_type | [Style.row_type]) :: :ok
  def write(helper = %Helper{widths: widths, style: style}, type) when
    type in [:top, :separator, :bottom]
  do
    widths
    |> Enum.map(&String.duplicate Style.dash(style, type), &1)
    |> write(type, helper)
  end
  def write(
    helper = %Helper{headers: headers, header_fixes: header_fixes}, type
  ) when type == :header
  do
    headers
    |> Enum.map(&Formatter.titlecase &1, header_fixes)
    |> write(type, helper)
  end
  def write(helper = %Helper{rows: rows}, type) when is_list(type) do
    rows
    |> Stream.zip(Stream.cycle type)
    |> Enum.each(&write elem(&1, 0), elem(&1, 1), helper)
  end

  @spec write([String.t], Style.line_type | Style.row_type, Helper.t)
  :: :ok
  defp write(elems, type, %Helper{
    rows: _rows, headers: headers, key_headers: key_headers,
    header_fixes: _header_fixes, margin: margin, widths: widths, style: style
  })
  do
    items = items(elems, Style.borders(style, type))
    attrs = attrs(headers, key_headers, style, type)
    widths = widths(widths, elems, Style.border_widths(style, type))
    IO.write margin
    :io.format(format(widths, attrs), items)
  end

  @doc """
  Takes a list of `elements` and a tuple of 3 `delimiters` (left,
  inner and right).

  Expands the list of `elements` by combining the `delimiters`.

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
  @spec expand([any], {any, any, any}) :: [any]
  def expand(elems, {left, inner, right}) do
    List.flatten [left] ++ Enum.intersperse(elems, inner) ++ [right]
  end

  @doc """
  Takes a list of `elements` and a tuple of 3 `borders` (left, inner
  and right).

  Will expand the list of `elements` by combining "fillers" and `borders`.

  ## Examples

      iex> alias IO.ANSI.Table.Formatter.Helper
      iex> elements = ["Number", "Created At", "Title"]
      iex> borders = {"<", "~", ">"}
      iex> Helper.items(elements, borders)
      [ "<", "",
        "Number", "",
        "", "~", "",
        "Created At", "",
        "", "~", "",
        "Title", "",
        "", ">"
      ]
  """
  @spec items([String.t], {String.t, String.t, String.t}) :: [String.t]
  def items(elems, {left_border, inner_border, right_border}) do
    expand(elems, {
      [    [    left_border,  ""]],
      ["", ["", inner_border, ""]],
      ["", ["", right_border    ]]
    })
  end

  @doc """
  Returns the list of attributes for a given table `style` and line/row `type`.

  ## Examples

      iex> alias IO.ANSI.Table.Formatter.Helper
      iex> headers = ["Number", "Created At", "Title"]
      iex> key_headers = ["Created At"]
      iex> style = :dark
      iex> type = :header
      iex> Helper.attrs(headers, key_headers, style, type)
      [ :light_green, :normal,                          # left border
        :light_red, :normal,                            # non key column
        :normal, :light_green, :normal,                 # inner border
        [:light_white, :light_red_background], :normal, # key column
        :normal, :light_green, :normal,                 # inner border
        :light_red, :normal,                            # non key column
        :normal, :light_green                           # right border
      ]

      iex> alias IO.ANSI.Table.Formatter.Helper
      iex> headers = ["Number", "Created At", "Title"]
      iex> key_headers = ["Created At"]
      iex> style = :dark
      iex> type = :row
      iex> Helper.attrs(headers, key_headers, style, type)
      [ :light_green, :normal,          # left border
        :light_green, :normal,          # non key column
        :normal, :light_green, :normal, # inner border
        :light_magenta, :normal,        # key column
        :normal, :light_green, :normal, # inner border
        :light_green, :normal,          # non key column
        :normal, :light_green           # right border
      ]
  """
  @spec attrs(
    [Formatter.collection_key], [Formatter.collection_key],
    Style.t, Style.line_type | Style.row_type
  ) :: [Style.attr]
  def attrs(headers, key_headers, style, type) do
    border_attr  = Style.border_attr(style, type)
    filler_attr  = Style.filler_attr(style, type)
    key_attr     = Style.key_attr(style, type)
    non_key_attr = Style.non_key_attr(style, type)
    headers
    |> Enum.map(&(&1 in key_headers && {key_attr} || {non_key_attr}))
    |> expand({ # wrap attributes in braces to prevent flattening
      [               [               {border_attr}, {filler_attr}]],
      [{filler_attr}, [{filler_attr}, {border_attr}, {filler_attr}]],
      [{filler_attr}, [{filler_attr}, {border_attr}               ]]
    })
    |> Enum.map(&(elem &1, 0)) # unwrap attributes
  end

  @doc """
  Takes a list of column `widths`, a list of `elements` and a tuple
  of 3 multipart `border widths` (left, inner and right):

    - `left`  - widths of left border and "filler"
    - `inner` - widths of "filler", inner border and "filler"
    - `right` - widths of "filler" and right border

  Returns the widths of `elements` and their "fillers" combined with
  `border widths`.

  ## Examples

      iex> alias IO.ANSI.Table.Formatter.Helper
      iex> widths = [6, 13, 11]
      iex> elements = ["Number", "Created At", "Title"]
      iex> border_widths = {[1, 1], [1, 1, 1], [1, 1]}
      iex> Helper.widths(widths, elements, border_widths)
      [1, 1, 6, 0, 1, 1, 1, 10, 3, 1, 1, 1, 5, 6, 1, 1]
  """
  @spec widths([Formatter.column_width], [String.t], {[...], [...], [...]})
  :: [non_neg_integer]
  def widths(widths, elems, {
    left_border_width, inner_border_width, right_border_width
  })
  do
    widths
    |> Enum.zip(elems)
    |> Enum.map(fn {w, e} ->
      #┌─────elem length──────┐  ┌──────filler length───────┐
      [min(String.length(e), w), w - min(String.length(e), w)]
    end)
    |> expand({left_border_width, inner_border_width, right_border_width})
  end

  @doc ~S"""
  Takes a list of `widths` and a list of corresponding `attributes`.

  Returns an Erlang io format reflecting these `widths` and `attributes`.
  It consists of a string with embedded
  [ANSI color codes](https://gist.github.com/chrisopedia/8754917)
  (escape sequences).

  Here are a few ANSI color codes:

    - light yellow - \\e[93m
    - light cyan   - \\e[96m
    - reset        - \\e[0m

  ## Examples

      iex> alias IO.ANSI.Table.Formatter.Helper
      iex> widths = [2, 0, 6]
      iex> attrs = [:light_yellow, :normal, :light_cyan]
      iex> Helper.format(widths, attrs)
      "\e[93m~-2ts\e[0m~-0ts\e[96m~-6ts\e[0m~n"
  """
  @spec format([non_neg_integer], [Style.attr]) :: String.t
  def format(widths, attrs) do
    fragments = # => chardata (list of strings and/or improper lists)
      widths
      |> Enum.zip(attrs)
      |> Enum.map(fn {width, attr} ->
        case attr do
          :normal -> "~-#{width}ts" # t for Unicode translation
          _ -> IO.ANSI.format [attr, "~-#{width}ts"], @ansi_enabled
        end
      end)
    "#{fragments}~n" # => string embedded with ANSI escape sequences
  end
end
