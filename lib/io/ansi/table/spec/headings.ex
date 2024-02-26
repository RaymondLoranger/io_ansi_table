defmodule IO.ANSI.Table.Spec.Headings do
  @moduledoc """
  Derives the headings of a table.
  """

  alias IO.ANSI.Table.{Header, Spec}

  @doc """
  Derives the headings of a table.

  ## Examples

      iex> alias IO.ANSI.Table.Spec.Headings
      iex> alias IO.ANSI.Table.Spec
      iex> spec = Spec.new([:c4, :c1, :c2], sort_specs: [:c4])
      iex> %Spec{headings: headings} = Headings.derive_and_put(spec)
      iex> headings
      ["C4↑", "C1", "C2"]

      iex> alias IO.ANSI.Table.Spec.Headings
      iex> alias IO.ANSI.Table.Spec
      iex> spec = Spec.new(
      ...>   ["station_id", "wind_mph"],
      ...>   sort_specs: ["station_id"],
      ...>   header_fixes: %{"Id" => "ID", "Mph" => "MPH"}
      ...> )
      iex> %Spec{headings: headings} = Headings.derive_and_put(spec)
      iex> headings
      ["Station ID↑", "Wind MPH"]
  """
  @spec derive_and_put(Spec.t()) :: Spec.t()
  def derive_and_put(%Spec{headers: headers} = spec) do
    headings = Enum.map(headers, &Header.to_heading(&1, spec))
    put_in(spec.headings, headings)
  end
end
