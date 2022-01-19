defmodule IO.ANSI.Table.Spec.ColumnWidths do
  @moduledoc """
  Derives the column widths of a table.
  """

  alias IO.ANSI.Table.Spec.Rows
  alias IO.ANSI.Table.{Column, Spec}

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
