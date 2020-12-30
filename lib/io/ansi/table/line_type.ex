defmodule IO.ANSI.Table.LineType do
  @moduledoc """
  Defines the `line type` types.
  Also writes the line(s) of a given `line type`.
  """

  use PersistConfig

  alias IO.ANSI.Table.{Line, Spec, Style}

  @rule_types get_env(:rule_types)

  @type non_row :: :top | :header | :separator | :bottom
  @type row :: :row | :even_row | :odd_row | :row_1 | :row_2 | :row_3
  @type t :: non_row | [row]

  @spec write_lines(t, Spec.t()) :: :ok
  def write_lines(type, spec) when type in @rule_types do
    dash = Style.dash(spec.style, type)

    spec.column_widths
    |> Enum.map(&String.duplicate(dash, &1))
    |> write_line(type, spec)
  end

  def write_lines(:header = type, spec) do
    write_line(spec.headings, type, spec)
  end

  def write_lines(type, spec) when is_list(type) do
    Enum.zip(spec.rows, Stream.cycle(type))
    |> Enum.each(fn {row, type} -> write_line(row, type, spec) end)
  end

  ## Private functions

  @spec write_line([Line.elem()], non_row | row, Spec.t()) :: :ok
  defp write_line(elems, type, spec) do
    IO.write(spec.left_margin)
    items = Line.items(elems, Style.borders(spec.style, type))
    item_attrs = Line.item_attrs(type, spec)
    item_widths = Line.item_widths(elems, type, spec)
    format = Line.format(item_widths, item_attrs)
    :io.format(format, items)
  end
end
