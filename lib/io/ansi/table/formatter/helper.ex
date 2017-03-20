
defmodule IO.ANSI.Table.Formatter.Helper do
  @moduledoc """
  Prints a table of rows with headers, applying a table style (configurable).
  """

  alias IO.ANSI.Table.Config
  alias IO.ANSI.Table.Formatter
  alias IO.ANSI.Table.Style

  @ansi_enabled  Config.ansi_enabled?
  @app           Mix.Project.config[:app]
  @margins       Application.get_env(@app, :margins, [])
  @margin_bottom Config.margin_bottom(@margins)
  @margin_left   Config.margin_left(@margins)
  @margin_top    Config.margin_top(@margins)

  defstruct rows: nil, headers: nil, key: nil, widths: nil, style: nil

  @doc """
  Creates a new table formatter helper (struct).
  """
  @spec new([[String.t]], [any], any, [non_neg_integer], atom) :: %__MODULE__{}
  def new(rows, headers, key, widths, style) do
    %__MODULE__{
      rows: rows, headers: headers, key: key, widths: widths, style: style
    }
  end

  @doc """
  Takes a list of `rows` (string sublists), a list of `headers`,
  a `key` `header`, a list of column `widths`, a table `style` and
  whether to ring the bell.

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
      key_header = 'country'
      widths = [6, 7, 10]
      table_style = :medium
      bell = true
      Helper.print_table(
        capitals, headers, key_header, widths, table_style, bell
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
      iex> key_header = :country
      iex> widths = [6, 7, 10]
      iex> table_style = :dashed
      iex> bell = false
      iex> CaptureIO.capture_io fn ->
      ...>   Helper.print_table(
      ...>     capitals, headers, key_header, widths, table_style, bell
      ...>   )
      ...> end
      \"""
      +--------+---------+------------+
      | City   | Country | Population |
      +--------+---------+------------+
      | Ottawa | Canada  | 1,142,700  |
      | Zagreb | Croatia |   685,500  |
      | Paris  | France  | 9,854,000  |
      +--------+---------+------------+
      \"""
  """
  @spec print_table(
    [[String.t]], [any], any, [non_neg_integer], atom, boolean
  ) :: :ok
  def print_table(rows, headers, key, widths, style, bell) do
    helper = new(rows, headers, key, widths, style)
    IO.write @margin_top
    Enum.each Config.line_types, &write(helper, &1)
    IO.write @margin_bottom
    IO.write bell && "\a" || ""
  end

  @doc """
  Writes one or many table lines depending on the line `type` given (atom).

  ## Line types

    - `:top`       - top line
    - `:header`    - line of header(s) between top & separator
    - `:separator` - separator line between header & data
    - `:data`      - line(s) of data item(s) between separator & bottom
    - `:bottom`    - bottom line

  ## Examples

      # Evaluate rows, headers, key, widths and style...
      alias IO.ANSI.Table.Formatter.Helper
      helper = Helper.new(rows, headers, key, widths, style)
      Helper.write(helper, :data)
  """
  @spec write(%__MODULE__{}, atom) :: :ok
  def write(helper = %__MODULE__{widths: widths, style: style}, type)
    when type in [:top, :separator, :bottom]
  do
    widths
    |> Enum.map(&String.duplicate Style.dash(style, type), &1)
    |> write(type, helper)
  end
  def write(helper = %__MODULE__{headers: headers}, type)
    when type == :header
  do
    headers
    |> Enum.map(&Formatter.titlecase/1)
    |> write(type, helper)
  end
  def write(helper = %__MODULE__{rows: rows}, type)
    when type == :data
  do
    Enum.each rows, &write(&1, type, helper)
  end

  @spec write([String.t], atom, %__MODULE__{}) :: :ok
  defp write(elems, type, %__MODULE__{
    rows: _rows, headers: headers, key: key, widths: widths, style: style
  })
  do
    items = items(elems, Style.borders(style, type))
    if Enum.all? items, &(&1 =~ ~r/^\s*$/) do
      :ok # do not print all blank items
    else
      attrs = attrs(headers, key, style, type)
      widths = widths(widths, elems, Style.border_widths(style, type))
      :io.format(format(widths, attrs), items)
    end
  end

  @doc """
  Takes a list of `elements` and 3 `delimiters` (`left`, `inner` and `right`).

  Expands the list of `elements` by combining the `delimiters`.

  The `inner` `delimiter` is inserted between all `elements` and
  the result is then surrounded by the `left` and `right` `delimiters`.

  Returns a flattened list in case any `element`/`delimiter` is a list.

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
      [
        "<", " ",
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

  @spec items([String.t], {String.t, String.t, String.t}) :: [String.t]
  defp items(elems, {left_border, inner_border, right_border}) do
    expand(elems, {
      [    [    left_border,  ""]],
      ["", ["", inner_border, ""]],
      ["", ["", right_border    ]]
    })
  end

  @spec attrs([any], any, atom, atom) :: [any]
  defp attrs(headers, key, style, type) do
    border_attr  = Style.border_attr(style)
    filler_attr  = Style.filler_attr(style)
    key_attr     = Style.key_attr(style, type)
    non_key_attr = Style.non_key_attr(style, type)
    headers
    |> Enum.map(&(&1 == key && {key_attr} || {non_key_attr}))
    |>expand({ # wrap attributes in braces to prevent flattening
      [               [               {border_attr}, {filler_attr}]],
      [{filler_attr}, [{filler_attr}, {border_attr}, {filler_attr}]],
      [{filler_attr}, [{filler_attr}, {border_attr}               ]]
    })
    |> Enum.map(&(elem &1, 0)) # unwrap attributes
  end

  @spec widths([non_neg_integer], [String.t], {[...], [...], [...]})
    :: [non_neg_integer]
  defp widths(elem_widths, elems, {
    left_border_width, inner_border_width, right_border_width
  })
  do
    elem_widths
    |> Enum.zip(elems) #      ┌─elem length──┐  ┌──filler length───┐
    |> Enum.map(fn {w, e} -> [String.length(e), w - String.length(e)] end)
    |> expand({left_border_width, inner_border_width, right_border_width})
  end

  @doc ~S"""
  Takes a list of `widths` and a list of corresponding `attributes`.

  Returns an Erlang io format reflecting these `widths` and `attributes`.

  For details of ANSI color codes (`attributes`) see
  [ANSI color codes](https://gist.github.com/chrisopedia/8754917).

  Here are a few examples:

  - light yellow - \\e[93m
  - light cyan   - \\e[96m
  - reset        - \\e[0m

  ## Examples

      iex> alias IO.ANSI.Table.Formatter.Helper
      iex> widths = [2, 0, 6]
      iex> attrs = [:light_yellow, :normal, :light_cyan]
      iex> Helper.format(widths, attrs)
      #~S" \e[93m~-2ts\e[0m~-0ts\e[96m~-6ts\e[0m~n"
      "\e[93m~-2ts\e[0m~-0ts\e[96m~-6ts\e[0m~n"
  """
  @spec format([non_neg_integer], [[atom] | atom]) :: String.t
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
    "#{@margin_left}#{fragments}~n" # => string of ANSI escape sequences
  end
end
