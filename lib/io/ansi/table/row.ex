defmodule IO.ANSI.Table.Row do
  @moduledoc """
  Functions related to the rows of a table.
  """

  alias IO.ANSI.Table.Spec

  @type t :: [String.t()]

  @spec rows(Spec.t(), [Access.container()]) :: Spec.t()
  def rows(spec, maps) do
    require MapSorter

    rows =
      maps
      |> MapSorter.sort(spec.sort_specs)
      |> Enum.take(spec.count)
      |> to_rows(spec.headers)

    %{spec | rows: rows}
  end

  ## Private functions

  # @doc """
  # Converts 'maps` to "rows".

  # ## Examples

  #     iex> alias IO.ANSI.Table.Row
  #     iex> list = [
  #     ...>   %{a: 1, b: 2, c: 3},
  #     ...>   %{a: 4, b: 5, c: 6}
  #     ...> ]
  #     iex> Row.to_rows(list, [:c, :a])
  #     [["3", "1"], ["6", "4"]]

  #     iex> alias IO.ANSI.Table.Row
  #     iex> list = [
  #     ...>   %{:one => "1", '2' => 2.0, "3" => :three},
  #     ...>   %{:one => '4', '2' => "5", "3" => 000006}
  #     ...> ]
  #     iex> Row.to_rows(list, ["3", :one, '2'])
  #     [["three", "1", "2.0"], ["6", "4", "5"]]
  # """
  @spec to_rows([map], [any]) :: [t]
  defp to_rows(maps, keys) do
    for map <- maps do
      for key <- keys, do: map[key] |> to_string()
    end
  end
end
