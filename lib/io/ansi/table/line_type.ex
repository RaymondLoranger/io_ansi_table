defmodule IO.ANSI.Table.LineType do
  @moduledoc """
  Defines the `line type` types.
  """

  @type non_row :: :top | :header | :separator | :bottom
  @type row :: :row | :even_row | :odd_row | :row_1 | :row_2 | :row_3
  @type t :: non_row | [row]
end
