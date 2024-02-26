defmodule IO.ANSI.Table.Spec.ColumnWidths do
  @moduledoc """
  Derives the column widths of a table.
  """

  alias IO.ANSI.Table.Spec.Rows
  alias IO.ANSI.Table.{Column, Spec}

  @doc """
  Derives the column widths of a table.

  ## Examples

      iex> alias IO.ANSI.Table.Spec.{ColumnWidths, Headings, Rows}
      iex> alias IO.ANSI.Table.Spec
      iex> spec = Spec.new([:c4, :c1, :c2])
      iex> maps = [%{c1: 11, c2: 12, c4: 14}, %{c1: 21, c2: 22, c4: :r2c4}]
      iex> spec = Headings.derive_and_put(spec)
      iex> spec = Rows.derive_and_put(spec, maps)
      iex> spec = ColumnWidths.derive_and_put(spec)
      iex> %Spec{column_widths: column_widths} = spec
      iex> column_widths
      [4, 2, 2]
  """
  @spec derive_and_put(Spec.t()) :: Spec.t()
  def derive_and_put(
        %Spec{
          headings: headings,
          rows: rows,
          max_width: max
        } = spec
      ) do
    widths = [headings | rows] |> Rows.transpose() |> Column.widths(max)
    put_in(spec.column_widths, widths)
  end
end
