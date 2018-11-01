defmodule IO.ANSI.Table.LineType do
  @moduledoc """
  Derives the line types of a table style.
  """

  use PersistConfig

  @typep non_row :: :top | :header | :separator | :bottom
  @typep row :: :row | :even_row | :odd_row | :row_1 | :row_2 | :row_3
  @type t :: non_row | [row]

  @row_types Application.get_env(@app, :row_types)

  @doc """
  Structures a flat list of line `types`.

  ## Examples

      iex> alias IO.ANSI.Table.LineType
      iex> types = [:top, :header, :separator, :row, :bottom]
      iex> LineType.to_line_types(types, false)
      [:top, :header, :separator, [:row], :bottom]

      iex> alias IO.ANSI.Table.LineType
      iex> types = [:top, :header, :separator, :even_row, :odd_row, :bottom]
      iex> LineType.to_line_types(types, false)
      [:top, :header, :separator, [:even_row, :odd_row], :bottom]
  """
  @spec to_line_types([non_row | row]) :: [t]
  def to_line_types(types, reversed \\ true)

  def to_line_types(types, true = _reversed) do
    Enum.reduce(types, [], &acc/2)
  end

  def to_line_types(types, _reversed) do
    types |> Enum.reverse() |> to_line_types()
  end

  ## Private functions

  @spec acc(non_row | row, [t]) :: [t]
  defp acc(type, [hd | tl]) when type in @row_types and is_list(hd) do
    [[type | hd] | tl]
  end

  defp acc(type, acc) when type in @row_types, do: [[type] | acc]
  defp acc(type, acc), do: [type | acc]
end
