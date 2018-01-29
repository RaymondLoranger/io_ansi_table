defmodule IO.ANSI.Table.Formatter do
  @moduledoc false

  use PersistConfig

  alias IO.ANSI.Table.{Line, Spec, Style}

  @rule_types Application.get_env(@app, :rule_types)

  @spec print_table(Spec.t(), [Access.container()], Keyword.t()) :: :ok
  def print_table(spec, maps, options \\ []) do
    spec
    |> Spec.apply(options)
    |> Spec.deploy(maps)
    |> write_table()
  end

  ## Private functions

  @spec write_table(Spec.t()) :: :ok
  defp write_table(%{} = spec) do
    String.duplicate("\n", spec.margins[:top] || 0) |> IO.write()
    Style.line_types(spec.style) |> Enum.each(&write_line_type(&1, spec))
    String.duplicate("\n", spec.margins[:bottom] || 0) |> IO.write()
    IO.write((spec.bell && "\a") || "")
  end

  @spec write_line_type(Style.line_type(), Spec.t()) :: :ok
  defp write_line_type(type, %{} = spec) when type in @rule_types do
    spec.column_widths
    |> Enum.map(&(Style.dash(spec.style, type) |> String.duplicate(&1)))
    |> write_line(type, spec)
  end

  defp write_line_type(:header = type, %{} = spec) do
    write_line(spec.headings, type, spec)
  end

  defp write_line_type(type, %{} = spec) when is_list(type) do
    spec.rows
    |> Stream.zip(Stream.cycle(type))
    |> Enum.each(fn {row, type} -> write_line(row, type, spec) end)
  end

  @spec write_line([Line.elem()], Style.line_type(), Spec.t()) :: :ok
  defp write_line(elems, type, %{} = spec) do
    IO.write(spec.left_margin)
    items = Line.items(elems, Style.borders(spec.style, type))
    item_attrs = Line.item_attrs(type, spec)
    item_widths = Line.item_widths(elems, type, spec)
    format = Line.format(item_widths, item_attrs)
    :io.format(format, items)
  end
end
