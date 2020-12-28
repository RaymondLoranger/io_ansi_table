defmodule IO.ANSI.Table.Spec.SortAttrs do
  @moduledoc """
  Derives the sort attributes of a table.
  """

  alias IO.ANSI.Table.{Header, Spec}

  @spec derive(Spec.t()) :: Spec.t()
  def derive(%Spec{headers: headers, sort_specs: sort_specs} = spec) do
    attrs = Enum.map(headers, &Header.find_attr(&1, sort_specs, :asc))
    put_in(spec.sort_attrs, attrs)
  end
end
