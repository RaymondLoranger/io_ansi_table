defmodule IO.ANSI.Table.Heading do
  @moduledoc """
  Functions related to the column headings of a table.
  """

  alias IO.ANSI.Table.{Column, Spec}

  @doc """
  Updates the headings of a table specification.

  ## Examples

      iex> alias IO.ANSI.Table.Heading
      iex> spec = %{
      ...>   headers: [:c4, :c1, :c2],
      ...>   header_fixes: %{},
      ...>   headings: [],
      ...>   sort_attrs: [:asc, nil, nil],
      ...>   sort_specs: [:c4],
      ...>   sort_symbols: [desc: "↓", pos: :trailing, asc: "↑"]
      ...> }
      iex> %{headings: headings} = Heading.headings(spec)
      iex> headings
      ["C4↑", "C1", "C2"]
  """
  @spec headings(Spec.t()) :: Spec.t()
  def headings(spec) do
    headings = Enum.map(spec.headers, &to_heading(&1, spec))
    %{spec | headings: headings}
  end

  ## Private functions

  # @doc """
  # Converts a `header` to a "heading".
  # """
  @spec to_heading(any, Spec.t()) :: String.t()
  defp to_heading(header, spec) do
    sort_symbol(header, spec, :leading) <>
      titlecase(header, spec) <>
      sort_symbol(header, spec, :trailing)
  end

  @spec sort_symbol(any, Spec.t(), atom) :: String.t()
  defp sort_symbol(header, spec, loc) do
    pos_list = [spec.sort_symbols[:pos]] |> List.flatten()
    dir = Column.find_attr(header, spec.sort_specs, :asc)
    (loc in pos_list && spec.sort_symbols[dir]) || ""
  end

  @spec titlecase(any, Spec.t()) :: String.t()
  defp titlecase(header, spec)
       # string, atom or charlist
       when is_binary(header) or is_atom(header) or is_list(header) do
    title =
      header
      |> to_string()
      |> String.split(~r/(_| )+/, trim: true)
      |> Enum.map_join(" ", &title/1)

    Enum.reduce(spec.header_fixes, title, &fix/2)
  end

  defp titlecase(header, _spec), do: inspect(header)

  # title("MPH") => "MPH"
  # title("miles") => "Miles"
  @spec title(String.t()) :: String.t()
  defp title(word) do
    word
    |> String.first()
    |> String.upcase()
    |> Kernel.<>(String.slice(word, 1..-1))
  end

  # fix({" Of ", " of "}, "Nbr Of Yrs") => "Nbr of Yrs"
  @spec fix(tuple, String.t()) :: String.t()
  defp fix({key, value}, title), do: String.replace(title, key, value)
end
