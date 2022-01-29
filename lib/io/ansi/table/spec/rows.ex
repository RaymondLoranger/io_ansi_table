defmodule IO.ANSI.Table.Spec.Rows do
  @moduledoc """
  Derives the rows of a table.
  Also transposes rows into columns.
  """

  alias IO.ANSI.Table.{Column, Header, Row, Spec}

  @doc """
  Derives the rows of a table given `spec` and `maps`.

  ## Examples

      iex> alias IO.ANSI.Table.Spec.Rows
      iex> alias IO.ANSI.Table.Spec
      iex> spec = Spec.new([:c4, :c1, :c2])
      iex> maps = [%{c1: 11, c2: 12, c4: 14}, %{c1: 21, c2: 22, c4: 24}]
      iex> %Spec{rows: rows} = Rows.derive_and_put(spec, maps)
      iex> rows
      [["14", "11", "12"], ["24", "21", "22"]]
  """
  @spec derive_and_put(Spec.t(), [Access.container()]) :: Spec.t()
  def derive_and_put(
        %Spec{
          count: count,
          headers: headers,
          sort_specs: specs
        } = spec,
        maps
      ) do
    require MapSorter
    rows = MapSorter.sort(maps, specs) |> Enum.take(count) |> select(headers)
    put_in(spec.rows, rows)
  end

  @doc """
  Transposes `rows` into columns.

  ## Examples

      iex> alias IO.ANSI.Table.Spec.Rows
      iex> rows = [
      ...>   ["1", "2", "3"],
      ...>   ["4", "5", "6"]
      ...> ]
      iex> Rows.transpose(rows)
      [["1", "4"], ["2", "5"], ["3", "6"]]
  """
  @spec transpose([Row.t()]) :: [Column.t()]
  def transpose(rows), do: Enum.zip(rows) |> Enum.map(&Tuple.to_list/1)

  ## Private functions

  # @doc """
  # Gets the values for `headers` in `maps` and returns a list of rows.

  # ## Examples

  #     iex> alias IO.ANSI.Table.Spec.Rows
  #     iex> maps = [
  #     ...>   %{a: 1, b: 2, c: 3},
  #     ...>   %{a: 4, b: 5, c: 6}
  #     ...> ]
  #     iex> Rows.select(maps, [:c, :a])
  #     [["3", "1"], ["6", "4"]]

  #     iex> alias IO.ANSI.Table.Spec.Rows
  #     iex> maps = [
  #     ...>   %{:one => "1", '2' => 2.0, "3" => :three},
  #     ...>   %{:one => '4', '2' => "5", "3" => 000006}
  #     ...> ]
  #     iex> Rows.select(maps, ["3", :one, '2'])
  #     [["three", "1", "2.0"], ["6", "4", "5"]]
  # """
  @spec select([Access.container()], [Header.t()]) :: [Row.t()]
  defp select(maps, headers) do
    for map <- maps do
      for header <- headers, do: map[header] |> to_string()
    end
  end
end
