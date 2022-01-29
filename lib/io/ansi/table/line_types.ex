defmodule IO.ANSI.Table.LineTypes do
  @moduledoc """
  Builds a list of line types from a reversed list of non-row/row line types.
  """

  use PersistConfig

  alias IO.ANSI.Table.LineType

  @row_types get_env(:row_types)

  @doc """
  Builds a list of line types from a reversed list of non-row/row line `types`.
  
  ## Examples
  
      iex> alias IO.ANSI.Table.LineTypes
      iex> types = Enum.reverse([:top, :header, :separator, :row, :bottom])
      iex> LineTypes.from(types)
      [:top, :header, :separator, [:row], :bottom]
  
      iex> alias IO.ANSI.Table.LineTypes
      iex> types = [:top, :header, :separator, :even_row, :odd_row, :bottom]
      iex> types = Enum.reverse(types)
      iex> LineTypes.from(types)
      [:top, :header, :separator, [:even_row, :odd_row], :bottom]
  
      iex> alias IO.ANSI.Table.LineTypes
      iex> types = Enum.reverse([:header, :separator, :row_1, :row_2, :row_3])
      iex> LineTypes.from(types)
      [:header, :separator, [:row_1, :row_2, :row_3]]
  
      iex> alias IO.ANSI.Table.LineTypes
      iex> types = Enum.reverse(
      ...>   [:header, :separator, :row, :separator, :row_1, :row_2, :row_3]
      ...> )
      iex> LineTypes.from(types)
      [:header, :separator, [:row], :separator, [:row_1, :row_2, :row_3]]
  """
  @spec from([LineType.non_row() | LineType.row()]) :: [LineType.t()]
  def from(types), do: Enum.reduce(types, [], &acc/2)

  ## Private functions

  @spec acc(LineType.non_row() | LineType.row(), [LineType.t()]) ::
          [LineType.t()]
  defp acc(type, [hd | tl]) when type in @row_types and is_list(hd) do
    [[type | hd] | tl]
  end

  defp acc(type, acc) when type in @row_types, do: [[type] | acc]
  defp acc(type, acc), do: [type | acc]
end
